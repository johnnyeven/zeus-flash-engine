package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	[SWF(width = "800", height = "500", backgroundColor = "0xCCCCCC", frameRate="30")]
	public class Main extends Sprite
	{
		public var txtReceiver: TextField;
		public var btnSender: Sprite;
		
		public function Main()
		{
			if(stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init(evt: Event = null): void
		{
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			txtReceiver = new TextField();
			txtReceiver.width = 200;
			txtReceiver.height = 30;
			txtReceiver.x = 10;
			txtReceiver.y = 10;
			txtReceiver.border = true;
			addChild(txtReceiver);
			
			btnSender = new Sprite();
			btnSender.graphics.beginFill(0xFFFFFF);
			btnSender.graphics.drawRect(0, 0, 120, 30);
			btnSender.graphics.endFill();
			btnSender.width = 120;
			btnSender.height = 30;
			btnSender.x = 220;
			btnSender.y = 10;
			addChild(btnSender);
			ApplicationFacade.getInstance().start(this);
		}
	}
}