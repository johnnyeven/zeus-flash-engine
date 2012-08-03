package Apollo.Objects.Effects.screen 
{
	import Apollo.Scene.CApolloScene;
	import Apollo.Objects.Effects.CEaseType;
	import Apollo.Configuration.*;
	
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class CBloodScreen extends Sprite 
	{
		private var screenData: BitmapData;
		private var screen: Bitmap;
		private var flag: int;
		private var amount: Number
		private var stopFlag: Boolean;
		
		public function CBloodScreen(amount: Number) 
		{
			super();
			flag = 1;
			this.amount = amount;
			stopFlag = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			drawScreen();
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function drawScreen(): void
		{
			screenData = GlobalContextConfig.ResourcePool.getCharacter("bloodScreen");
			screen = new Bitmap(screenData);
			addChild(screen);
			screen.cacheAsBitmap = true;
			screen.alpha = 0;
		}
		
		private function render(evt: Event): void
		{
			screen.alpha += (flag * amount);
			if (screen.alpha >= 1)
			{
				flag = -1;
			}
			else if (screen.alpha <= 0)
			{
				if (stopFlag)
				{
					removeEventListener(Event.ENTER_FRAME, render);
					stage.removeChild(this);
				}
				else
				{
					flag = 1;
				}
			}
		}
		
		public function stop(): void
		{
			stopFlag = true;
		}
	}

}