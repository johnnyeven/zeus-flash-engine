package view.email
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.ObjectUtil;
	import com.zn.utils.StringUtil;
	
	import enum.email.EmailTypeEnum;
	import enum.item.ItemEnum;
	import enum.science.ScienceEnum;
	
	import events.email.EmailEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.scienceResearch.ScienceResearchProxy;
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
	import vo.group.GroupMemberListVo;
	import vo.scienceResearch.ScienceResearchVO;
	
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
		
		public var vipMc:Sprite;
		public var numLable:Label;
		
		//组装数据
		private var obj:Object = {};
		private var hasFuJian:Boolean = false;
		
		private var userInforProxy:UserInfoProxy;
		private var scienceResearchProxy:ScienceResearchProxy;
	    private var techDicObj:Object;
		private var obj1:Object = {};
		private var scienceLevel:int;
        public function SendEmailComponent()
        {
            super(ClassUtil.getObject("view.email.SendEmailSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			scienceResearchProxy= ApplicationFacade.getProxy(ScienceResearchProxy);
			techDicObj = ObjectUtil.CreateDic(scienceResearchProxy.reaearchList,"science_type");
			obj1 = techDicObj[6];
			if(obj1)
			{
				scienceLevel = obj1.level;
			}
			else
			{
				scienceLevel =0;
			}
			
			closeBtn = createUI(Button,"closeBtn");
			friendListBtn = createUI(Button,"friendListBtn");
			groupListBtn = createUI(Button,"groupListBtn");
			sendBtn = createUI(Button,"sendBtn");
			numLable = createUI(Label,"numLable")
			
			vipMc = getSkin("vipMc");
			titleTxt = getSkin("titleTxt");
			titleTxt.mouseEnabled = true;
			contentTxt = getSkin("contentTxt");
			contentTxt.mouseEnabled = true;
			contentTxt.text = "";
			titleTxt.addEventListener(MouseEvent.CLICK,titleTxt_clickHandler);
//			chatText.addEventListener(TextEvent.TEXT_INPUT, textChange_handler);
//			chatText.addEventListener(KeyboardEvent.KEY_UP, keyUp_clickHandler);
			senderLabel = createUI(Label,"senderLabel");
			receiverLabel = createUI(Label,"receiverLabel");
			receiverLabel.text = "点击好友或军团按钮选择收件人";
			senderLabel.text = userInforProxy.userInfoVO.nickname;
//			receiverLabel.text = titleTxt.text;
			
			
			otherSprite = createUI(Component,"otherSprite")
				
			btnSprite = otherSprite.createUI(Component,"btnSprite");
			sendSourceBtn = btnSprite.createUI(Button,"sendSourceBtn");
			sendObjBtn = btnSprite.createUI(Button,"sendObjBtn");
			btnSprite.sortChildIndex();
			btnSprite.visible = true;
			vipMc.visible=numLable.visible=false;
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
			
			vipTiShiShow();
			removeCWList();
			cwList.push(BindingUtils.bindSetter(function():void
			{
				if(StringUtil.isEmpty(userInforProxy.userInfoVO.legion_id))
				{
					groupListBtn.enabled = false;
				}
				else
				{
					groupListBtn.enabled = true;
				}
			},userInforProxy,["userInfoVO","legion_id"]));
			groupListBtn.addEventListener(MouseEvent.CLICK,groupListBtn_clickHandler);
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
			if(userInforProxy.userInfoVO.vip_mail>0)
				costMoneyLabel.text="0";
			else
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
	
			sourceCountLabel.text = "X"+baseItemData.count +"";
			if(userInforProxy.userInfoVO.vip_mail>0)
				costMoneyLabel.text="0";
			else
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
		}
		
		//从好友列表发送的邮件数据
		public function friendListData(friendInforVO:FriendInfoVo):void
		{
			senderLabel.text = userInforProxy.userInfoVO.nickname;
			receiverLabel.text = friendInforVO.nickname;
			
			friendListBtn.visible = true;
		}
		
		//从军团列表发送的邮件数据
		public function armyGroupListData(armyGroupMemberListVo:GroupMemberListVo):void
		{
			senderLabel.text = userInforProxy.userInfoVO.nickname;
			receiverLabel.text = armyGroupMemberListVo.username;
			groupListBtn.visible = true;
		}
		
		private function closeBtnHandler(event:MouseEvent):void
		{
			dispatchEvent(new EmailEvent(EmailEvent.CLOSE_SEND_EMAIL_EVENT));
		}
		
		private function sendBtn_clickHAndler(event:MouseEvent):void
		{
			if(titleTxt.text == "点击这里输入邮件标题" ||titleTxt.text == "")
			{
				titleTxt.text = "来自"+ senderLabel.text +"的邮件";
//				dispatchEvent(new Event("titleTextNull"));
			}
		    if(senderLabel.text == "")
			{
				dispatchEvent(new Event("senderLabelNull"));
				return;
			}
		    if(receiverLabel.text == "点击好友或军团按钮选择收件人")
			{
				dispatchEvent(new Event("receiverLabelNull"));
				return;
			}
		    if(contentTxt.text == "")
			{
				dispatchEvent(new Event("contentTxtNull"));
				return;
			}
//			receiverLabel.text = titleTxt.text;
			if(!hasFuJian)
			{
			   obj = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text};
			}
			else
			{
				obj.title = titleTxt.text;
				obj.content=contentTxt.text;
			}
//			var obj:Object = {type:EmailTypeEnum.PERSONEL_TYPE,sender:senderLabel.text,receiver:receiverLabel.text,title:titleTxt.text,content:contentTxt.text,attachment_type:null,attachment_count:0,attachment_id:null};
			obj.receiver=receiverLabel.text;
			dispatchEvent(new EmailEvent(EmailEvent.SEND_NEW_EMAIL_EVENT,obj));
		}
		
		private function dirtBtn_clickHandler(event:MouseEvent):void
		{
			btnSprite.visible = true;
			inforSprivate.visible = false;
		}
		
		private function sendObjBtn_clickHandler(event:MouseEvent):void
		{
			if(scienceLevel < 10)
			{
				//星域通讯科技要求10级以上
				dispatchEvent(new Event("scienceLevelEvent"));
				return;
			}
			//战车或挂件
			dispatchEvent(new Event("showItemListEvent"));
		}
		
		private function vipTiShiShow():void
		{
			if(userInforProxy.userInfoVO.vip_mail>0)
			{
				numLable.text=String(userInforProxy.userInfoVO.vip_mail);
				vipMc.visible=numLable.visible=true;
			}
		}
		
		private function sendSourceBtn_clickHandler(event:MouseEvent):void
		{
			if(scienceLevel < 10)
			{
				//星域通讯科技要求10级以上
				dispatchEvent(new Event("scienceLevelEvent"));
				return;
			}
			
			//资源
			dispatchEvent(new Event("showSourceListEvent"));
		}
		
		private function friendListBtn_clickHandler(event:MouseEvent):void
		{
			//好友列表
			dispatchEvent(new EmailEvent(EmailEvent.SHOW_FRIEND_LIST_EVENT));
		}
		
		private function groupListBtn_clickHandler(event:MouseEvent):void
		{
			//军团成员列表
			dispatchEvent(new EmailEvent(EmailEvent.SHOW_ARMY_GROUP_LIST_EVENT));
		}
		
		private function titleTxt_clickHandler(event:MouseEvent):void
		{
			titleTxt.text = "";
		}
    }
}