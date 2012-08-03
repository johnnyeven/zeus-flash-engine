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
	public class CBlackScreen extends Sprite 
	{
		private var easeType: String;
		private var duration: int;
		private var amount: Number;
		private var blackScreenData: BitmapData;
		private var blackScreen: Bitmap;
		
		public function CBlackScreen(easeType: String, duration: int, amount: Number) 
		{
			super();
			if (easeType != CEaseType.EaseIn && easeType != CEaseType.EaseOut)
			{
				this.easeType = CEaseType.EaseOut;
			}
			else
			{
				this.easeType = easeType;
			}
			this.duration = duration;
			this.amount = amount;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			drawBlackScreen();
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function drawBlackScreen(): void
		{
			blackScreenData = new BitmapData(GlobalContextConfig.Width, GlobalContextConfig.Height, true, 0xFF000000);
			blackScreen = new Bitmap(blackScreenData);
			addChild(blackScreen);
			blackScreen.cacheAsBitmap = true;
			
			if (easeType == CEaseType.EaseIn)
			{
				blackScreen.alpha = 0;
			}
			else (easeType == CEaseType.EaseOut)
			{
				blackScreen.alpha = 1;
			}
		}
		
		private function render(evt: Event): void
		{
			if (easeType == CEaseType.EaseIn)
			{
				blackScreen.alpha += amount;
			}
			else
			{
				blackScreen.alpha -= amount;
			}
			if (blackScreen.alpha >= 1 || blackScreen.alpha <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, render);
				stage.removeChild(this);
			}
		}
	}

}