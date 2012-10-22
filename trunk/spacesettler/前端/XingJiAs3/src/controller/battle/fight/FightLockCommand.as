package controller.battle.fight
{
    import com.zn.utils.PointUtil;
    
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    import mediator.battle.BattleFightMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import view.battle.fight.FightBuildComponent;
    import view.battle.fight.FightZhanCheComponent;
    
    import vo.battle.fight.FightLockVO;

    /**
     *锁定或解锁
     * @author zn
     *
     */
    public class FightLockCommand extends SimpleCommand
    {
        public static const FIGHT_LOCK_COMMAND:String = "FIGHT_LOCK_COMMAND";

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
            var lockVO:FightLockVO = notification.getBody() as FightLockVO;
            var fightMed:BattleFightMediator = getMediator(BattleFightMediator);

            var lockObj:DisplayObject = fightMed.comp.compIDDic[lockVO.lockID];
            var lockedObj:DisplayObject = fightMed.comp.compIDDic[lockVO.lockedID];

            //如果被锁定对象不存在，表示解除锁定

            // 发起锁定
            // 如果是战车
            if (lockObj is FightZhanCheComponent)
            {
                if (lockedObj)
                {
                    //被锁定对象存在，表示锁定
                    (lockObj as FightZhanCheComponent).zhanCheVO.attackID = lockVO.lockedID;

                    //角度调整
                    //计算旋转角度
                    (lockObj as FightZhanCheComponent).tankPartRotaion = PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x, lockedObj.y));
                }
                else
                {
                    //被锁定对象不存在，解除锁定
                    (lockObj as FightZhanCheComponent).zhanCheVO.attackID = null;
                }
            }

            //如果是建筑
			if(lockObj is FightBuildComponent)
			{
				if (lockedObj)
				{
					//被锁定对象存在，表示锁定
					(lockObj as FightBuildComponent).buildVO.attackID = lockVO.lockedID;
					
					//角度调整
					//计算旋转角度
					(lockObj as FightBuildComponent).paotaRotaion = PointUtil.getRotaion(new Point(lockObj.x, lockObj.y), new Point(lockedObj.x, lockedObj.y));
				}
				else
				{
					//被锁定对象不存在，解除锁定
					(lockObj as FightBuildComponent).buildVO.attackID = null;
				}
			}

            //TODO:ZN 如果是小飞机
        }
    }
}
