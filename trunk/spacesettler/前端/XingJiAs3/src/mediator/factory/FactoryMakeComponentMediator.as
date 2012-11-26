package mediator.factory
{
	import com.greensock.TweenLite;
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import events.buildingView.ConditionEvent;
	import events.factory.FactoryEvent;
	import events.factory.FactoryItemEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.buildingView.ConditionViewCompMediator;
	import mediator.cangKu.ChaKanGuaJianViewComponentMediator;
	import mediator.cangKu.ChaKanZhanCheViewComponentMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.factory.FactoryProxy;
	
	import view.factory.FactoryItem_1Component;
	import view.factory.FactoryMakeComponent;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.factory.DrawListVo;

	public class FactoryMakeComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryMakeComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var factoryProxy:FactoryProxy;		
		private var type:String;
		public function FactoryMakeComponentMediator()
		{
			super(NAME, new FactoryMakeComponent());
			
			factoryProxy=getProxy(FactoryProxy);
			
			comp.med=this;
			level=2;
			comp.addEventListener(FactoryEvent.CLOSE_EVENT,doCloseHandler);
			comp.addEventListener(FactoryEvent.SHOW_INFO_EVENT,doShowInfoHandler);
			comp.addEventListener(FactoryEvent.SPEEDUP_EVENT,doSpeedUpHandler);
			comp.addEventListener(FactoryEvent.MAKE_EVENT,doMakeHandler);
			comp.addEventListener(ConditionEvent.ADDCONDITIONVIEW_EVENT,conditionHandler);
			
			comp.addEventListener(FactoryItemEvent.ZHIZAO_COMPLETE_EVENT,makeCompLeteHandler);
		}
		
		protected function conditionHandler(event:ConditionEvent):void
		{
			sendNotification(ConditionViewCompMediator.SHOW_NOTE,event.conditionArr);
		}
		
		protected function makeCompLeteHandler(event:FactoryItemEvent):void
		{
			factoryProxy.update_produce(event.drawListVo.id,function():void
			{
				change();
			});
		}
		
		protected function doMakeHandler(event:FactoryEvent):void
		{
			factoryProxy.makeStar(event.item.drawVo.id,function():void
			{
				change();
			});
			
		}
		
		protected function doSpeedUpHandler(event:FactoryEvent):void
		{
			var item:FactoryItem_1Component=event.item as FactoryItem_1Component;
			var obj:Object={};
			obj.title=MultilanguageManager.getString("jiaSu");
			obj.info=MultilanguageManager.getString("thisEvent");
			obj.count=BaseItemVO.MONEY.toString();
			obj.okCallBack=function():void
			{
				factoryProxy.produce_speed_up(item.drawVo.eventID,function():void
				{
					change();
				});				
			}
			sendNotification(MoneyAlertComponentMediator.SHOW_NOTE,obj);
		}
		
		protected function doShowInfoHandler(event:FactoryEvent):void
		{
			var obj:Object={};
			obj.type=FactoryEnum.CURRENT_VO.item_type
			if(FactoryEnum.CURRENT_VO.item_type==ItemEnum.Chariot)
				FactoryEnum.CURRENT_ZHIZAO_VO=FactoryEnum.CURRENT_VO as ZhanCheInfoVO;
			if(FactoryEnum.CURRENT_VO.item_type==ItemEnum.TankPart)
				FactoryEnum.CURRENT_GUAJIAN_VO=FactoryEnum.CURRENT_VO as GuaJianInfoVO;
			
			sendNotification(FactoryChaKanComponentMediator.SHOW_NOTE,obj);
		}
		
		protected function doCloseHandler(event:FactoryEvent):void
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
		public function get comp():FactoryMakeComponent
		{
			return viewComponent as FactoryMakeComponent;
		}
		
		private function change():void
		{
			var listProxy:FactoryProxy=getProxy(FactoryProxy);
			if(type==FactoryEnum.MAKE_ZHANCHE)
			{
				comp.changeContainer(listProxy.makeZCListArr);
			}else if(type==FactoryEnum.MAKE_WUQI)
			{
				comp.changeContainer(listProxy.makeWQListArr);
			}else if(type==FactoryEnum.MAKE_GUAJIAN)
			{
				comp.changeContainer(listProxy.makeGJListArr);
			}		
		}
		
		public function upData(type:String,callfunction:Function=null):void
		{
			this.type=type;
			var listProxy:FactoryProxy=getProxy(FactoryProxy);
			if(type==FactoryEnum.MAKE_ZHANCHE)
			{
				comp.addContainerZhanChe(listProxy.makeZCListArr);
			}else if(type==FactoryEnum.MAKE_WUQI)
			{
				comp.addContainerGuaJian(listProxy.makeWQListArr);
			}else if(type==FactoryEnum.MAKE_GUAJIAN)
			{
				comp.addContainerGuaJian(listProxy.makeGJListArr);
			}					
			
			if(callfunction!=null)
				callfunction();
			callfunction=null;
									
		}
	}
}