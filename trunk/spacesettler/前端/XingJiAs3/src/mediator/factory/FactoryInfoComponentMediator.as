package mediator.factory
{
	import enum.factory.FactoryEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.factory.FactoryInfoComponent;

	public class FactoryInfoComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryInfoComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function FactoryInfoComponentMediator()
		{
			super(NAME, new FactoryInfoComponent());
			
			comp.med=this;
			level=2;
			
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

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():FactoryInfoComponent
		{
			return viewComponent as FactoryInfoComponent;
		}
		
		public function changePage(type:String):void
		{
			if(type==FactoryEnum.WEIXIU_FACTORY)	
				comp.isWeiXiu();
			if(type==FactoryEnum.GAIZHUANG_FACTORY)	
				comp.isGaiZhuang();
			if(type==FactoryEnum.ZHIZAO_FACTORY)	
				comp.isZhiZao();				
		}

	}
}