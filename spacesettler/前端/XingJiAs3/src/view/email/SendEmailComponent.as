package view.email
{
	import com.zn.utils.ClassUtil;
	
	import enum.email.EmailTypeEnum;
	
	import events.email.EmailEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.TextInput;
	import ui.components.Window;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	import vo.cangKu.BaseItemVO;
	import vo.email.EmailItemVO;
	import vo.email.SourceItemVO;
	
	/**
	 * 发送新邮件
	 * @author lw
	 *
	 */
    public class SendEmailComponent extends Window
    {
		public var closeBtn:Button;
		public var friendListBtn:Button;
		public var groupListBtn:Button;
		public var sendBtn:Button;
		
		public var titleTxt:TextField;
		public var senderLabel:Label;
		public var receiverLabel:Label;
		public var contentTxt:TextField;
		
		public var otherSprite:Component;
		
		public var btnSprite:Component;
		public var sendSourceBtn:Button;
		public var sendObjBtn:Button;
		
		public var inforSprivate:Component;
		public var dirtBtn:Button;
		
		public var sourceImage:LoaderImage;
		public var sourceCountLabel:Label;
		public var costMoneyLabel:Label;
		
		//组装数据
		private var obj:Object = {};
		private var hasFuJian:Boolean = false;
		
		private var userInforProxy:UserInfoProxy;
        public function SendEmailComponent()
        {
            super(ClassUtil.getObject("view.email.SendEmailSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			closeBtn = createUI(Button,"closeBtn");
			friendListBtn = createUI(Button,"friendListBtn");
			groupListBtn = createUI(Button,"groupListBtn");
			sendBtn = createUI(Button,"sendBtn");
			
			titleTxt = getSkin("titleTxt");
			titleTxt.mouseEnabled = true;
			contentTxt = getSkin("contentTxt");
			contentTxt.mouseEnabled = true;
//			chatText.addEventListener(TextEvent.TEXT_INPUT, textChange_handler);
//			chatText.addEventListener(KeyboardEvent.KEY_UP, keyUp_clickHandler);
			senderLabel = createUI(Label,"senderLabel");
			receiverLabel = createUI(Label,"receiverLabel");
			senderLabel.text = userInforProxy.userInfoVO.nickname;
			receiverLabel.text = titleTxt.text;
			
			
			otherSprite = createUI(Component,"otherSprite")
				
			btnSprite = otherSprite.createUI(Component,"btnSprite");
			sendSourceBtn = btnSprite.createUI(Button,"sendSourceBtn");
			sendObjBtn = btnSprite.createUI(Button,"sendObjBtn");
			btnSprite.sortChildIndex();
			btnSprite.visible = true;
			
			inforSprivate = otherSprite.createUI(Component,"inforSprivate");
			dirtBtn = inforSprivate.createUI(Button,"dirtBtn");
			sourceImage = inforSprivate.createUI(LoaderImage,"sourceImage");
			sourceCountLabel = inforSprivate.createUI(Label,"sourceCountLabel");
			costMoneyLabel = inforSprivate.createUI(Label,"costMoneyLabel");
			inforSprivate.sortChildIndex();
			inforSprivate.visible = false;
			otherSprite.sortChildIndex();
			sortChildIndex();
			//组件的初始化（组件都可用）
			friendListBtn.visible = true;
			groupListBtn.visible = true;
			
			friendListBtn.enabled = true;
			groupListBtn.enabled = true;
			
			dirtBtn.addEventListener(MouseEvent.CLICK,dirtBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			sendBtn.addEventListener(MouseEvent.CLICK,sendBtn_clickHAndler);
			sendSourceBtn.addEventListener(MouseEvent.CLICK,sendSourceBtn_clickHandler);
			sendObjBtn.addEventListener(MouseEvent.CLICK,sendObjBtn_clickHandler);
			
			friendListBtn.addEventListener(MouseEvent.CLICK,friendListBtn_clickHandler);
        }
		//回复邮件的数据控制
		public function setData(data:EmailItemVO):void
		{
			titleTxt.text = data.title;
			senderLabel.text = data.receiver;
			receiverLabel.text = data.sender;
			
			friendListBtn.enabled = false;
			groupListBtn.enabled = false;
			hasFuJian = false;
		}
		//选择的资源数据
		public function setSourceData(sourceData:SourceItemVO):void
		{
			btnSprite.visible = false;
			inforSprivate.visible = true;
			sourceImage.source = EmailTypeEnum.getSourceImageByEmailType(sourceData.attachment_type);
			sourceCountLabel.text = sourceData.attachment_count +"";
			costMoneyLabel.text = sourceData.costMoney +"";
			hasFuJian = true;
//			receiverLabel.text = titleTxt.text;
			//选择了资源
			obj = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text,attachment_type:sourceData.attachment_type,attachment_count:sourceData.attachment_count};
		}
		//选择的战车或挂件的数据
		public function setItemData(baseItemData:BaseItemVO):void
		{
			btnSprite.visible = false;
			inforSprivate.visible = true;
			sourceImage.source = EmailTypeEnum.getEquipImageByEmailType(baseItemData.item_type,baseItemData.category);
			sourceCountLabel.text = baseItemData.count +"";
			costMoneyLabel.text =  EmailTypeEnum.getItemCostByItemInfor(baseItemData.value,baseItemData.level,baseItemData.enhanced) +"";
			hasFuJian = true;
//			receiverLabel.text = titleTxt.text;
			//选择了武器或者挂件
		    obj = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text,attachment_type:baseItemData.item_type,attachment_count:baseItemData.count,attachment_id:baseItemData.id};
		}
		
		//从军官证发送邮件的数据
		public function idCardEmailData(playerIDCardVO:FriendInfoVo):void
		{
			senderLabel.text = userInforProxy.userInfoVO.nickname;
			receiverLabel.text = playerIDCardVO.nickname;
			
			friendListBtn.visible = false;
			groupListBtn.visible = false;
			hasFuJian = false;
		}
		
		//从好友列表发送的邮件数据
		public function friendListData(friendInforVO:FriendInfoVo):void
		{
			senderLabel.text = userInforProxy.userInfoVO.nickname;
			receiverLabel.text = friendInforVO.nickname;
			
			friendListBtn.visible = true;
			groupListBtn.visible = true;
			hasFuJian = false;
		}
		
		private function closeBtnHandler(event:MouseEvent):void
		{
			dispatchEvent(new EmailEvent(EmailEvent.CLOSE_SEND_EMAIL_EVENT));
		}
		
		private function sendBtn_clickHAndler(event:MouseEvent):void
		{
			if(titleTxt.text == "" || senderLabel.text == "" || receiverLabel.text == "" || contentTxt.text == "")
			{
				return;
			}
//			receiverLabel.text = titleTxt.text;
			if(!hasFuJian)
			{
			   obj = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text};
			}
//			var obj:Object = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text,attachment_type:null,attachment_count:0,attachment_id:null};
			
			dispatchEvent(new EmailEvent(EmailEvent.SEND_NEW_EMAIL_EVENT,obj));
		}
		
		private function dirtBtn_clickHandler(event:MouseEvent):void
		{
			btnSprite.visible = true;
			inforSprivate.visible = false;
		}
		
		private function sendObjBtn_clickHandler(event:MouseEvent):void
		{
			//战车或挂件
			dispatchEvent(new Event("showItemListEvent"));
		}
		
		private function sendSourceBtn_clickHandler(event:MouseEvent):void
		{
			//资源
			dispatchEvent(new Event("showSourceListEvent"));
		}
		
		private function friendListBtn_clickHandler(event:MouseEvent):void
		{
			//好友列表
			dispatchEvent(new EmailEvent(EmailEvent.SHOW_FRIEND_LIST_EVENT));
		}
    }
}