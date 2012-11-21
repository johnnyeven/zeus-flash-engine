package mediator.groupFight.tiShi
{
	import events.groupFight.GroupFightEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.groupFight.tiShi.GroupFightThreeComponent;

	public class GroupFightThreeComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightThreeComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var okCallFun:Function;
		public function GroupFightThreeComponentMediator()
		{
			super(NAME, new GroupFightThreeComponent());
			popUpEffect=CENTER;
			comp.med=this;
			level=3;
			
			comp.addEventListener(GroupFightEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(GroupFightEvent.SURE_EVENT,sureHandler);
		}
		
		protected function sureHandler(event:GroupFightEvent):void
		{
			if(okCallFun!=null)
				okCallFun();
			okCallFun=null;
			sendNotification(DESTROY_NOTE);
		}
		
		protected function closeHandler(event:GroupFightEvent):void
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
		protected function get comp():GroupFightThreeComponent
		{
			return viewComponent as GroupFightThreeComponent;
		}
		
		public function upData(obj:Object):void
		{
			comp.numLable.text="X"+String(obj.num);
			okCallFun=obj.fun;
		}

	}
}