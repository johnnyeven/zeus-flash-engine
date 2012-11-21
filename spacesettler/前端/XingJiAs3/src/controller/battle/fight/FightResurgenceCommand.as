package controller.battle.fight
{
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.userInfo.UserInfoProxy;
	
	import utils.battle.FightDataUtil;
	
	import view.battle.fight.FightZhanCheComponent;
	
	import vo.battle.fight.FightResurgenceVo;
	import vo.cangKu.ZhanCheInfoVO;

	public class FightResurgenceCommand extends SimpleCommand
	{
		public static const FIGHT_RESURGENCE_COMMAND:String="FIGHT_RESURGENCE_COMMAND";
		
		private var fightMed:BattleFightMediator;
		private var userProxy:UserInfoProxy;
		public function FightResurgenceCommand()
		{
			super();
			userProxy=getProxy(UserInfoProxy);
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			fightMed=getMediator(BattleFightMediator);
			var fightResVo:FightResurgenceVo=notification.getBody() as FightResurgenceVo;
			var zhanCheVo:CHARIOT=fightMed.comp.disposeZhanCheVODIC[fightResVo.idType] as CHARIOT;
			zhanCheVo.currentEndurance=zhanCheVo.totalEndurance;
			//战车死亡前的数据
			fightMed.comp.distoryZhanCheVo.currentEndurance = zhanCheVo.totalEndurance;
			if(zhanCheVo.id==fightMed.comp.myZhanCheComp.itemVO.id)
			{
				var zhanCheComp:FightZhanCheComponent=new FightZhanCheComponent(fightMed.comp.distoryZhanCheVo as CHARIOT);
				zhanCheComp.x=fightMed.comp.distoryZhanCheVo.x;
				zhanCheComp.y=fightMed.comp.distoryZhanCheVo.y;
//				zhanCheComp.x=zhanCheVo.x;
//				zhanCheComp.y=zhanCheVo.y;
				
				fightMed.comp.compIDDic[zhanCheVo.id]=zhanCheComp;
				FightDataUtil.dataDic[zhanCheVo.id]=zhanCheVo;
				
				fightMed.comp.allCompList.push(zhanCheComp);
				fightMed.comp.buildCompList.push(zhanCheComp);				
				fightMed.comp.buildSp.addChild(zhanCheComp);
				fightMed.comp.myZhanCheComp=zhanCheComp;
				
				
				fightMed.comp.startCheck();
				fightMed.comp.mouseChildren=fightMed.comp.mouseEnabled=true;
				fightMed.comp.isExit=false;		
				userProxy.userInfoVO.dark_crystal-=1;
				//保持上次攻打的状态（选中建筑特效）
				if(fightMed.comp.distoryZhanCheVo.currentSelectedID)
				{
					fightMed.comp.currentSelectedBuild = fightMed.comp.currentSelectedBuild;
					fightMed.comp.isClickBuild = true;
				}
			}
		}

	}
}