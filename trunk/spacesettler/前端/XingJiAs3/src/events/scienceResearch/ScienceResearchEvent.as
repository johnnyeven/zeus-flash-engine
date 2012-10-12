package events.scienceResearch
{
	import flash.events.Event;
	
	/**
	 *科研 
	 * @author lw
	 * 
	 */	
	public class ScienceResearchEvent extends Event
	{
		public static const CLOSE_EVENT:String = "closeEvent";
		
		public static const INFOR_EVENT:String = "inforEvent";
		
		public static const RESEARCH_EVENT:String = "researchEvent";
		
		public static const CLOSE_INFOR_EVENT:String = "closeInforEvent";
		
		public static const POPU_EVENT:String = "popuEvent";
		
		public static const POPU_UP_EVENT:String = "popuUpEvent";
		
		public static const POPU_CLOSE_EVENT:String = "popuCloseEvent";
		/**
		 *研究完成后的数据更新 
		 */		
		public static const GET_DATA_RESULT:String = "getDataResult";
		
		private var _scienceType:int;
		
		public function ScienceResearchEvent(type:String, scienceType:int,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_scienceType = scienceType;
		}

		public function get scienceType():int
		{
			return _scienceType;
		}

		public function set scienceType(value:int):void
		{
			_scienceType = value;
		}

	}
}