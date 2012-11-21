package events.battle
{
	import flash.events.Event;
	
	/**
	 *战场编辑弹出信息提示框 
	 * @author lw
	 * 
	 */	
	public class BattleEditorConditionInforEvent extends Event
	{
		public static const BATTLE_EDITOR_CONDITION_INFOR_EVENT:String = "battleEditorConditionInforEvent";
		
		private var _data:Object;
		public function BattleEditorConditionInforEvent(type:String,data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

	}
}