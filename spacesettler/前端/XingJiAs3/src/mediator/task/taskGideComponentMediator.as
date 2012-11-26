package mediator.task
{
	import flash.display.DisplayObjectContainer;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ui.managers.PopUpManager;
	import ui.managers.SystemManager;
	
	import view.task.TaskGideViewComponent;

	public class taskGideComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="taskGideComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function taskGideComponentMediator()
		{
			super(NAME, new TaskGideViewComponent());
			
			_popUp=false;
			comp.med=this;
			level=0;
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
		protected function get comp():TaskGideViewComponent
		{
			return viewComponent as TaskGideViewComponent;
		}
		
		public function setAddress(obj:DisplayObjectContainer):void
		{
			comp.setAddress(obj);
		}
		
		public override function show():void
		{
			var p:DisplayObjectContainer=comp.objContainer.parent;
			var p1:DisplayObjectContainer=p.parent;
//			SystemManager.instance.addInfo(comp);
			if(p1==null)
				p.addChild(comp);
			else
				p1.addChild(comp);
				
//			PopUpManager.addPopUp(comp);
		}

	}
}