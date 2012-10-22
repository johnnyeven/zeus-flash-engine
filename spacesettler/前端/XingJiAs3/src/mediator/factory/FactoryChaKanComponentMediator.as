package mediator.factory
{
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.factory.FactoryChaKanComponent;

	public class FactoryChaKanComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryChaKanComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function FactoryChaKanComponentMediator()
		{
			super(NAME, new FactoryChaKanComponent());
			comp.med=this;
			level=3;
			
			comp.addEventListener(FactoryEvent.CLOSE_EVENT,closeHandler);
		}
		
		protected function closeHandler(event:FactoryEvent):void
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
		
		public function upData(obj:Object):void
		{
			if(obj.type==ItemEnum.Chariot)
				comp.upDataZhanChe(FactoryEnum.CURRENT_ZHIZAO_VO);
			if(obj.type==ItemEnum.TankPart)
				comp.upDataGuaJian(FactoryEnum.CURRENT_GUAJIAN_VO);
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():FactoryChaKanComponent
		{
			return viewComponent as FactoryChaKanComponent;
		}

	}
}