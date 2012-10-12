package mediator.crystalSmelter
{
	import events.crystalSmelter.CrystalSmelterEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.buildingView.YeLianInfoComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.crystalSmelter.CrystalSmelterProxy;
	
	import view.cryStalSmelter.CrystalSmelterFunctionComponent;

	/**
	 * 熔炼（晶体冶炼厂）
	 * @author lw
	 *
	 */
	public class CrystalSmelterFunctionComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="CrystalSmelterFunctionComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function CrystalSmelterFunctionComponentMediator()
		{
			super(NAME, new CrystalSmelterFunctionComponent());
			
			comp.addEventListener(CrystalSmelterEvent.INFOR_EVENT,inforHandler);
			comp.addEventListener(CrystalSmelterEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(CrystalSmelterEvent.SMELTER_EVENT,smelterHandler);
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
		protected function get comp():CrystalSmelterFunctionComponent
		{
			return viewComponent as CrystalSmelterFunctionComponent;
		}

		private function inforHandler(event:CrystalSmelterEvent):void
		{
			sendNotification(YeLianInfoComponentMediator.SHOW_NOTE);
		}
		
		private function smelterHandler(event:CrystalSmelterEvent):void
		{
			var crystalSmelteProxy:CrystalSmelterProxy = getProxy(CrystalSmelterProxy);
			crystalSmelteProxy.smelte();
		}
	}
}