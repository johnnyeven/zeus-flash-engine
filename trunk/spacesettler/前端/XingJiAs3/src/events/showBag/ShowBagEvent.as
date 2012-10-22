package events.showBag
{
	import flash.events.Event;
	
	import vo.cangKu.BaseItemVO;
	
	/**
	 * 展示装备
	 * @author lw
	 * 
	 */	
	public class ShowBagEvent extends Event
	{
		public static const SHOW_DATA_EVENT:String = "showDataEvent";
		
		public static const CLOSE_EVENT:String = "closeEvent";
		
		private var _baseItemVO:BaseItemVO;
		
		public function ShowBagEvent(type:String, itemVO:BaseItemVO,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_baseItemVO = itemVO;
		}

		public function get baseItemVO():BaseItemVO
		{
			return _baseItemVO;
		}

		public function set baseItemVO(value:BaseItemVO):void
		{
			_baseItemVO = value;
		}


	}
}