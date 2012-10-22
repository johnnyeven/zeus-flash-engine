package view.email
{
	import com.zn.utils.ClassUtil;
	
	import enum.email.EmailTypeEnum;
	
	import events.email.EmailEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.TextInput;
	import ui.components.Window;
	import ui.core.Component;
	
	import vo.email.EmailItemVO;
	
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
			
			inforSprivate = otherSprite.createUI(Component,"inforSprivate");
			dirtBtn = inforSprivate.createUI(Button,"dirtBtn");
			sourceImage = inforSprivate.createUI(LoaderImage,"sourceImage");
			sourceCountLabel = inforSprivate.createUI(Label,"sourceCountLabel");
			costMoneyLabel = inforSprivate.createUI(Label,"costMoneyLabel");
			inforSprivate.sortChildIndex();
			otherSprite.sortChildIndex();
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			sendBtn.addEventListener(MouseEvent.CLICK,sendBtn_clickHAndler);
        }
		
		public function setData(data:EmailItemVO):void
		{
			titleTxt.text = data.title;
			senderLabel.text = data.receiver;
			receiverLabel.text = data.sender;
			
			friendListBtn.enabled = false;
			groupListBtn.enabled = false;
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
			receiverLabel.text = titleTxt.text;
//			var obj:Object = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text,attachment_type:null,attachment_count:0,attachment_id:null};
			var obj:Object = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text};
			dispatchEvent(new EmailEvent(EmailEvent.SEND_NEW_EMAIL_EVENT,obj));
		}
    }
}