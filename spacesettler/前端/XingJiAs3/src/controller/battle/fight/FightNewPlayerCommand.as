package controller.battle.fight
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.battle.BattleProxy;
	
	import utils.battle.FightDataUtil;
	
	import view.battle.fight.FightZhanCheComponent;

	/**
	 *新玩家进入 
	 * @author Administrator
	 * 
	 */	
	public class FightNewPlayerCommand extends SimpleCommand
	{
		public static const FIGHT_NEWPLAYER_COMMAND:String="FIGHT_NEWPLAYER_COMMAND";
		
		public var startPoint:Point;
		
		private var fightMed:BattleFightMediator;
		private var _battleProxy:BattleProxy;
		
		public function FightNewPlayerCommand()
		{
			super();
			_battleProxy=getProxy(BattleProxy);
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			fightMed=getMediator(BattleFightMediator);
			
			startPoint=fightMed.comp.startPoint;
			
			var fortPlayer1:PLAYER1=notification.getBody() as PLAYER1;
			var zhanCheComp:FightZhanCheComponent;
			var zhanCheVO:CHARIOT;
			
			if (fortPlayer1.chariots.length == 1)
			{
				zhanCheVO=fortPlayer1.chariots[0];
				zhanCheComp=new FightZhanCheComponent(zhanCheVO);
				zhanCheComp.x=startPoint.x;
				zhanCheComp.y=startPoint.y;
				
				fortPlayer1.players[0].gid=fortPlayer1.gid;
				zhanCheVO.gid=fortPlayer1.gid;
				
				_battleProxy.setZhanCheProperty(zhanCheVO);
				
				fightMed.comp.compIDDic[zhanCheVO.id]=zhanCheComp;
				FightDataUtil.dataDic[(fortPlayer1.players[0] as PLAYER).id]=fortPlayer1.players[0];
				FightDataUtil.dataDic[zhanCheVO.id]=zhanCheVO;
				
				fightMed.comp.allCompList.push(zhanCheComp);
				fightMed.comp.buildCompList.push(zhanCheComp);				
				fightMed.comp.buildSp.addChild(zhanCheComp);
			}
			
		}

	}
}