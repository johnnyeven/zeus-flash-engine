package apollo.objects.effects 
{
	import apollo.objects.CActionObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author john
	 */
	public class CSingBar 
	{
		private var target: CActionObject;
		private var maxValue: Number;
		private var _currentValue: Number;
		private var singBar: Sprite;
		private var processBar: Shape;
		
		private const singBarWidth: int = 100;
		private const singBarHeight: int = 10;
		private const processBarWidth: int = 97;
		
		public function CSingBar(target: CActionObject, maxValue: Number) 
		{
			this.target = target;
			_currentValue = 0;
			this.maxValue = maxValue;
			singBar = new Sprite();
			processBar = new Shape();
			processBar.x = 2;
			processBar.y = 2;
			singBar.addChild(processBar);
			draw();
		}
		
		private function draw(): void
		{
			drawBorder();
			drawProcess();
			singBar.x = -(singBar.width / 2);
			singBar.y = 10;
			target.addAdditionalDisplay(singBar);
		}
		
		private function drawBorder(): void
		{
			singBar.graphics.lineStyle(1, 0x00FF00);
			singBar.graphics.drawRect(0, 0, singBarWidth, singBarHeight);
		}
		
		private function drawProcess(): void
		{
			processBar.graphics.clear();
			var per: Number = _currentValue / maxValue;
			processBar.graphics.beginFill(0x00FF00);
			processBar.graphics.drawRect(0, 0, processBarWidth * per, singBarHeight - 3);
			processBar.graphics.endFill();
		}
		
		public function set currentValue(value: Number): void
		{
			if (value < maxValue && value >=0)
			{
				_currentValue = maxValue - value;
			}
			drawProcess();
		}
		
		public function get currentValue(): Number
		{
			return _currentValue;
		}
		
		public function destroy(): void
		{
			target.removeAdditionalDisplay(singBar);
			processBar.graphics.clear();
			singBar.graphics.clear();
			
			processBar = null;
			singBar = null;
		}
	}

}