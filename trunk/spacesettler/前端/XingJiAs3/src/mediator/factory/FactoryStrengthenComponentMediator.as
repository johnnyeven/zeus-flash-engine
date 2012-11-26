package mediator.factory
{
	import enum.factory.FactoryEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.factory.FactoryProxy;
	
	import view.factory.FactoryStrengthenComponent;

	public class FactoryStrengthenComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryStrengthenComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var _type:String;
		private var factoryProxy:FactoryProxy;
		public function FactoryStrengthenComponentMediator()
		{
			super(NAME, new FactoryStrengthenComponent());
			
			factoryProxy=getProxy(FactoryProxy);
			
			comp.med=this;
			level=2;
			comp.upData(FactoryEnum.CURRENT_ZHANCHE_VO);
			comp.addEventListener(FactoryEvent.QIANGHUA_EVENT,qiangHuaHandler);
			comp.addEventListener(FactoryEvent.CLOSE_EVENT,closeHandler);
		}
		
		protected function closeHandler(event:FactoryEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function qiangHuaHandler(event:FactoryEvent):void
		{
			_type=event.qiangHuatype;
			factoryProxy.enhance_chariot(FactoryEnum.CURRENT_ZHANCHE_VO.id,_type,event.count,function():void
			{
				comp.upData(FactoryEnum.CURRENT_ZHANCHE_VO);
			});
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
		protected function get comp():FactoryStrengthenComponent
		{
			return viewComponent as FactoryStrengthenComponent;
		}

	}
}