package controller.battle.fight
{
	import com.zn.utils.PointUtil;
	
	import enum.battle.FightVOTypeEnum;
	
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
				var rotaion:Number;
				//主动对象包含建筑
				if(lockObj["itemVO"].voType == FightVOTypeEnum.building && lockedObj["itemVO"].voType == FightVOTypeEnum.zhanChe )
				{
					rotaion = PointUtil.getRotaion(new Point(lockObj.x+75, lockObj.y+75), new Point(lockedObj.x, lockedObj.y));
				}
				else if(lockedObj["itemVO"].voType == FightVOTypeEnum.zhanChe)
				{
					rotaion = PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x, lockedObj.y));
				}
				
				//被动对象包含建筑
				if((lockObj["itemVO"].voType == FightVOTypeEnum.zhanChe || lockObj["itemVO"].voType == FightVOTypeEnum.liaoJi) && lockedObj["itemVO"].voType == FightVOTypeEnum.building)
				{
					rotaion = PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x+75, lockedObj.y+75));
				}
				else
				{
					rotaion = PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x, lockedObj.y));
				}
//				lockObj["tankPartRotaion"]=PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x, lockedObj.y));
				lockObj["tankPartRotaion"] = rotaion;
			}
			else
			{
				//被锁定对象不存在，解除锁定
				lockVOObj.myAttackID=null;
			}

		}
	}
}
