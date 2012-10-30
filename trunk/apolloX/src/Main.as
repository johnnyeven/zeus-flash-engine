package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	import utils.GameManager;
	
	import view.login.LoginBGComponent;
	
	[SWF(width="1028", height="600", backgroundColor="0x000000",frameRate="30")]
	public class Main extends GameManager
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
			//LoginBGComponent.getInstance().destroy();
			ApplicationFacade.getInstance().start(this);
		}
		
		private function showVersion(): void
		{
			
		}
	}
}