package events.cangKu
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import vo.cangKu.WuPingInfoVO;
	
	public class MenuEvent extends Event
	{
		public static const ADDMENU_EVENT:String="addMenuEvent";
		
		public var wuPinginfo:WuPingInfoVO;
		public var mcPoint:Point;
		public var isLeft:Boolean;
		public function MenuEvent(type:String, info:WuPingInfoVO, bool:Boolean, point:Point)
		{
			super(type, false, false);
			wuPinginfo=info;
			mcPoint=point;
			isLeft=bool;
		}
	}
}