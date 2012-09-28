package mediator
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mediator.buildingView.SelectorViewComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ui.managers.SystemManager;


	public class MainMediator extends Mediator implements IMediator
	{
		public static const NAME:String="MainMediator";

		public static const SET_MOUSE_ENABLED:String="setMouseEnabled";
		public function MainMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			component.addEventListener(MouseEvent.CLICK,mainClickHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [SET_MOUSE_ENABLED];
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
				case SET_MOUSE_ENABLED:
				{
					var b:Boolean=Boolean(note.getBody());
					SystemManager.rootStage.mouseChildren=b;
					break;
			}
		}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		public function get component():Main
		{
			return viewComponent as Main;
		}
		
		public function addChild(skin:DisplayObject):void
		{
			component.addBase(skin);
		}
		
		public function removeChild(skin:DisplayObject):void
		{
			component.removeBase(skin);
		}
		
		protected function mainClickHandler(event:MouseEvent):void
		{
			sendNotification(SelectorViewComponentMediator.DESTROY_NOTE);			
			
		}
	}
}