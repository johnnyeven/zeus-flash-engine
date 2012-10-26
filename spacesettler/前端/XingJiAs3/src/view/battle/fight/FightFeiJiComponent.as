package view.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.ObjectUtil;
	import com.zn.utils.PointUtil;
	import com.zn.utils.RandomUtil;

	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 *小飞机
	 * @author zn
	 *
	 */
	public class FightFeiJiComponent extends FightZhanCheComponent
	{
		public static const DA_FEI_JI:int=13;
		public static const XIAO_FEI_JI:int=14;
		public static const LIAO_JI:int=15;

		public static var feiJiList:Array=[];

		/**
		 *大飞机移动路径
		 */
		public static var movePathList:Array;

		public var oldTargetPoint:Point;

		public var gid:uint;

		public var movePathIndex:int=0;

		public function FightFeiJiComponent(zhanCheVO:CHARIOT)
		{
			super(zhanCheVO);
			buttonMode=true;
			feiJiList.push(this);
		}

		/**
		 *小飞机移动
		 * @param obj
		 *
		 */
		public function feiJiMoveTO(obj:DisplayObject):void
		{
			var p:Point=new Point(obj.x, obj.y);
			if (oldTargetPoint && oldTargetPoint.equals(p))
				return;

			var dis:Number=PointUtil.getDis(this, obj);
			var time:Number=dis / itemVO.myMoveSpeed;
			moveTweenLite=TweenLite.to(this, time, {x: obj.x, y: obj.y, ease: Linear.easeNone});
			oldTargetPoint=p;

			//调整角度
			zhanCheRotation=PointUtil.getRotaion(new Point(x, y), p);
		}

		public function movePath(init:Boolean=false):void
		{
			if (movePathIndex >= movePathList.length)
				movePathIndex=0;

			var p:Point=movePathList[movePathIndex];

			if (init)
			{
				var objDic:Object=ObjectUtil.CreateDic(feiJiList, "movePathIndex");
				do
				{
					movePathIndex=RandomUtil.getRangeInt(0, movePathList.length - 1);
				} while (objDic[movePathIndex]);

				p=movePathList[movePathIndex];
				x=p.x;
				y=p.y;
				movePathIndex++;
			}

			p=movePathList[movePathIndex];
			var cP:Point=new Point(x, y);
			var dis:Number=Point.distance(cP, p);
			var time:Number=dis / itemVO.myMoveSpeed;
			moveTweenLite=TweenLite.to(this, time, {x: p.x, y: p.y, ease: Linear.easeNone, onComplete: moveComplete});

			//调整角度
			zhanCheRotation=PointUtil.getRotaion(cP, p);
		}

		private function moveComplete():void
		{
			movePathIndex++;
			movePath();
		}
	}
}
