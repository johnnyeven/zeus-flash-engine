package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	import view.login.LoginBGComponent;
	
	[SWF(width="1028", height="600", backgroundColor="0x000000",frameRate="30")]
	public class Main extends Sprite
	{
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
			Security.allowDomain("*");
		}
		
		public function init(evt: Event = null): void
		{
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			LoginBGComponent.getInstance().destroy();
			ApplicationFacade.getInstance().start(this);
		}
	}
}