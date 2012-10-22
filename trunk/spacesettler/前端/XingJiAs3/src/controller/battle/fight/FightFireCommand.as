package controller.battle.fight
{
    import com.zn.utils.ClassUtil;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.EnterFrameUtil;
    import com.zn.utils.PointUtil;
    import com.zn.utils.StringUtil;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.geom.Point;
    
    import mediator.battle.BattleFightMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import ui.managers.SystemManager;
    import ui.utils.DisposeUtil;
    
    import utils.battle.FightDataUtil;
    
    import view.battle.fight.BattleFightComponent;
    import view.battle.fight.FightZhanCheComponent;
    
    import vo.battle.fight.FightFireVO;

    /**
     * 开火
     * @author zn
     *
     */
    public class FightFireCommand extends SimpleCommand
    {
        public static const FIGHT_FIRE_COMMAND:String = "FIGHT_FIRE_COMMAND";

        private var fireVO:FightFireVO;

        private var fightMed:BattleFightMediator;

        public function FightFireCommand()
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
            //开火
            fireVO = notification.getBody() as FightFireVO;

            fightMed = getMediator(BattleFightMediator);

            //判断是建筑还是挂件
            if (fireVO.attackType == FightFireVO.GUA_JIA)
            {
                //挂件
                var tankpart:TANKPART = FightDataUtil.getTankPart(fireVO.attackID);

                //设置开火冷却时间
                tankpart.attackCoolEndTime = DateFormatter.currentTimeM + tankpart.attackCoolDown;

                //TODO:ZN 开火特效
                var zhanCheComp:FightZhanCheComponent = fightMed.comp.compIDDic[fireVO.id];
//				var className:String=StringUtil.formatString("battle.FireEffect_{0}_{1}",tankpart.category/
                var effectMC:MovieClip = ClassUtil.getObject("battle.FireEffect_0_1");
                effectMC.addEventListener(Event.COMPLETE, effectMC_completeHandler);
				effectMC.rotation = -zhanCheComp.tankPartRotaion;
				fightMed.comp.addEffect(effectMC);
				effectMC.gotoAndPlay(1);
            }
            else
            {
                //炮台
                //TODO:ZN 旋转炮台瞄准目标

                //TODO:ZN 设置开火冷却时间

                //TODO:ZN 开火特效
            }
        }

        /**
         *开火特效播放完成
         * @param event
         *
         */
        protected function effectMC_completeHandler(event:Event):void
        {
			var effectObj:DisplayObject=event.currentTarget as DisplayObject;
			effectObj.removeEventListener(Event.COMPLETE, effectMC_completeHandler);
			EnterFrameUtil.callLater(function():void
			{
				DisposeUtil.dispose(effectObj);
			});
			
			//TODO:ZN 开火完成，发送
        }
    }
}
