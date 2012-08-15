package apollo.objects 
{
	/**
	 * ...
	 * @author john
	 */
	public class CDirection 
	{
		public static const DOWN: uint = 0;
		public static const RIGHT: uint = 2;
		public static const TOP: uint = 3;
		public static const LEFT: uint = 1;
		public static const LEFT_DOWN: uint = 4;
		public static const RIGHT_DOWN: uint = 5;
		public static const LEFT_TOP: uint = 6;
		public static const RIGHT_TOP: uint = 7;
		
		public function CDirection() 
		{
			
		}
		
		public static function getRadians(x: Number, y: Number): Number
		{
			return Math.atan2(y, x);
		}
		
		/**
		 * 角度转弧度
		 * @param	value
		 * @return
		 */
		public static function degressToRadians(value: Number): Number
		{
			return value * Math.PI / 180;
		}
		
		/**
		 * 弧度转角度
		 * @param	value
		 * @return
		 */
		public static function radiansToDegress(value: Number): Number
		{
			return int(value * 180 / Math.PI);
		}
	}

}