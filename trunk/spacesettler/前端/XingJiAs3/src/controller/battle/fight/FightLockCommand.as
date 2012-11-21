package controller.battle.fight
{
	import com.zn.utils.PointUtil;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.battle.FightDataUtil;
	
	import vo.battle.fight.FightLockVO;

	/**
	 *锁定或解锁
	 * @author zn
	 *
	 */
	public class FightLockCommand extends SimpleCommand
	{
		public static const FIGHT_LOCK_COMMAND:String="FIGHT_LOCK_COMMAND";

		public function FightLockCommand()
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
			var lockVO:FightLockVO=notification.getBody() as FightLockVO;
			var fightMed:BattleFightMediator=getMediator(BattleFightMediator);

			var lockVOObj:Object=FightDataUtil.getVO(lockVO.lockID);
			var lockedVOObj:Object=FightDataUtil.getVO(lockVO.lockedID);

			if(!lockVOObj)
				return ;
			
			var lockObj:DisplayObject=fightMed.comp.compIDDic[lockVO.lockID];
			var lockedObj:DisplayObject=fightMed.comp.compIDDic[lockVO.lockedID];

			//如果被锁定对象不存在，表示解除锁定

			if (lockedVOObj!=null&&lockedObj!=null)
			{
				//被锁定对象存在，表示锁定
				lockVOObj.myAttackID=lockVO.lockedID;

				//角度调整
				//计算旋转角度
				lockObj["tankPartRotaion"]=PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x, lockedObj.y));
			}
			else
			{
				//被锁定对象不存在，解除锁定
				lockVOObj.myAttackID=null;
			}

		}
	}
}
