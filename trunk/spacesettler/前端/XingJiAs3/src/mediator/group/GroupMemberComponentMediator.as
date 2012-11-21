package mediator.group
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.email.EmailEvent;
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.email.SendEmailComponentMediator;
	import mediator.friendList.ViewIdCardComponentMediator;
	import mediator.prompt.PromptCloseMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.friendList.FriendProxy;
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.group.GroupMemberComponent;

	public class GroupMemberComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupMemberComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var groupProxy:GroupProxy;
		private var userProxy:UserInfoProxy;
		public function GroupMemberComponentMediator()
		{
			super(NAME, new GroupMemberComponent());
			groupProxy=getProxy(GroupProxy);
			userProxy=getProxy(UserInfoProxy);
			comp.med=this;
			level=2;
			
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,doCloseHandler);
			comp.addEventListener(GroupEvent.QUITE_GROUP,quiteGroup);
			comp.addEventListener(GroupEvent.CHENK_ID_CARD_BY_ARMY_GROUP_EVENT,checkIdCardhandler);
			comp.addEventListener(EmailEvent.SEND_ARMY_GROUP_INFOR_TO_EMAIL_EVENT,armyGroupInforToEmailHandler);
			comp.addEventListener("notSelectedOwn",notSelectedOwnHandler);
		}
		
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
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
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():GroupMemberComponent
		{
			return viewComponent as GroupMemberComponent;
		}		
		
		/**
		 * 设置mediator的显示层级
		 * @param mediatorLevel
		 * 
		 */		
		public function setMediatorLevel(mediatorLevel:int):void
		{
			comp.med=this;
			level = mediatorLevel;
		}
		
		public function setIsSendEmailGroup(vaule:Boolean):void
		{
			comp.isSendEmailGroup = vaule;
		}
		
		protected function quiteGroup(event:GroupEvent):void
		{
			var obj:Object={};
			obj.infoLable=MultilanguageManager.getString("tuichu");
			obj.showLable=MultilanguageManager.getString("tuichujuntuan");
			obj.okCallBack=function():void
			{
				groupProxy.quitGroup(userProxy.userInfoVO.player_id,event.id,function():void
				{
					var obj1:Object={}
					obj1.showLable=MultilanguageManager.getString("tuichuchenggong");
					sendNotification(PromptCloseMediator.SHOW_NOTE,obj1);
					sendNotification(GroupComponentMediator.DESTROY_NOTE);
				});
			}
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			
		}
		
		protected function doCloseHandler(event:GroupShowAndCloseEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		private function checkIdCardhandler(event:GroupEvent):void
		{
			var friendProxy:FriendProxy = getProxy(FriendProxy);
			friendProxy.checkOtherPlayer(event.id,function():void
			{
				sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
			});
		}
		
		private function armyGroupInforToEmailHandler(event:EmailEvent):void
		{
			sendNotification(DESTROY_NOTE);
		    sendNotification(SendEmailComponentMediator.SEND_EMAIL_DATA_BY_ARMY_GROUP_LISE,event.obj);
		}
		
		private function notSelectedOwnHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("armyGroupTitle"),showLable:MultilanguageManager.getString("armyGroupInfor"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
		
	}
}