package mediator.factory
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.battle.BattleProxy;
	import proxy.factory.FactoryProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.factory.FactoryMakeAndServiceComponent;
	
	import vo.cangKu.ZhanCheInfoVO;

	public class FactoryMakeAndServiceComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryMakeAndServiceComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public static const HUISHOU_NOTE:String="huishou_note";
		public static const WEIXIU_NOTE:String="weixiu_note";
		
		private var callFun:Function;
		private var _type:String;
		
		private var factoryProxy:FactoryProxy;
		private var recipe_type:String;
		private var battleProxy:BattleProxy;
		private var userProxy:UserInfoProxy;
		public function FactoryMakeAndServiceComponentMediator()
		{
			super(NAME, new FactoryMakeAndServiceComponent());
			userProxy=getProxy(UserInfoProxy);
			factoryProxy=getProxy(FactoryProxy);
			battleProxy=getProxy(BattleProxy);
			
			comp.med = this;
			level=1;
			
			comp.addEventListener(FactoryEvent.HUISHOU_EVENT,huiShouHandler);
			comp.addEventListener(FactoryEvent.WEIXIU_EVENT,weiXiuHandler);
			comp.addEventListener(FactoryEvent.MAKE_GUAJIAN_EVENT,makeGuaJianHandler);
			comp.addEventListener(FactoryEvent.MAKE_WUQI_EVENT,makeWuQiHandler);
			comp.addEventListener(FactoryEvent.MAKE_ZHANCHE_EVENT,makeZhanCheHandler);
			comp.addEventListener(FactoryEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(FactoryEvent.SHOW_INFO_EVENT,showInfoHandler);
			comp.addEventListener(FactoryEvent.LOAD_ZHANCHE_EVENT,loadZhanCheHandler);
		}
		
		protected function loadZhanCheHandler(event:FactoryEvent):void
		{						
			var obj:Object={};
			obj.type=ItemEnum.Chariot;
			sendNotification(FactoryArmsComponentMediator.SHOW_NOTE,obj);
			sendNotification(DESTROY_NOTE);
		}
		
		protected function showInfoHandler(event:FactoryEvent):void
		{
			var obj:Object={};
			obj.type=_type;
			sendNotification(FactoryInfoComponentMediator.SHOW_NOTE,obj);
		}
		
		protected function closeHandler(event:FactoryEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function makeGuaJianHandler(event:FactoryEvent):void
		{
			
			recipe_type=FactoryEnum.MAKE_GUAJIAN;
			sendMake();
		}
		
		protected function makeWuQiHandler(event:FactoryEvent):void
		{
			recipe_type=FactoryEnum.MAKE_WUQI;
			sendMake();
		}
		
		protected function makeZhanCheHandler(event:FactoryEvent):void
		{
			recipe_type=FactoryEnum.MAKE_ZHANCHE;
			sendMake();
		}
		
		
		private function sendMake():void
		{
			factoryProxy.makeList(function():void
			{
				var obj:Object={};
				obj.type=recipe_type;
				sendNotification(FactoryMakeComponentMediator.SHOW_NOTE,obj);
			});
			
		}
		
		protected function huiShouHandler(event:FactoryEvent):void
		{ 
			var _vo:ZhanCheInfoVO=FactoryEnum.CURRENT_ZHANCHE_VO;
			
			var obj:Object={};
			obj.infoLable=MultilanguageManager.getString("huishou");
			obj.showLable=MultilanguageManager.getString("zhanchehuishou");
			obj.okCallBack=function():void
			{
				factoryProxy.recycle(_vo.id,function():void
				{							
					userProxy.userInfoVO.broken_crysta+=FactoryEnum.CURRENT_ZHANCHE_VO.recycle_price_broken_crystal;					
				});				
			};			
			sendNotification(PromptSureMediator.SHOW_NOTE,obj)
		}
		
		protected function weiXiuHandler(event:FactoryEvent):void
		{
			var _vo:ZhanCheInfoVO=FactoryEnum.CURRENT_ZHANCHE_VO;
			factoryProxy.repair(_vo.id,function():void
			{
				comp.isWanHao();
				userProxy.userInfoVO.broken_crysta-=FactoryEnum.CURRENT_ZHANCHE_VO.repair_cost_broken_crystal;
			});
		}
		
		public function upData(type:String,fun:Function=null):void
		{
			_type=type;
			callFun=fun;
			if(type==FactoryEnum.GAIZHUANG_FACTORY)
				battleProxy.getAllZhanCheList(function():void
				{					
					comp.isGaiZhuang();
										
				});			
			if(type==FactoryEnum.WEIXIU_FACTORY)
				battleProxy.getAllZhanCheList(function():void
				{
					comp.isWeiXiu();
					comp.changeContainer(battleProxy.allZhanCheList)
				});
			if(type==FactoryEnum.ZHIZAO_FACTORY)
				comp.isZhiZao();
			
			if(callFun!=null)
				callFun();
			callFun=null;
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,HUISHOU_NOTE,WEIXIU_NOTE];
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
				case HUISHOU_NOTE:
				{
					FactoryEnum.CURRENT_ZHANCHE_VO=null;
					comp.changeContainer(battleProxy.allZhanCheList);
					break;
				}
				case WEIXIU_NOTE:
				{
					comp.changeContainer(battleProxy.allZhanCheList);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():FactoryMakeAndServiceComponent
		{
			return viewComponent as FactoryMakeAndServiceComponent;
		}

	}
}