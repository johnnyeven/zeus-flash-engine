package utils.battle
{
    import com.zn.log.Log;
    import com.zn.utils.BitmapUtil;
    
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;

    /**
     *战场解析
     * @author zn
     *
     */
    public class BattleParseUtils
    {

        /**
         *获取战车开始坐标
         * @param cDis
         * @return
         *
         */
        public static function getStartPoint(cDis:DisplayObjectContainer,remove:Boolean=false):Point
        {
            var obj:DisplayObject = cDis.getChildByName("startPoint");
            if (!obj)
            {
                Log.error(BattleParseUtils, "getStartPoint", "战车开始坐标不存在");
                return new Point();
            }
			if(remove)
				cDis.removeChild(obj);
				
            return new Point(obj.x, obj.y);
        }
		
		public static function getMoveRangeBitmapData(cDis:DisplayObjectContainer,remove:Boolean=false):BitmapData
		{
			var obj:DisplayObject = cDis.getChildByName("moveRange");
			if (!obj)
			{
				Log.error(BattleParseUtils, "getMoveRangeBitmapData", "可移动区域不存在");
				return new BitmapData(1,1);
			}
			if(remove)
				cDis.removeChild(obj);
			return BitmapUtil.drawBitmapData(obj);
		}

        /**
         *是否可移动
         * @param moveBitmapData
         * @param p
         * @return
         *
         */
        public static function canMove(moveBitmapData:BitmapData, p:Point):Boolean
        {
            return moveBitmapData.getPixel32(p.x, p.y) != 0;
        }
    }
}
