package utils.liteui.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import utils.UIUtils;
	
	public class Component extends Sprite
	{
		private var _isDispose: Boolean;
		private var _enabled: Boolean;
		private var _eventListener: Dictionary;
		private var _skin: DisplayObjectContainer;
		protected var _filterColor: Number = 0x000000;
		protected var _filterEnabled: Boolean = true;
		protected var _skinChildIndex: Dictionary;
		protected var _skinChildIndexList: Array;
		
		public function Component(_skin: DisplayObjectContainer = null)
		{
			super();
			
			_isDispose = false;
			_enabled = true;
			_skinChildIndex = new Dictionary();
			_skinChildIndexList = new Array();
			this._skin = _skin;
			if(this._skin != null)
			{
				UIUtils.setCommonProperty(this, _skin);
				while(this._skin.numChildren > 0)
				{
					var _child: DisplayObject = this._skin.getChildAt(0);
					addChild(_child);
					
					_skinChildIndex[_child.name] = _child;
					_skinChildIndexList.push(_child.name);
					
					if(_child is InteractiveObject)
					{
						(_child as InteractiveObject).mouseEnabled = false;
					}
				}
			}
			
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		public function getUI(_componentClass: Class, _skinName: String): Sprite
		{
			var _ui: Sprite = new _componentClass(getSkin(_skinName)) as Sprite;
			return _ui;
		}
		
		protected function getSkin(_skinName: String): DisplayObject
		{
			var _child: DisplayObject = _skin.getChildByName(_skinName);
			if(_child != null)
			{
				return _child;
			}
			throw new Error("getSkin(_skinName): " + _skinName + " 未定义");
		}
		
		protected function onMouseOver(evt: MouseEvent): void
		{
			
		}
		
		protected function onMouseOut(evt: MouseEvent): void
		{
			
		}
		
		protected function setFilter(): void
		{
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			if(_eventListener == null)
			{
				_eventListener = new Dictionary();
			}
			
			var _listener: Vector.<Function>;
			if(_eventListener[type] != null)
			{
				_listener = _eventListener[type] as Vector.<Function>;
				var _index: int = _listener.indexOf(listener);
				if(_index == -1)
				{
					_listener.push(listener);
				}
				else
				{
					_listener[_index] = listener;
				}
				_eventListener[type] = _listener;
			}
			else
			{
				_listener = new Vector.<Function>();
				_listener.push(listener);
				_eventListener[type] = _listener;
			}
		}
		
		public function dispose(): void
		{
			if(_isDispose)
			{
				return;
			}
			if(parent != null)
			{
				parent.removeChild(this);
			}
			removeEventListeners();
			removeChildren();
			
			_isDispose = true;
		}
		
		public function removeEventListeners(): void
		{
			if(_eventListener != null)
			{
				for(var type: String in _eventListener)
				{
					removeEventListenerType(type);
				}
				_eventListener = null;
			}
		}
		
		protected function removeEventListenerType(type: String): void
		{
			var _listener: Vector.<Function> = _eventListener[type] as Vector.<Function>;
			
			for(var i:uint = 0; i < _listener.length; i++)
			{
				removeEventListener(type, _listener[i]);
			}
		}

		public function get filterColor():Number
		{
			return _filterColor;
		}

		public function set filterColor(value:Number):void
		{
			_filterColor = value;
			setFilter();
		}

		public function get filterEnabled():Boolean
		{
			return _filterEnabled;
		}

		public function set filterEnabled(value:Boolean):void
		{
			_filterEnabled = value;
			setFilter();
		}


	}
}