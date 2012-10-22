package view.battle.fight
{
    import com.zn.utils.BitmapUtil;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;

    import enum.battle.BattleBuildStateEnum;

    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import mx.binding.utils.BindingUtils;

    import ui.core.Component;
    import ui.utils.DisposeUtil;
    import flash.events.MouseEvent;

    /**
     *战场建筑
     * @author zn
     *
     */
    public class FightBuildComponent extends Component
    {
        public var buildVO:FORTBUILDING;

        private var _buildSp:Sprite;

        private var _paotaRotaion:Number;

        public function FightBuildComponent(buildVO:FORTBUILDING)
        {
            super(null);

            buttonMode = true;
            this.buildVO = buildVO;

            x = buildVO.x;
            y = buildVO.y;

            cwList.push(BindingUtils.bindSetter(stateChange, buildVO, "state"));
        }

        private function stateChange(value:*):void
        {
            DisposeUtil.dispose(_buildSp);

            var className:String = "";

            if (buildVO.type == 1 || buildVO.type == 2)
                className = StringUtil.formatString("build_icon_{0}_normal", buildVO.type);
            else
                className = StringUtil.formatString("battle.build_{0}", buildVO.type);

            _buildSp = ClassUtil.getObject(className);
            if (turretMC)
                turretMC.gotoAndStop(1);

            addChild(_buildSp);

        }

        public function get turretMC():MovieClip
        {
            return _buildSp.getChildByName("taMC") as MovieClip;
        }

        public function get paotaRotaion():Number
        {
            return _paotaRotaion;
        }

        public function set paotaRotaion(value:Number):void
        {
            if (value == 360)
                value = 0;

            _paotaRotaion = value;

            var r:int = Math.round(value / 20) * 2;

            if (r == 36)
                r = 0;

            var flagStr:String = "d" + r;
            if (turretMC)
                turretMC.gotoAndStop(flagStr);
        }
    }
}
