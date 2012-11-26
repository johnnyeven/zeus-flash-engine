package enum.battle
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 *战斗中的坐标。距离等的计算 
	 * @author lw
	 * 
	 */	
	public class FightPointEnum
	{
		public static function getDis(obj1:DisplayObject,obj2:DisplayObject):Number
		{ 
			var point1:Point;
			var point2:Point;
			if(obj1["itemVO"].voType == FightVOTypeEnum.building)
			{
				point1 = obj1.localToGlobal(new Point(75,75));
			}
			else
			{
				point1 = obj1.localToGlobal(new Point());
			}
			if(obj2["itemVO"].voType == FightVOTypeEnum.building)
			{
				point2 = obj2.localToGlobal(new Point(75,75));
			}
			else
			{
				point2 = obj2.localToGlobal(new Point());
			}
			
			var distance:Number = Point.distance(point1,point2);
			return distance;
		}
	}
}