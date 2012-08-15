package apollo.graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.events.*;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import apollo.events.MapEvent;
	import apollo.configuration.*;
	import apollo.utils.loader.CClassLoader;
	import apollo.events.ResourceEvent;
	import apollo.utils.Conversion;
	
	import wooha.resources.character.*;
	import wooha.resources.font.*;
	
	/**
	 * ...
	 * @author john
	 */
	public class CGraphicPoolEmbed implements IGraphicPool 
	{
		private static var instance: CGraphicPoolEmbed;
		private static var allowInstance: Boolean = false;
		private var eventDispatcher: EventDispatcher;
		/**
		 * 反射引用
		 */
		private var referDefault: Default;
		private var referBloodScreen: bloodScreen;
		private var referPrepareSkill1: prepareSkill1;
		private var referSkill1_EXPLODE: skill1_EXPLODE;
		private var referSkill1_FIRE: skill1_FIRE;
		private var referSkill2_EXPLODE: skill2_EXPLODE;
		private var referSkill3_EXPLODE: skill3_EXPLODE;
		private var referSkill4_EXPLODE: skill4_EXPLODE;
		private var referSkill5_EXPLODE: skill5_EXPLODE;
		private var referPrepareSkill: prepareSkill;
		private var referRangeAttack: rangeAttack;
		private var referChar1: char1;
		private var referChar2: char2;
		private var referChar3: char3;
		private var referChar4: char4;
		private var referChar5: char5;
		private var referChar6: char6;
		private var referChar7: char7;
		private var referChar8: char8;
		private var referChar9: char9;
		private var referChar10: char10;
		private var tst: test;
		
		private var referFontArialBlack: FontArialBlack;
		private var referFontYuanGBK: FontYuanGBK;
		/**
		 * 资源池
		 */
		protected var _pool: Dictionary;
		
		public function CGraphicPoolEmbed() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CGraphicPool类不允许实例化");
				return;
			}
			eventDispatcher = new EventDispatcher(this);
			_pool = new Dictionary();
		}
		
		public static function getInstance(): CGraphicPoolEmbed
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CGraphicPoolEmbed();
				allowInstance = false;
			}
			return instance;
		}
		
		public function init(): void
		{
			//加载资源列表
			dispatchEvent(new ResourceEvent(ResourceEvent.RESOURCES_LOADED));
		}
		
		public function addResource(resourceId: String, content: BitmapData): void
		{
			if (_pool[resourceId] == null)
			{
				_pool[resourceId] = content;
			}
		}
		
		public function getResource(domainId: String, resourceId: String): BitmapData
		{
			if (domainId == "character")
			{
				return getCharacter(resourceId);
			}
			else
			{
				return _pool[resourceId];
			}
		}
		
		public function getCharacter(resourceId: String): BitmapData
		{
			if (_pool[resourceId] == null)
			{
				var _class: Class = getDefinitionByName("wooha.resources.character." + resourceId) as Class;
				var _display: BitmapData = Conversion.Bitmap(_class);
				_pool[resourceId] = _display;
			}
			return _pool[resourceId];
		}
		
		public function getFont(resourceId: String): Font
		{
			if (_pool[resourceId] == null)
			{
				var _class: Class = getDefinitionByName("wooha.resources.font." + resourceId) as Class;
				Font.registerFont(_class);
				var _font: Font = new _class() as Font;
				_pool[resourceId] = _font;
			}
			return _pool[resourceId];
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return eventDispatcher.willTrigger(type);
		}
		
	}

}