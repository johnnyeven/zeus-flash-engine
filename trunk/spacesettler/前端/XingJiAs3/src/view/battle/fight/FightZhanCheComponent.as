package view.battle.fight
{
    import com.greensock.TweenLite;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.RotationUtil;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Point;
    
    import ui.core.Component;

    /**
     *战车
     * @author zn
     *
     */
    public class FightZhanCheComponent extends Component
    {
        public var zhanCheVO:CHARIOT;

        public var zhanCheSP:Sprite;

        public var paoTaMC:MovieClip;

        public var zhanCheMC:MovieClip;
		
		public var effectSp:Sprite=new Sprite();
		
        private var _zhanCheRotation:Number;
        private var _tankPartRotaion:Number;

        public var moveTweenLite:TweenLite;

        public function FightZhanCheComponent(zhanCheVO:CHARIOT)
        {
            super(null);

            this.zhanCheVO = zhanCheVO;
            zhanCheSP = ClassUtil.getObject("battle.zhanChe_" + zhanCheVO.category);
            addChild(zhanCheSP);

            paoTaMC = zhanCheSP.getChildByName("taMC") as MovieClip;
            zhanCheMC = zhanCheSP.getChildByName("zhanChe") as MovieClip;

            paoTaMC.gotoAndStop(1);
            zhanCheMC.gotoAndStop(1);
			
			addChild(effectSp);
        }

        /**
         *下一步将要移动的点
         * @return
         *
         */
        public function get nextMovePoint():Point
        {
            var length:Number = 80;
            var r:Number = RotationUtil.toRadian(zhanCheRotation);
            var nx:Number = Math.cos(r) * length;
            var ny:Number = -Math.sin(r) * length;

            var p:Point = new Point(x + nx, y + ny);
            return p;
        }

        public function stopMove():void
        {
            if (moveTweenLite)
                moveTweenLite.kill();
            moveTweenLite = null;
        }


        public function get zhanCheRotation():Number
        {
            return _zhanCheRotation;
        }

        public function set zhanCheRotation(value:Number):void
        {
            if (value == 360)
                value = 0;

            _zhanCheRotation = value;

            var r:int = Math.round(value / 20) * 2;

            if (r == 36)
                r = 0;

            var flagStr:String = "d" + r;
            zhanCheMC.gotoAndStop(flagStr);

            //            var np:Point = nextMovePoint;
            //            sp.graphics.clear();
            //            sp.graphics.lineStyle(2, 0xFF0000);
            //			sp.graphics.beginFill(0xFF0000);
            //			sp.graphics.moveTo(0,0);
            //            sp.graphics.lineTo(np.x-x, np.y-y);
            //			sp.graphics.drawRect(np.x-x,np.y-y,4,4);
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
            paoTaMC.gotoAndStop(flagStr);
        }
    }
}
