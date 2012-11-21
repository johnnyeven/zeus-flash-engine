package view.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import enum.FontEnum;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;

	/**
	 *战场掉数字
	 * 减血、加血
	 * @author zn
	 *
	 */
	public class FightDropNumComponent extends Component
	{
		public var label:Label;
		private var _num:Number;

		private var tweenLite:TweenLite;

		public function FightDropNumComponent()
		{
			super(null);
			label=new Label();
			label.autoSize=true;			
			label.size=14;
			label.fontName=FontEnum.WEI_RUAN_YA_HEI;
			addChild(label);
		}


		public override function dispose():void
		{
			if (tweenLite)
				tweenLite.kill();
			super.dispose();
		}


		public function get num():Number
		{
			return _num;
		}

		public function set num(value:Number):void
		{
			_num=value;
			if(value<0)
			{
				label.color=0xFF0000;
			}else
			{
				label.color=0x00FF00;
			}
			label.text=int(value) + "";
		}

		public function start():void
		{
			var endY:Number=y - 150;
			tweenLite=TweenLite.to(this, 2, {y: endY, ease: Linear.easeNone, onComplete: complete});
		}

		public function complete():void
		{
			dispose();
		}
	}
}
