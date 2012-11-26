package view.email
{
	import com.adobe.fileformats.vcard.Email;
	import com.zn.utils.ClassUtil;
	
	import enum.email.EmailTypeEnum;
	import enum.item.ItemEnum;
	
	import events.email.EmailEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.Window;
	import ui.core.Component;
	
	import vo.email.EmailItemVO;
	
	/**
	 *查看邮件
	 * @author lw
	 *
	 */
    public class ViewEmailComponent extends Window
    {
		public var closeBtn:Button;
		public var dirtBtn:Button;
		public var callBackBtn:Button;
		
		public var titleLabel:Label;
		public var senderLabel:Label;
		public var receiverLabel:Label;
		
		public var sourceSprite:Component;
		public var receiveBtn:Button;
		public var sourceCountLabel:Label;
		public var tipsLabel:Label;
		public var sourceImage:LoaderImage;
		
		public var contentTxt:TextField;
		
		private var _data:EmailItemVO;
		private var userInforProxy:UserInfoProxy;
        public function ViewEmailComponent()
        {
            super(ClassUtil.getObject("view.email.ViewEmailSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			closeBtn = createUI(Button,"closeBtn");
			dirtBtn = createUI(Button,"dirtBtn");
			callBackBtn = createUI(Button,"callBackBtn");
			
			titleLabel = createUI(Label,"titleLabel");
			senderLabel = createUI(Label,"senderLabel");
			receiverLabel = createUI(Label,"receiverLabel");
			
			sourceSprite = createUI(Component,"sourceSprite");
			sourceSprite.visible = false;
			receiveBtn = sourceSprite.createUI(Button,"receiveBtn");
			receiveBtn.enabled = true;
			sourceCountLabel = sourceSprite.createUI(Label,"sourceCountLabel");
			tipsLabel = sourceSprite.createUI(Label,"tipsLabel");
			tipsLabel.visible = false;
			sourceImage = sourceSprite.createUI(LoaderImage,"sourceImage");
			sourceSprite.sortChildIndex();
			
			contentTxt = getSkin("contentTxt");
			sortChildIndex();
			
			dirtBtn.addEventListener(MouseEvent.CLICK,dirtBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			receiveBtn.addEventListener(MouseEvent.CLICK,receiveBtn_clickHandler);
			callBackBtn.addEventListener(MouseEvent.CLICK,callBackBtn_clickHandler);
        }
		
		
		public function set data(value:EmailItemVO):void
		{
			_data = value;
			if(_data)
			{
				titleLabel.text = _data.title;
				senderLabel.text = _data.sender;
				receiverLabel.text = _data.receiver;
				contentTxt.text = _data.content;
				if(_data.attachment)
				{
					sourceSprite.visible = true;
					switch(_data.attachment_type)
					{
						case ItemEnum.Chariot:
						{
							sourceImage.source = EmailTypeEnum.getEquipImageByEmailType(_data.attachment_type,_data.category);
							break;
						}
						case ItemEnum.TankPart:
						{
							sourceImage.source = EmailTypeEnum.getEquipImageByEmailType(_data.attachment_type,_data.category);
							break;
						}
						case ItemEnum.recipes:
						{
							sourceImage.source = EmailTypeEnum.getItemImageByEmailType(_data.attachment_type);
							break;
						}
						case ItemEnum.emailItem:
						{
							sourceImage.source = EmailTypeEnum.getVipImageByEmailKey("vip_level_"+_data.type);
							break;
						}
						case ItemEnum.CRYSTAL:
						{
							sourceImage.source = EmailTypeEnum.getSourceImageByEmailType(_data.attachment_type);
							break;
						}
						case ItemEnum.TRITIUM:
						{
							sourceImage.source = EmailTypeEnum.getSourceImageByEmailType(_data.attachment_type);
							break;
						}
						case ItemEnum.BROKENCRYSTAL:
						{
							sourceImage.source = EmailTypeEnum.getSourceImageByEmailType(_data.attachment_type);
							break;
						}
					}
					sourceCountLabel.text = "X" + _data.attachment_count +"";
					if(_data.receive_attachment)
					{
						tipsLabel.visible = true;
						receiveBtn.enabled = false;
					}
					else
					{
						tipsLabel.visible = false;
						receiveBtn.enabled = true;
					}
				}
			}
		}
		
		public function receive_attachment():void
		{
			tipsLabel.visible = true;
			receiveBtn.enabled = false;
		}
		
		private function receiveBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new EmailEvent(EmailEvent.RECEIVE_SOURCE_EVENT,_data.id,true,true));
		}

		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("closeViewEmailComponent"));
		}
		
		private function dirtBtn_clickHandler(event:MouseEvent):void
		{
			var arrJson:Array = [];
			if(_data)
			{
				arrJson.push(_data.id);
				dispatchEvent(new EmailEvent(EmailEvent.DELETE_EMAIL_BY_VIEW_COMPONENT_EVENT,arrJson));
				dispatchEvent(new Event("closeViewEmailComponent"));
			}
			
		}
		
		private function callBackBtn_clickHandler(event:MouseEvent):void
		{
			if(_data)
			{
				_data.title = "回复"+ _data.sender +"的邮件";
				dispatchEvent(new EmailEvent(EmailEvent.CALL_BACK_EMAIL_EVENT,_data));
			}
			
		}
    }
}