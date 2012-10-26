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
	
	import view.ranking.RankingComponent;

	public class RankingComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="RankingComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var obj:Object={};
		
		private var rankProxy:RankingProxy;
		private var userProxy:UserInfoProxy;
		public function RankingComponentMediator()
		{
			super(NAME, new RankingComponent());
			
			this.popUpEffect=CENTER;
			level=1;
			comp.med=this;
			this.height=Main.HEIGHT;
			rankProxy=getProxy(RankingProxy);
			userProxy=getProxy(UserInfoProxy);
			
			comp.upData(rankProxy.rankUserVo);
			
			comp.addEventListener(RankingEvent.CLOSE_ALL,closeHandler);
			comp.addEventListener(RankingEvent.SHOW_CAIFU,caiFuHandler);
			comp.addEventListener(RankingEvent.SHOW_GEREN,geRenHandler);
			comp.addEventListener(RankingEvent.SHOW_JUNTUAN,junTuanHandler);
			comp.addEventListener(RankingEvent.SHOW_PVE,pveHandler);
			comp.addEventListener(RankingEvent.SHOW_YAOSAI,yaoSaiHandler);
		}
		
		protected function caiFuHandler(event:RankingEvent):void
		{
			obj.type=RankEnum.CAIFU;
			rankProxy.listWealth(userProxy.userInfoVO.player_id,0,function():void
			{
				sendNotification(RankingCommonComponentMediator.SHOW_NOTE,obj);
			});
		}
		
		protected function geRenHandler(event:RankingEvent):void
		{
			obj.type=RankEnum.SHENGWANG;
			rankProxy.listReputation(userProxy.userInfoVO.player_id,0,function():void
				{
					sendNotification(RankingCommonComponentMediator.SHOW_NOTE,obj);
				});
			
		}
		
		protected function junTuanHandler(event:RankingEvent):void
		{
			obj.type=RankEnum.GROUP;
			rankProxy.listPrestige(userProxy.userInfoVO.player_id,0,function():void
			{
				sendNotification(RankingCommonComponentMediator.SHOW_NOTE,obj);
			});
		}
		
		protected function pveHandler(event:RankingEvent):void
		{
			sendNotification(rankingPvpComponentMediator.SHOW_NOTE);
		}
		
		protected function yaoSaiHandler(event:RankingEvent):void
		{
			obj.type=RankEnum.YAOSAI;
			rankProxy.listFortress(userProxy.userInfoVO.player_id,0,function():void
			{
				sendNotification(RankingCommonComponentMediator.SHOW_NOTE,obj);
			});
			
		}
		
		protected function closeHandler(event:RankingEvent):void
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
		protected function get comp():RankingComponent
		{
			return viewComponent as RankingComponent;
		}

	}
}