package events.timeMachine
{
	import flash.events.Event;
	/**
	 *时间机器 
	 * @author lw
	 * 
	 */	
	public class TimeMachineEvent extends Event
	{
		/**
		 * 全部加速
		 */		
		public static const ALL_SPEED_EVENT:String = "allSpeedEvent";
		/**
		 * 加速
		 */		
		public static const SPEED_EVENT:String = "allSpeedEvent";
		/**
		 * 关闭
		 */
		public static const CLOSE_EVENT:String = "closeEvent";
		/**
		 * 显示信息界面
		 */
		public static const SHOW_INFOR_COMPONENT_EVENT:String = "showInforComponentEvent";
		
		/**
		 * 关闭信息界面
		 */
		public static const CLOSE_INFOR_COMPONENT_EVENT:String ="closeInforComponentEvent";
		
		/**
		 *显示时间机器界面
		 */
		public static const SHOW_COMPONENT_EVENT:String ="showComponentEvent";
		
		private var _idType:int;
		
		public function TimeMachineEvent(type:String,idType:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_idType = idType;
			super(type,bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new TimeMachineEvent(type,idType,bubbles,cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("TimeMachineEvent","type","bubbles","cancelable");
		}

		public function get idType():int
		{
			return _idType;
		}

		public function set idType(value:int):void
		{
			_idType = value;
		}

	}
}