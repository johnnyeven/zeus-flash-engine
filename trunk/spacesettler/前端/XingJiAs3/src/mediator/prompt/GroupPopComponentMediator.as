package mediator.prompt
{
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ui.managers.PopUpManager;
	
	import view.prompt.GroupPopComponent;

	public class GroupPopComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupPopComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public var okCallBack:Function;
		public function GroupPopComponentMediator()
		{
			super(NAME, new GroupPopComponent());
			
			_popUp = true;
			mode = true;
			popUpEffect=CENTER;
			
			comp.med=this;
			level=0;
			
			comp.addEventListener(GroupPopComponent.OK_EVENT, okHandler);
			comp.addEventListener(GroupPopComponent.NO_EVENT, noHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,SHOW_NOTE];
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
				case SHOW_NOTE:
				{
					var obj:Object = note.getBody();	
					comp.infoTf.text=obj.name;
					okCallBack = obj.okCallBack;					
					show();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():GroupPopComponent
		{
			return viewComponent as GroupPopComponent;
		}
		
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}
		
		protected function noHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function okHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
			
			if (okCallBack != null)
				okCallBack();
			okCallBack = null;
		}

	}
}