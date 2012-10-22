package controller.battle.fight
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.PointUtil;
    import com.zn.utils.StringUtil;

    import flash.display.DisplayObject;
    import flash.geom.Point;

    import mediator.battle.BattleFightMediator;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    import view.battle.fight.FightZhanCheComponent;

    import vo.battle.fight.FightMoveVO;

    /**
     *战车移动
     * @author zn
     *
     */
    public class FightZhanCheMoveCommand extends SimpleCommand
    {
        public static const FIGHT_ZHAN_CHE_MOVE_COMMAND:String = "FIGHT_ZHAN_CHE_MOVE_COMMAND";

        private var fightMed:BattleFightMediator;

        public function FightZhanCheMoveCommand()
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
            //战车移动
            var fightMoveVO:FightMoveVO = notification.getBody() as FightMoveVO;

            fightMed = getMediator(BattleFightMediator);

            var zhanCheComp:FightZhanCheComponent = fightMed.comp.compIDDic[fightMoveVO.zhanCheID];
            zhanCheComp.zhanCheRotation = fightMoveVO.angle;

            var dis:Number = Point.distance(fightMoveVO.startPoint, fightMoveVO.endPoint);
            var time:Number = dis / fightMoveVO.speed;
            zhanCheComp.moveTweenLite = TweenLite.to(zhanCheComp, time, { x: fightMoveVO.endPoint.x, y: fightMoveVO.endPoint.y,
                                                         ease: Linear.easeNone,
                                                         onUpdate: zhanCheMoveUpdate, onUpdateParams: [ zhanCheComp ]});
        }

        private function zhanCheMoveUpdate(zhanCheComp:FightZhanCheComponent):void
        {
            //检查是否停止战车移动
            var p:Point = zhanCheComp.nextMovePoint;
            if (!fightMed.comp.zhanCheCanMove(p))
                stopMove(zhanCheComp);
            if (fightMed.comp.hasMask(p))
            {
                zhanCheComp.alpha = 0.6;
                stopMove(zhanCheComp);
            }
            else
                zhanCheComp.alpha = 1;

            fightMed.comp.sortBuild();

            //如果有锁定对象，调整战车炮塔角度
            if (!StringUtil.isEmpty(zhanCheComp.zhanCheVO.attackID))
            {
                var lockedObj:DisplayObject = fightMed.comp.compIDDic[zhanCheComp.zhanCheVO.attackID];
                var rotaion:Number = PointUtil.getRotaion(new Point(zhanCheComp.x, zhanCheComp.y), new Point(lockedObj.x, lockedObj.y));
                zhanCheComp.tankPartRotaion = rotaion;
            }
        }

        private function stopMove(zhanCheComp:FightZhanCheComponent):void
        {
            fightMed.comp.stopMove(zhanCheComp);
        }
    }
}
