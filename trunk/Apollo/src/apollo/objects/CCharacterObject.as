///////////////////////////////////////////////////////////
//  CCharacterObject.as
//  Macromedia ActionScript Implementation of the Class CCharacterObject
//  Generated by Enterprise Architect
//  Created on:      15-二月-2012 10:17:54
//  Original author: johnnyeven
///////////////////////////////////////////////////////////

package apollo.objects
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import apollo.controller.CBaseController;
	import apollo.display.TextFieldEx;
	import apollo.controller.Action;

	/**
	 * @author johnnyeven
	 * @version 1.0
	 * @created 15-二月-2012 10:17:54
	 */

	public class CCharacterObject extends CActionObject
	{
		protected var _characterName: String;
		protected var _level: uint = 1;
		
		protected var _nameDisplayBuffer: Bitmap;
		/**
		 * 
		 * @param _ctrl
		 */
		public function CCharacterObject(_ctrl:CBaseController = null, _direction: uint = CDirection.DOWN)
		{
			super(_ctrl, _direction);
		}

		/**
		 * 
		 * @param level
		 */
		public function set level(level:uint): void
		{
			_level = level;
			Upgrade();
		}

		public function get level(): uint
		{
			return _level;
		}
		
		override protected function initBuffer(): void
		{
			super.initBuffer();
		}

		public function get characterName(): String
		{
			return _characterName;
		}

		/**
		 * 
		 * @param _name
		 * @param _color
		 * @param _borderColor
		 */
		public function setCharacterName(_name:String, _color:Number, _borderColor:Number): void
		{
			if (_name == "" || _name == null)
			{
				return;
			}
			_characterName = _name;
			
			var nameText: TextFieldEx = new TextFieldEx('', 0xFFFFFF);
			nameText.text = _name;
			nameText.autoIncrease();
			nameText.textColor = _color;
			nameText.fontBorder = _borderColor;
			nameText.align = TextFieldEx.CENTER;
			
			if (_nameDisplayBuffer != null)
			{
				_nameDisplayBuffer.bitmapData.dispose();
			}
			else
			{
				_nameDisplayBuffer = new Bitmap();
			}
			
			var _nameBitmapData: BitmapData = new BitmapData(nameText.width, nameText.height, true, 0x00000000);
			_nameBitmapData.draw(nameText);
			
			_nameDisplayBuffer.bitmapData = _nameBitmapData;
			autoFixNamePos();
			addAdditionalDisplay(_nameDisplayBuffer);
			
			nameText = null;
		}
		
		protected function autoFixNamePos(): void
		{
			_nameDisplayBuffer.x = -int(_nameDisplayBuffer.width / 2);
			_nameDisplayBuffer.y = -int(_graphic.frameHeight);
		}
		
		override protected function enterFrame(): Boolean
		{
			if (!super.enterFrame())
			{
				return false;
			}
			else
			{
				//进入透明碰撞区域，设置透明度
				_renderBuffer.alpha = _controller.perception.scene.map.isInAlphaArea(pos.x, pos.y) ? 0.5 : 1;
				return true;
			}
		}
		
		override protected function rebuild(): void
		{
			super.rebuild();
			if (_nameDisplayBuffer != null)
			{
				autoFixNamePos();
			}
		}

		override public function Upgrade(): void
		{
			super.Upgrade();
		}
	} //end CCharacterObject

}