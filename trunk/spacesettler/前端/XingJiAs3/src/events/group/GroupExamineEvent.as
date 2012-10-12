package events.group
{
	import flash.events.Event;
	
	/**
	 *审核成员所用的event； 
	 * @author Administrator
	 * 
	 */	
	public class GroupExamineEvent extends Event
	{
		public static const ALLOW:String="allow";
		
		public static const REFUSE:String="refuse";
		
		
		private var _playerId:String;
		private var _applyId:String;
		public function GroupExamineEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false
		playerId:String=null,applyId:String=null)
		{
			super(type, bubbles, cancelable);
			_playerId=playerId;
			_applyId=applyId;
		}

		public function get playerId():String
		{
			return _playerId;
		}

		public function set playerId(value:String):void
		{
			_playerId = value;
		}

		public function get applyId():String
		{
			return _applyId;
		}

		public function set applyId(value:String):void
		{
			_applyId = value;
		}


	}
}