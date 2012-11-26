package controller.battle.fight.fightMorePlayer
{
	import flash.display.DisplayObject;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.battle.fight.FightZhanCheComponent;
	
	import vo.battle.fight.fightMorePlayer.FightZhanCheMaoYanVO;
	
	/**
	 *战车冒烟特效
	 * @author lw
	 *
	 */
	public class FightZhanCheMaoYanCommand extends SimpleCommand
	{
		public static const FIGHT_ZHAN_CHE_MAO_YAN_COMMAND:String = "zhanCheMaoYan";
		
		public function FightZhanCheMaoYanCommand()
		{
			super();
		}
		
		/**
		 * 执行
		 * @param notification
		 * 
		 */		
		public override function execute(notification:INotification):void
		{
			var fightZhanCheMaoYanVO:FightZhanCheMaoYanVO = notification.getBody() as FightZhanCheMaoYanVO;
			var fightMed:BattleFightMediator=getMediator(BattleFightMediator);
			var zhanChe:DisplayObject=fightMed.comp.compIDDic[fightZhanCheMaoYanVO.id];
			if(zhanChe)
			{
				if(fightZhanCheMaoYanVO.isMaoYan == 1)
				{
					(zhanChe as FightZhanCheComponent).zhanCheMaoYaneffectMC.visible = true;
				}
				else if(fightZhanCheMaoYanVO.isMaoYan == 0)
				{
					(zhanChe as FightZhanCheComponent).zhanCheMaoYaneffectMC.visible = false;
				}
			}
		}
	}
}