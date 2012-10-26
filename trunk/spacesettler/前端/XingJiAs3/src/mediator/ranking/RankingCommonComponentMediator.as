package mediator.ranking
{
	
	import enum.rank.RankEnum;
	
	import events.ranking.RankingEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.rankingProxy.RankingProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.ranking.RankingCommonComponent;

	public class RankingCommonComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="RankingCommonComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var rankProxy:RankingProxy;
		private var userProxy:UserInfoProxy;

		public function RankingCommonComponentMediator()
		{
			super(NAME, new RankingCommonComponent());
			this.popUpEffect=UP;
			level=2;
			comp.med=this;
			this.height=Main.HEIGHT;
			
			rankProxy=getProxy(RankingProxy);
			userProxy=getProxy(UserInfoProxy);
			
			comp.addEventListener(RankingEvent.CLOSE,closeHandler);
			comp.addEventListener(RankingEvent.DAYLIST_FORTERESS,dayForteress);
			comp.addEventListener(RankingEvent.LIST_FORTERESS,listForteress);
			
			comp.addEventListener(RankingEvent.DAYLIST_REPUTATION,dayReputation);
			comp.addEventListener(RankingEvent.LIST_REPUTATION,listReputation);
			
			comp.addEventListener(RankingEvent.DAYLIST_MONEY,dayMoney);
			comp.addEventListener(RankingEvent.LIST_MONEY,listMoney);
			
			comp.addEventListener(RankingEvent.DAYLIST_GROUP,dayGroup);
			comp.addEventListener(RankingEvent.LIST_GROUP,listGroup);
		}		
		
		public function showPage(obj:Object):void
		{
			
			switch(obj.type)
			{
				case RankEnum.CAIFU:
				{
					comp.showCaiFu(RankEnum.CAIFU);
					break;
				}
				case RankEnum.SHENGWANG:
				{
					comp.showShengWang(RankEnum.SHENGWANG);
					break;
				}
				case RankEnum.GROUP:
				{
					comp.showJunTuan(RankEnum.GROUP);
					break;
				}
				case RankEnum.YAOSAI:
				{
					comp.showYaoSai(RankEnum.YAOSAI);
					break;
				}
			}
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
		protected function get comp():RankingCommonComponent
		{
			return viewComponent as RankingCommonComponent;
		}
		
		
		protected function listReputation(event:RankingEvent):void
		{
			rankProxy.listReputation(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
			
		}
		
		protected function dayReputation(event:RankingEvent):void
		{
			rankProxy.dayListReputation(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}
		
		protected function listForteress(event:RankingEvent):void
		{
			rankProxy.listFortress(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}
		
		protected function dayForteress(event:RankingEvent):void
		{
			rankProxy.dayListFortress(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}	
		
		protected function listGroup(event:RankingEvent):void
		{
			rankProxy.listPrestige(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}
		
		protected function dayGroup(event:RankingEvent):void
		{
			rankProxy.dayListPrestige(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}
		
		protected function listMoney(event:RankingEvent):void
		{
			rankProxy.listWealth(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}
		
		protected function dayMoney(event:RankingEvent):void
		{
			rankProxy.dayListWealth(userProxy.userInfoVO.player_id,0,function():void
			{
				comp.cleanAndAdd();
			});
		}			
		
		protected function closeHandler(event:RankingEvent):void
		{
			sendNotification(DESTROY_NOTE);
			//			sendNotification(RankingComponentMediator.SHOW_NOTE);
		}

	}
}