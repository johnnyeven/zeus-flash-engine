package view.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.PointUtil;
	import com.zn.utils.RotationUtil;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import ui.core.Component;
	import ui.utils.DisposeUtil;

	/**
	 *战车
	 * @author zn
	 *
	 */
	public class FightZhanCheComponent extends Component
	{
		public static const RANGE:int=200;
		
		public var itemVO:CHARIOT;

		public var zhanCheSP:Sprite;

		public var paoTaMC:MovieClip;

		public var zhanCheMC:MovieClip;

		public var effectSp:Sprite=new Sprite();

		private var _zhanCheRotation:Number;
		private var _tankPartRotaion:Number;

		public var moveTweenLite:TweenLite;

		private var _defenseMC:MovieClip;
		
		//检测战车移动的下一个点替用的对象
		public var disPlayObj:DisplayObject;
		
		public function FightZhanCheComponent(zhanCheVO:CHARIOT)
		{
			super(null);

			cacheAsBitmap=true;
			
			this.itemVO=zhanCheVO;
			zhanCheSP=ClassUtil.getObject("battle.zhanChe_" + zhanCheVO.category);
			addChild(zhanCheSP);
	
			paoTaMC=zhanCheSP.getChildByName("taMC") as MovieClip;
			zhanCheMC=zhanCheSP.getChildByName("zhanChe") as MovieClip;

			if (paoTaMC)
				paoTaMC.gotoAndStop(1);

			if (zhanCheMC)
				zhanCheMC.gotoAndStop(1);

			addChild(effectSp);
		}

		public function stopMove():void
		{
			if (moveTweenLite)
				moveTweenLite.kill();
			moveTweenLite=null;
		}


		public function get zhanCheRotation():Number
		{
			return _zhanCheRotation;
		}

		public function set zhanCheRotation(value:Number):void
		{
			if (value == 360)
				value=0;

			_zhanCheRotation=value;

			var r:int=Math.round(value / 20) * 2;

			if (r == 36)
				r=0;

			var flagStr:String="d" + r;
			if (zhanCheMC)
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
				value=0;

			_tankPartRotaion=value;

			var r:int=Math.round(value / 20) * 2;

			if (r == 36)
				r=0;

			var flagStr:String="d" + r;
			if (paoTaMC)
				paoTaMC.gotoAndStop(flagStr);
		}
		
		/**
		 *获取随机坐标 
		 * @return 
		 * 
		 */
		public function getAreaRangePoint():Point
		{
			var x:Number=Math.random()*RANGE-RANGE*0.5;
			var y:Number=Math.random()*RANGE-RANGE*0.5;
			return new Point(x,y);
		}

		public function get defenseMC():MovieClip
		{
			return _defenseMC;
		}

		public function set defenseMC(value:MovieClip):void
		{
			DisposeUtil.dispose(value);
			
			_defenseMC = value;
		}

	}
}
