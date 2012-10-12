package mediator.ranking
{
	
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
			
			rankProxy=getProxy(RankingProxy);
			userProxy=getProxy(UserInfoProxy);
			
			comp.addEventListener(RankingEvent.CLOSE,closeHandler);
			comp.addEventListener(RankingEvent.DAYLIST_FORTERESS,dayForteress);
			comp.addEventListener(RankingEvent.LIST_FORTERESS,listForteress);
			comp.addEventListener(RankingEvent.DAYLIST_REPUTATION,dayReputation);
			comp.addEventListener(RankingEvent.LIST_REPUTATION,listReputation);
		}
		
		
		public function showPage(obj:Object):void
		{
			
			switch(obj.type)
			{
				case "caifu":
				{
					comp.showCaiFu("caifu");
					break;
				}
				case "shengwang":
				{
					comp.showShengWang("shengwang");
					break;
				}
				case "juntuan":
				{
					comp.showJunTuan("juntuan");
					break;
				}
				case "yaosai":
				{
					comp.showYaoSai("yaosai");
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
		
		protected function closeHandler(event:RankingEvent):void
		{
			sendNotification(DESTROY_NOTE);
			//			sendNotification(RankingComponentMediator.SHOW_NOTE);
		}

	}
}