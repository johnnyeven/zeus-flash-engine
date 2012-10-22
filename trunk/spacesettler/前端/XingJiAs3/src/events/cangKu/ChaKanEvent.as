package events.cangKu
{
    import flash.events.Event;
    
    import vo.cangKu.BaseItemVO;

    public class ChaKanEvent extends Event
    {
        public static const ADDCHAKANVIEW_EVENT:String = "addChaKanViewEvent";

        public static const CLOSEVIEW_EVENT:String = "closeViewEvent";
		
		public static const USE_EVENT:String="use_event";
		
		public static const QIANGHUA_EVENT:String="qianghua_event";
		
		public static const ZHUANGPEI_EVENT:String="zhuangpei_event";

		public static const WEIXIU_EVENT:String="weixiu_event";
		
		
        public var itemVO:BaseItemVO;

        public function ChaKanEvent(type:String, info:* = null)
        {
            super(type, false, false);
            itemVO = info;
        }
    }
}
