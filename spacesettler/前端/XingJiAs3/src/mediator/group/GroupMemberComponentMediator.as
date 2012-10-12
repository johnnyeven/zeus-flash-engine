package mediator.group
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptCloseMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
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
			comp.addEventListener(GroupEvent.DISMISS_GROUP,dissMissGroup);
			comp.addEventListener(GroupEvent.QUITE_GROUP,quiteGroup);
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
		
		protected function dissMissGroup(event:GroupEvent):void
		{
			var obj:Object={};
			obj.infoLable=MultilanguageManager.getString("jiesan");
			obj.showLable=MultilanguageManager.getString("jiesanjuntuan");
			obj.okCallBack=function():void
			{
				groupProxy.dismissGroup(event.id,function():void
				{
					var obj1:Object={}
					obj1.showLable=MultilanguageManager.getString("jiesanchenggong");
					sendNotification(PromptCloseMediator.SHOW_NOTE,obj1);
					sendNotification(GroupComponentMediator.DESTROY_NOTE);
				});
			}
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
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
	}
}