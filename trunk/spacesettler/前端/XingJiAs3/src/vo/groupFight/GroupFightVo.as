package vo.groupFight
{
	import com.zn.utils.DateFormatter;
	
	import ui.vo.ValueObject;
	
	public class GroupFightVo extends ValueObject
	{
		/**
		 *行星名 
		 */		
		public var name:String;
		
		/**
		 *行星类型 1为最外围  5为主星 中间一次类推 
		 */		
		public var type:int;
		
		/**
		 *X坐标 
		 */		
		public var x:int;
		
		/**
		 *y坐标 
		 */		
		public var y:int;
		
		/**
		 *该星球现有战舰数 
		 */		
		public var total_warships:int;
		
		/**
		 *刷新时间 只有TYPE为4 5时才有 
		 */		
		public var refresh_time:int;
		
		/**
		 *资源名称
		 */		
		public var img_name:String;
		
		/**
		 *能连线的行星数组 
		 */		
		public var lines:Array=[];
		
		/**
		 *军团名称
		 */		
		public var legion_name:String="";
		
		/**
		 *是否为自己占领的 
		 */		
		public var isMine:Boolean=false;
		
		/**
		 *自己在此星球上的部署舰队
		 */		
		public var warship:int=0;
		
		public var endTime:int=0;
		
		private var _index:int;
		
		public function GroupFightVo()
		{
			super();
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}
		
		/**
		 *剩余时间 
		 * @return 
		 * 
		 */		
		public function get remainTime():Number
		{
			return Math.max(0,endTime-DateFormatter.currentTime);
		}
		
		public function initTime():void
		{
			endTime= DateFormatter.currentTime + (refresh_time);
		}
	}
}