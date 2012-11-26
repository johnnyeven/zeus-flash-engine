package controller.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.PointUtil;
	
	import enum.battle.FightVOTypeEnum;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.battle.FightDataUtil;
	import utils.battle.FightUtil;
	
	import view.battle.fight.FightFeiJiComponent;
	import view.battle.fight.FightZhanCheComponent;
	
	import vo.battle.fight.FightMoveVO;

	/**
	 *移动
	 * @author zn
	 *
	 */
	public class FightMoveCommand extends SimpleCommand
	{
		public static const FIGHT_MOVE_COMMAND:String="FIGHT_MOVE_COMMAND";

		private var fightMed:BattleFightMediator;

		private var myZhanCheComp:DisplayObject;

		public function FightMoveCommand()
		{
			super();
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			//移动
			var fightMoveVO:FightMoveVO=notification.getBody() as FightMoveVO;

			fightMed=getMediator(BattleFightMediator);
			myZhanCheComp=fightMed.comp.myZhanCheComp;
			
			var voObj:Object=FightDataUtil.getVO(fightMoveVO.id);

			if (!voObj)
				return;

			var startP:Point=new Point(fightMoveVO.startX, fightMoveVO.startY);
			var endP:Point=new Point(fightMoveVO.endX, fightMoveVO.endY);
			var dis:Number=Point.distance(startP, endP);
			var time:Number=dis / fightMoveVO.moveSpeed;
			var angle:Number=fightMoveVO.angle;

			if (voObj.voType == FightVOTypeEnum.zhanChe)
			{
				//战车移动
				var zhanCheComp:FightZhanCheComponent=fightMed.comp.compIDDic[fightMoveVO.id];
				zhanCheComp.zhanCheRotation=angle;
				zhanCheComp.x=startP.x;
				zhanCheComp.y=startP.y;
				zhanCheComp.moveTweenLite=TweenLite.to(zhanCheComp, time, {x: endP.x, y: endP.y,
						ease: Linear.easeNone,
						onUpdate: zhanCheMoveUpdate, onUpdateParams: [zhanCheComp]});
			}
			else if (voObj.voType == FightVOTypeEnum.liaoJi)
			{
				// 僚机移动
				var feiJiComp:FightFeiJiComponent=fightMed.comp.compIDDic[fightMoveVO.id];
				feiJiComp.x=startP.x;
				feiJiComp.y=startP.y;
				feiJiComp.moveTweenLite=TweenLite.to(feiJiComp, time, {x: endP.x, y: endP.y, ease: Linear.easeNone});
			}
			else if(voObj.voType == FightVOTypeEnum.xiaoFeiJi)
			{
				//TODO LW:小飞机的移动
				feiJiComp.x=startP.x;
				feiJiComp.y=startP.y;
			}
		}

		private function zhanCheMoveUpdate(zhanCheComp:FightZhanCheComponent):void
		{
			//检测战车是否有护盾，如果有就让护盾跟随战车移动(lw)
			if(zhanCheComp.defenseMC)
			{
				zhanCheComp.defenseMC.x=zhanCheComp.x;
				zhanCheComp.defenseMC.y=zhanCheComp.y;
			}
			
			//检查是否停止战车移动
			var nextPoint:Point=FightUtil.getNextMovePoint(zhanCheComp.x, zhanCheComp.y, zhanCheComp.zhanCheRotation);
			if (fightMed.comp.hasMask(nextPoint))
			{
				zhanCheComp.alpha=0.6;
				zhanCheStopMove(zhanCheComp);
			}
			else
				zhanCheComp.alpha=1;

			fightMed.comp.sortBuild();

			var lockedObj:DisplayObject=fightMed.comp.compIDDic[zhanCheComp.itemVO.myAttackID];
			//如果有锁定对象，调整战车炮塔角度
			if (lockedObj)
			{
				var rotaion:Number=PointUtil.getRotaion(new Point(zhanCheComp.x, zhanCheComp.y), new Point(lockedObj.x, lockedObj.y));
				zhanCheComp.tankPartRotaion=rotaion;
			}
		}

		private function zhanCheStopMove(zhanCheComp:FightZhanCheComponent):void
		{
			fightMed.comp.stopMove(zhanCheComp);
		}
	}
}
