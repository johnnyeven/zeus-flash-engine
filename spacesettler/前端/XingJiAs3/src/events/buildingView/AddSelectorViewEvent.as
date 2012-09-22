package events.buildingView
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 *
	 * @author zn
	 *
	 */
	public class AddSelectorViewEvent extends Event
	{
		public static const ADDSELECTORVIEW_EVENT:String="addSelectorViewEvent";
		
		public static const BACK_EVENT:String = "back_event";
		
		private var _upLabel:String;
		private var _rightLabel:String;
		private var _leftLabel:String;
		
		public var count:int;
		public var point:Point;
		private var _buildType:int;

		public function AddSelectorViewEvent(type:String, up:String=null, right:String=null, left:String=null, count:int=0, point:Point=null,
			buildType:int=0)
		{
			super(type, false, false);
			this._upLabel=up;
			this._rightLabel=right;
			this._leftLabel=left;
			this.count=count;
			this.point=point;
			_buildType=buildType;
		}

		public override function clone():Event
		{
			return new AddSelectorViewEvent(type, upLabel, rightLabel, leftLabel, count, point);
		}
		
		public override function toString():String
		{
			return formatToString("AddSelectorViewEvent");
		}
		
		public function get leftLabel():String
		{
			return _leftLabel;
		}

		public function set leftLabel(value:String):void
		{
			_leftLabel = value;
		}

		public function get rightLabel():String
		{
			return _rightLabel;
		}

		public function set rightLabel(value:String):void
		{
			_rightLabel = value;
		}

		public function get upLabel():String
		{
			return _upLabel;
		}

		public function set upLabel(value:String):void
		{
			_upLabel = value;
		}
		
		public function get buildType():int
		{
			return _buildType;
		}
	}
}