package apollo.objects.effects 
{
	import apollo.events.SkillEvent;
	import apollo.objects.*;
	import apollo.controller.CBaseController;
	import apollo.scene.*;
	import apollo.configuration.*;
	import apollo.display.TextFieldEx;
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class CBloodEffect extends Sprite 
	{
		/**
		 * 使用者
		 */
		protected var _master: CGameObject;
		protected var _flag: Boolean;
		protected var _power: int;
		protected var text: TextFieldEx;
		protected var acceleration: Number;
		protected var speedX: Number;
		protected var speedY: Number;
		
		public function CBloodEffect(_master: CGameObject, _power: int) 
		{
			super();
			this._master = _master;
			this._power = _power;
			if (_power >= 0)
			{
				//伤血
				acceleration = 1;
				speedX = -3;
				speedY = -7;
				_flag = false;
				text = new TextFieldEx("-" + _power.toString(), 0xFF0000, -1, 0x000000, 24, "FontArialBlack");
			}
			else
			{
				//加血
				acceleration = 0.1;
				speedX = 0;
				speedY = -5;
				_flag = true;
				text = new TextFieldEx("+" + (-_power).toString(), 0x00FF00, -1, 0x000000, 24, "FontArialBlack");
			}
			text.autoIncrease();
			text.align = TextFieldEx.CENTER;
			addChild(text);
			initTextPos();
			_master.addChild(this);
			addEventListener(Event.ENTER_FRAME, RenderObject);
		}
		
		private function initTextPos(): void
		{
			x = -(text.width / 2);
			y = -(_master.graphic.frameHeight + text.height);
		}
		
		protected function RenderObject(event: Event): void
		{
			if (!_flag)
			{
				if (speedY > 0)
				{
					alpha -= 0.05;
				}
				if (alpha <= 0)
				{
					removeEventListener(Event.ENTER_FRAME, RenderObject);
					_master.removeChild(this);
					text = null;
				}
				x += speedX;
				y += speedY;
				speedY += acceleration;
			}
			else
			{
				if (speedY <= 3)
				{
					alpha -= 0.05;
				}
				if (speedY < 0)
				{
					x += speedX;
					y += speedY;
					speedY += acceleration;
				}
				if (alpha <= 0)
				{
					removeEventListener(Event.ENTER_FRAME, RenderObject);
					_master.removeChild(this);
					text = null;
				}
			}
		}
	}

}