package events.cangKu
{
    import flash.events.Event;
    
    import vo.cangKu.BaseItemVO;

    public class ChaKanEvent extends Event
    {
        public static const ADDCHAKANVIEW_EVENT:String = "addChaKanViewEvent";

        public static const CLOSEVIEW_EVENT:String = "closeViewEvent";
		
		public static const USE_EVENT:String="use_event";
		
        public var itemVO:BaseItemVO;

        public function ChaKanEvent(type:String, info:* = null)
        {
            super(type, false, false);
            itemVO = info;
        }
    }
}
