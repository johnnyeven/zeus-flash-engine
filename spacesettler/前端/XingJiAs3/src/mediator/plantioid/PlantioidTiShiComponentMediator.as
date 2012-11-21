package mediator.plantioid
{
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.plantioid.PlantioidTiShiComponent;

	public class PlantioidTiShiComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="PlantioidTiShiComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var okCallFun:Function;
		public function PlantioidTiShiComponentMediator()
		{
			super(NAME, new PlantioidTiShiComponent());
			popUpEffect=CENTER;
			comp.med=this;
			level=1;
			
			comp.addEventListener(PlantioidTiShiComponent.NO_EVENT,closeHandler);
			comp.addEventListener(PlantioidTiShiComponent.OK_EVENT,sureHandler);
		}
		
		protected function closeHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function sureHandler(event:Event):void
		{			
			if(okCallFun!=null)
				okCallFun();
			okCallFun=null
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
		protected function get comp():PlantioidTiShiComponent
		{
			return viewComponent as PlantioidTiShiComponent;
		}
		
		public function upData(obj:Object):void
		{
			okCallFun=obj.okCallFun;
		}

	}
}