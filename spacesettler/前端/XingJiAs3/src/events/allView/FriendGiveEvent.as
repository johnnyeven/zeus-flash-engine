package events.allView
{
	import flash.events.Event;
	
	public class FriendGiveEvent extends Event
	{
		public static const SHOW_FRIENDGIVE:String="show_friendgive";
		
		public static const CLOSE_FRIENDGIVE:String="close_friendgive";
		
		public static const SURE_BTN_CLICK:String="sure_btn_click";
		
		private var _arr:Array=[];
		private var _text:String;
		private var _num:int;
		private var _titleText:String;
		public function FriendGiveEvent(type:String=null,arr:Array=null,text:String=null,num:int=0,titleText:String=null)
		{
			super(type,false,false);
			_arr=arr;
			_text=text;
			_num=num;
			_titleText=titleText;
		}

		public function get arr():Array
		{
			return _arr;
		}

		public function set arr(value:Array):void
		{
			_arr = value;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
		}

		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = value;
		}

		public function get titleText():String
		{
			return _titleText;
		}

		public function set titleText(value:String):void
		{
			_titleText = value;
		}


	}
}