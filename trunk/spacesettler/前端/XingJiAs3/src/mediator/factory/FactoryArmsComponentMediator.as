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
	
	import proxy.battle.BattleProxy;
	import proxy.factory.FactoryProxy;
	import proxy.packageView.PackageViewProxy;
	
	import view.factory.FactoryArmsComponent;

	public class FactoryArmsComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryArmsComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var battleProxy:BattleProxy;
		private var pageProxy:PackageViewProxy;
		private var factoryProxy:FactoryProxy;
		
		public function FactoryArmsComponentMediator()
		{
			super(NAME, new FactoryArmsComponent());
			comp.med=this;
			level=2;
			
			battleProxy=getProxy(BattleProxy);
			pageProxy=getProxy(PackageViewProxy);
			factoryProxy=getProxy(FactoryProxy);
			
			comp.addEventListener(FactoryEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(FactoryEvent.LOAD_ZHANCHE_COMPLETE_EVENT,loadZhanCheHandler);
			comp.addEventListener(FactoryEvent.LOAD_GUAJIAN_COMPLETE_EVENT,loadGuaJianHandler);
		}
		
		protected function loadGuaJianHandler(event:FactoryEvent):void
		{
			factoryProxy.mount(FactoryEnum.CURRENT_ZHANCHE_VO.id,FactoryEnum.CURRENT_GUAJIAN_VO.id,FactoryEnum.CURRENT_POSITION,function():void
			{
				sendNotification(DESTROY_NOTE);
			});
		}
		
		protected function loadZhanCheHandler(event:FactoryEvent):void
		{
			sendNotification(FactoryChangeComponentMediator.SHOW_NOTE);
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
		public function get comp():FactoryArmsComponent
		{
			return viewComponent as FactoryArmsComponent;
		}
		
		public function upData(obj:Object):void
		{
			if(obj.type==ItemEnum.Chariot)
			{
				battleProxy.getAllZhanCheList(function():void
				{					
					comp.changeContainerWuQi(battleProxy.allZhanCheList);
				});
			}
			if(obj.type==ItemEnum.TankPart)
			{
				pageProxy.packageViewView(function():void
				{					
					comp.changeContainerGuaJian(pageProxy.guaJianList);
				});
			}
		}
	}
}