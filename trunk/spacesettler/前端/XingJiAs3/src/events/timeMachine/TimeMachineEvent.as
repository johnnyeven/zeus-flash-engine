package events.timeMachine
{
	import flash.events.Event;
	
	import view.timeMachine.TimeMachineItem;

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
		public static const SPEED_EVENT:String = "speedEvent";
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
		
		private var _count:int;
		
		private var _item:TimeMachineItem;
		public function TimeMachineEvent(type:String,idType:int,count:int, bubbles:Boolean=false, cancelable:Boolean=false,item:TimeMachineItem=null)
		{
			_idType = idType;
			_count = count;
			_item=item;
			super(type,bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new TimeMachineEvent(type,idType,count,bubbles,cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("TimeMachineEvent");
		}

		public function get idType():int
		{
			return _idType;
		}

		public function set idType(value:int):void
		{
			_idType = value;
		}

		public function get count():int
		{
			return _count;
		}

		public function set count(value:int):void
		{
			_count = value;
		}

		public function get item():TimeMachineItem
		{
			return _item;
		}

		public function set item(value:TimeMachineItem):void
		{
			_item = value;
		}


	}
}