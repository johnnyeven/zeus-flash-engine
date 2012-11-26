package controller.battle.fight.fightMorePlayer
{
	import flash.display.DisplayObject;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.battle.FightDataUtil;
	
	import view.battle.fight.FightZhanCheComponent;
	
	import vo.battle.fight.fightMorePlayer.FightZhanCheFuHuoVO;

	/**
	 * 战车复活 
	 * 其他玩家可见
	 * @author rl
	 * 
	 */
	public class FightZhanCheFuHuoCommand extends SimpleCommand
	{
		public static const FIGHT_ZHAN_CHE_FU_HUO_COMMAND:String = "zhanCheFuHuo";
		
		public function FightZhanCheFuHuoCommand()
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
			var fightZhanCheFuHuoVO:FightZhanCheFuHuoVO = notification.getBody() as FightZhanCheFuHuoVO;
			var fightMed:BattleFightMediator=getMediator(BattleFightMediator);
			var zhanCheVo:CHARIOT=fightMed.comp.disposeZhanCheVODIC[fightZhanCheFuHuoVO.id] as CHARIOT;
			if(zhanCheVo)
			{
				if(fightZhanCheFuHuoVO.isFuHuo == 1)
				{
					zhanCheVo.currentEndurance=zhanCheVo.totalEndurance;
					//战车死亡前的数据
					fightMed.comp.distoryZhanCheVo.currentEndurance = zhanCheVo.totalEndurance;

						var zhanCheComp:FightZhanCheComponent=new FightZhanCheComponent(zhanCheVo);
						zhanCheComp.x=fightMed.comp.distoryZhanCheVo.x;
						zhanCheComp.y=fightMed.comp.distoryZhanCheVo.y;
				
						fightMed.comp.compIDDic[zhanCheVo.id]=zhanCheComp;
						FightDataUtil.dataDic[zhanCheVo.id]=zhanCheVo;
						
						fightMed.comp.allCompList.push(zhanCheComp);
						fightMed.comp.buildCompList.push(zhanCheComp);				
						fightMed.comp.buildSp.addChild(zhanCheComp);					
						
						fightMed.comp.startCheck();
						fightMed.comp.mouseChildren=fightMed.comp.mouseEnabled=true;					
				}
				else if(fightZhanCheFuHuoVO.isFuHuo == 0)
				{
					
				}
			}
			
			
		}
	}
}