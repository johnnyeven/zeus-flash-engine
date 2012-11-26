package mediator.allView
{
	import com.greensock.TweenLite;
	
	import events.allView.AllViewEvent;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import mediator.WindowMediator;
	import mediator.battle.BattleEditMediator;
	import mediator.battleEnter.BattleEnterComponentMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.BuildProxy;
	import proxy.plantioid.PlantioidProxy;
	
	import view.allView.AllViewXingXingEvent;
	import view.allView.XingXingComponent;

	/**
	 *行星要塞 
	 * @author lw
	 * 
	 */	
	public class XingXingComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="XingXingComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function XingXingComponentMediator()
		{
			super(NAME, new XingXingComponent());
			comp.med = this;
			level = 2;
			
			comp.addEventListener(AllViewEvent.CLOSED_XINGXING_EVENT,closeHandler);
			comp.addEventListener("destoryshangSprite",destoryshangSpriteHandler);
			comp.addEventListener("destoryxiaSprite",destoryxiaSpriteHandler);
			
			comp.addEventListener(AllViewXingXingEvent.CHECK_EVENT,checkHandler);
			comp.addEventListener(AllViewXingXingEvent.MANAGER_EVENT,managerHandler);
			comp.addEventListener(AllViewXingXingEvent.ATTACK_EVENT,attackHandler);
			
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
		public function get comp():XingXingComponent
		{
			return viewComponent as XingXingComponent;
		}

		private function destoryshangSpriteHandler(event:Event):void
		{
		  comp.shangSprite.visible = false;
		  TweenLite.to(comp.shangSprite,0.5,{x:0,y:-330});
		}
		
		private function destoryxiaSpriteHandler(event:Event):void
		{
			comp.xiaSprite.visible = false;
			TweenLite.to(comp.xiaSprite,0.5,{x:0,y:500});
		}
		
		/**
		 *管理 
		 * @param event
		 * 
		 */
		protected function managerHandler(event:AllViewXingXingEvent):void
		{
			var plantioidProxy:PlantioidProxy = getProxy(PlantioidProxy);
			//获取小行星带
			plantioidProxy.getPlantioidListByXY(event.fortVO.x,event.fortVO.y, function():void
			{
				plantioidProxy.setSelectedPlantioid(event.fortVO.id);
				plantioidProxy.getPlantioidInfo(PlantioidProxy.selectedVO.id, function():void
				{
					sendNotification(BattleEditMediator.SHOW_NOTE,PlantioidProxy.selectedVO.map_type);
				});
			});
			
			
		}
		
		/**
		 *查看 
		 * @param event
		 * 
		 */
		protected function checkHandler(event:AllViewXingXingEvent):void
		{
			var buildProxy:BuildProxy=getProxy(BuildProxy);
			buildProxy.isBuild=false;
			sendNotification(MainViewMediator.SET_PLANEBTN_NOTE);
			sendNotification(PlantioidComponentMediator.SHOW_NOTE,new Point(event.fortVO.x,event.fortVO.y));
		}
		
		/**
		 *攻击 
		 * @param event
		 * 
		 */		
		protected function attackHandler(event:AllViewXingXingEvent):void
		{
			
			var plantioidProxy:PlantioidProxy = getProxy(PlantioidProxy);
			//获取小行星带
			plantioidProxy.getPlantioidListByXY(1, 1, function():void
			{
				plantioidProxy.setSelectedPlantioid(event.fortVO.id);
				plantioidProxy.getPlantioidInfo(PlantioidProxy.selectedVO.id, function():void
				{
					sendNotification(BattleEnterComponentMediator.SHOW_NOTE);
				});
			});
		}
	}
}