package mediator.email
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.email.EmailEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.friendList.FriendListComponentMediator;
	import mediator.group.GroupMemberComponentMediator;
	import mediator.prompt.PromptSureMediator;
	import mediator.showBag.ShowBagComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.email.EmailProxy;
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.email.SendEmailComponent;
	
	import vo.allView.FriendInfoVo;
	import vo.cangKu.BaseItemVO;
	import vo.email.EmailItemVO;
	import vo.email.SourceItemVO;
	import vo.group.GroupMemberListVo;

	/**
	 * 发送新邮件
	 * @author lw
	 *
	 */
	public class SendEmailComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="SendEmailComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		/**
		 * 回复邮件数据
		 */		
		public static const CALL_BACK_EMAIL:String = "call" + NAME +"back_email";
		
		/**
		 * 选择的资源数据
		 */	
		public static const SELECTED_SOURCE_DATA:String = "selected" + NAME + "sourceData";
		
		/**
		 * 选择的战车或挂件的数据
		 */	
		public static const SELECTED_ITEM_DATA:String = "selected" + NAME + "itemData";
		
		/**
		 * 从军官证发送的邮件数据
		 */	
		public static const SEND_EMAIL_DATA_BY_ID_CARD:String = "sendEmailData" + NAME+"byIcCard";
		
		/**
		 * 从好友列表发送的邮件数据
		 */	
		public static const SEND_EMAIL_DATA_BY_FRIEND_LISE:String = "sendEmailData" + NAME + "byFriendList";
		
		/**
		 * 从军团列表发送的邮件数据
		 */	
		public static const SEND_EMAIL_DATA_BY_ARMY_GROUP_LISE:String = "sendEmailData" + NAME + "byArmyGroupList";
		 
		private var emailProxy:EmailProxy;
		private var userInforProxy:UserInfoProxy;
		private var groupProxy:GroupProxy;
		public function SendEmailComponentMediator()
		{
			super(NAME, new SendEmailComponent());
			comp.med=this;
			level = 3;
			emailProxy = getProxy(EmailProxy);
			userInforProxy = getProxy(UserInfoProxy);
			groupProxy=getProxy(GroupProxy);
			comp.addEventListener(EmailEvent.CLOSE_SEND_EMAIL_EVENT,closeHandler);
			comp.addEventListener(EmailEvent.SEND_NEW_EMAIL_EVENT,sendNewEmailHandler);
			comp.addEventListener("showItemListEvent",showItemListHandler);
			comp.addEventListener("showSourceListEvent",showSourceListHandler);
			comp.addEventListener(EmailEvent.SHOW_FRIEND_LIST_EVENT,showFriendListHandler);
			comp.addEventListener(EmailEvent.SHOW_ARMY_GROUP_LIST_EVENT,showArmyGroupListHandler);
			comp.addEventListener("titleTextNull",titleTextNullHandler);
			comp.addEventListener("senderLabelNull",senderLabelNullHandler);
			comp.addEventListener("receiverLabelNull",receiverLabelHandler);
			comp.addEventListener("contentTxtNull",contentTxtHandler);
			comp.addEventListener("scienceLevelEvent",scienceLevelHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,CALL_BACK_EMAIL,
				SELECTED_SOURCE_DATA,SELECTED_ITEM_DATA,
				SEND_EMAIL_DATA_BY_FRIEND_LISE,
				SEND_EMAIL_DATA_BY_ARMY_GROUP_LISE,
				SEND_EMAIL_DATA_BY_ID_CARD];
		}

		/**
		 *消息处理
		 * @param note
		 *
		 */
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case DESTROY_NOTE:
				{
					//销毁对象
					destroy();
					break;
				}
				case CALL_BACK_EMAIL:
				{
					//回复邮件的数据控制
					comp.setData(note.getBody() as EmailItemVO);
					break;
				}
				case SELECTED_SOURCE_DATA:
				{
					//选择的资源数据
					comp.setSourceData(note.getBody() as SourceItemVO);
					break;
				}
				case SELECTED_ITEM_DATA:
				{
					//选择的战车或挂件的数据
					comp.setItemData(note.getBody() as BaseItemVO);
					break;
				}
				case SEND_EMAIL_DATA_BY_ID_CARD:
				{
					//从军官证发送邮件的数据
					comp.idCardEmailData(note.getBody() as FriendInfoVo);
					break;
				}
				case SEND_EMAIL_DATA_BY_FRIEND_LISE:
				{
					//从好友列表发送的邮件数据
					comp.friendListData(note.getBody() as FriendInfoVo);
					break;
				}
				case SEND_EMAIL_DATA_BY_ARMY_GROUP_LISE:
				{
					//从军团列表发送的邮件数据
					comp.armyGroupListData(note.getBody() as GroupMemberListVo);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():SendEmailComponent
		{
			return viewComponent as SendEmailComponent;
		}
		
		private function sendNewEmailHandler(event:EmailEvent):void
		{
			emailProxy.sendEmail(event.obj);
			sendNotification(DESTROY_NOTE);
		}
		
		private function showItemListHandler(event:Event):void
		{
			//标记是邮件需要的数据
			var obj:Object = {isEmail:true};
			sendNotification(ShowBagComponentMediator.SHOW_NOTE,obj);
		}
		
		private function showSourceListHandler(event:Event):void
		{
			sendNotification(SourceSendComponentMediator.SHOW_NOTE);
		}
		
		private function showFriendListHandler(event:EmailEvent):void
		{
			var obj:Object = {playerID:userInforProxy.userInfoVO.player_id,mediatorLevel:level,isSendEmail:true}
			sendNotification(FriendListComponentMediator.DESTROY_NOTE);
			sendNotification(FriendListComponentMediator.SHOW_NOTE,obj);
		}
		
		private function showArmyGroupListHandler(event:EmailEvent):void
		{
			var obj:Object = {mediatorLevel:level,isSendEmailGroup:true};
			groupProxy.groupMemberList(userInforProxy.userInfoVO.legion_id,function():void
			{			
				sendNotification(GroupMemberComponentMediator.DESTROY_NOTE);
				sendNotification(GroupMemberComponentMediator.SHOW_NOTE,obj);
			});	
		}
		
		private function titleTextNullHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("titleInEmail"),showLable:MultilanguageManager.getString("titleTextNull"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
		
		private function senderLabelNullHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("titleInEmail"),showLable:MultilanguageManager.getString("senderLabelNull"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
		
		private function receiverLabelHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("titleInEmail"),showLable:MultilanguageManager.getString("receiverLabelNull"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
		
		private function contentTxtHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("titleInEmail"),showLable:MultilanguageManager.getString("contentTxtNull"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
		
		private function scienceLevelHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("scienceLevelTitle"),showLable:MultilanguageManager.getString("scienceLevelInfor"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}

	}
}