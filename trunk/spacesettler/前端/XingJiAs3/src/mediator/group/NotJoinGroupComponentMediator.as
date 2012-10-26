package mediator.group
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.GroupPopComponentMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.group.NotJoinGroupComponent;

	public class NotJoinGroupComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="NotJoinGroupComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		
		private var userProxy:UserInfoProxy;
		private var groupProxy:GroupProxy;
		public function NotJoinGroupComponentMediator()
		{
			super(NAME, new NotJoinGroupComponent());
			
			userProxy=getProxy(UserInfoProxy);
			groupProxy=getProxy(GroupProxy);
			
			level=0;
			comp.addEventListener(GroupEvent.CREAT_GROUP,creatGroupHandler);
			comp.addEventListener(GroupEvent.APPLYJOIN_GROUP,applyJoinGroupHandler);
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,closeClickHandler);
		}
		
		protected function applyJoinGroupHandler(event:GroupEvent):void
		{			
			groupProxy.applyjoinGroup(userProxy.userInfoVO.player_id,event.id,function():void
			{
				sendNotification(GroupComponentMediator.SHOW_NOTE);
			});			
		}
		
		protected function creatGroupHandler(event:GroupEvent):void
		{
			
			var obj:Object={};
			obj.info=MultilanguageManager.getString("foundGroup");
			obj.count="100";
			obj.okCallBack=function():void
			{
				groupProxy.createGroup(userProxy.userInfoVO.player_id,event.groupName,"",function():void					
				{
					sendNotification(DESTROY_NOTE);					
					sendNotification(GroupComponentMediator.SHOW_NOTE);
				});
			}
			sendNotification(MoneyAlertComponentMediator.SHOW_NOTE,obj);			
		}
		
		protected function closeClickHandler(event:GroupShowAndCloseEvent):void
		{
			sendNotification(DESTROY_NOTE);
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
		protected function get comp():NotJoinGroupComponent
		{
			return viewComponent as NotJoinGroupComponent;
		}

	}
}