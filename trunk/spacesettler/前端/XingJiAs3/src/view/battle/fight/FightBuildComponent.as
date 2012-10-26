package view.battle.fight
{
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    import mx.binding.utils.BindingUtils;
    
    import ui.core.Component;
    import ui.utils.DisposeUtil;

    /**
     *战场建筑
     * @author zn
     *
     */
    public class FightBuildComponent extends Component
    {
        public var itemVO:FORTBUILDING;

        private var _buildSp:Sprite;

        private var _tankPartRotaion:Number;

        public function FightBuildComponent(buildVO:FORTBUILDING)
        {
            super(null);

            buttonMode = true;
            this.itemVO = buildVO;

            x = buildVO.x;
            y = buildVO.y;

            cwList.push(BindingUtils.bindSetter(stateChange, buildVO, "state"));
        }

        private function stateChange(value:*):void
        {
            DisposeUtil.dispose(_buildSp);

            var className:String = "";

            if (itemVO.type == 1 || itemVO.type == 2)
                className = StringUtil.formatString("build_icon_{0}_normal", itemVO.type);
            else
                className = StringUtil.formatString("battle.build_{0}", itemVO.type);

            _buildSp = ClassUtil.getObject(className);
            if (turretMC)
                turretMC.gotoAndStop(1);

            addChild(_buildSp);

        }

        public function get turretMC():MovieClip
        {
            return _buildSp.getChildByName("taMC") as MovieClip;
        }

        public function get tankPartRotaion():Number
        {
            return _tankPartRotaion;
        }

        public function set tankPartRotaion(value:Number):void
        {
            if (value == 360)
                value = 0;

            _tankPartRotaion = value;

            var r:int = Math.round(value / 20) * 2;

            if (r == 36)
                r = 0;

            var flagStr:String = "d" + r;
            if (turretMC)
                turretMC.gotoAndStop(flagStr);
        }
    }
}
