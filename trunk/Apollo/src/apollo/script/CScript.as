package apollo.script 
{
	import apollo.controller.*;
	import apollo.objects.*;
	import apollo.configuration.*;
	import apollo.scene.CBaseScene;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import mx.utils.StringUtil;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author john
	 */
	public class CScript 
	{
		protected var _scene: CBaseScene;
		protected var _currentObject: CActionObject;
		protected var _scriptId: String;
		protected var _currentStep: uint;
		protected var _currentBlock: String;
		/**
		 * UI管理器，现在暂时使用Dictionary代替
		 */
		protected var _ui: Dictionary = new Dictionary();
		/**
		 * 控制脚本运行的Timer
		 */
		protected var timer: Timer;
		/**
		 * 拆分后的脚本
		 */
		protected var scriptData: Dictionary;
		
		public static const EVENT_CLICK: String = 'CLICK';
		public static const EVENT_TOUCH: String = 'TOUCH';
		
		public function CScript(scriptId: String, current: CActionObject, scene: CBaseScene) 
		{
			_scriptId = scriptId;
			_scene = scene;
			_currentObject = current;
			_currentStep = 0;
			loadScript();
		}
		
		protected function loadScript(): void
		{
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onScriptLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onScriptIOError);
			loader.load(new URLRequest(SocketContextConfig.resource_server_ip + GlobalContextConfig.SCRIPT_PATH + _scriptId + '.txt'));
		}
		
		public function reloadScript(scriptId: String): void
		{
			_scriptId = scriptId;
			
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onScriptLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onScriptIOError);
			loader.load(new URLRequest(SocketContextConfig.resource_server_ip + GlobalContextConfig.SCRIPT_PATH + _scriptId + '.txt'));
		}
		
		protected function onScriptIOError(event: IOErrorEvent): void
		{
			trace(event.text);
		}
		
		protected function onScriptLoaded(event: Event): void
		{
			var loader: URLLoader = event.target as URLLoader;
			loader.removeEventListener(Event.COMPLETE, onScriptLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onScriptIOError);
			parseScriptBase(loader.data);
		}
		
		protected function parseScriptBase(data: String): void
		{
			if (data != '')
			{
				//通过回车符分割
				var temp: Array = data.split("\n");
				var restData: Array;
				var currentBlock: String;
				scriptData = new Dictionary();
				//剔除无效数据
				for (var i: uint = 0; i < temp.length; i++)
				{
					//剔除首位空格
					temp[i] = StringUtil.trim(temp[i]);
					//剔除多余空格
					temp[i] = temp[i].replace(/\s+/, ' ');
					if (temp[i] == '' || temp[i].substr(0, 2) == '//')
					{
						continue;
					}
					else
					{
						if (temp[i].substr(0, 1) == '[')
						{
							var index: int = temp[i].indexOf(']');
							if (index != -1)
							{
								if (restData != null)
								{
									scriptData[currentBlock] = restData;
								}
								restData = new Array();
								currentBlock = temp[i].substr(1, index - 1);
							}
						}
						else
						{
							restData.push(temp[i]);
						}
					}
				}
				if (restData != null)
				{
					scriptData[currentBlock] = restData;
				}
				restData = null;
				currentBlock = null;
			}
		}
		
		public function triggerEvent(eventType: *): void
		{
			if (eventType is String)
			{
				_currentBlock = eventType;
			}
			else if (eventType is TimerEvent)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, triggerEvent);
				timer = null;
			}
			else if (eventType is MouseEvent)
			{
				var text: TextField = eventType.target as TextField;
				text.removeEventListener(MouseEvent.CLICK, triggerEvent);
				_currentBlock = text.name;
				_currentStep = 0;
				eventType.stopImmediatePropagation();
			}
			if (scriptData[_currentBlock] != undefined)
			{
				var arr: Array = scriptData[_currentBlock][_currentStep].split(' ');
				var txt: TextField;
				try
				{
					switch(arr[0])
					{
						case 'showNPCDialog':
							var sprite: Sprite = new Sprite();
							sprite.graphics.beginFill(0xFFFFFF);
							sprite.graphics.drawRect(0, 0, 200, 300);
							sprite.graphics.endFill();
							
							//显示标题
							txt = new TextField();
							txt.text = arr[2];
							txt.textColor = 0x000000;
							txt.width = sprite.width;
							sprite.addChild(txt);
							
							sprite.x = parseInt(arr[3]);
							sprite.y = parseInt(arr[4]);
							_scene.stage.addChild(sprite);
							_ui[arr[1]] = sprite;
							break;
						case 'closeNPCDialog':
							sprite = _ui[arr[1]];
							_scene.stage.removeChild(sprite);
							_ui[arr[1]] = null;
							break;
						case 'says':
							sprite = _ui[arr[1]];
							txt = new TextField();
							txt.text = arr[2];
							txt.textColor = 0x000000;
							txt.width = sprite.width;
							txt.y = 20;
							sprite.addChild(txt);
							break;
						case 'pause':
							if (timer == null)
							{
								timer = new Timer(parseInt(arr[1]));
							}
							timer.addEventListener(TimerEvent.TIMER, triggerEvent);
							timer.start();
							break;
						case 'stop':
							return;
							break;
						case 'select':
							sprite = _ui[arr[1]];
							txt = new TextField();
							txt.text = arr[2];
							txt.name = arr[3];
							txt.textColor = 0x0000FF;
							txt.width = sprite.width;
							txt.y = 50;
							sprite.addChild(txt);
							txt.addEventListener(MouseEvent.CLICK, triggerEvent);
							break;
						case 'moveTo':
							if (arr[1] == 'this')
							{
								(_currentObject.controller as IControllerMovable).moveTo(parseInt(arr[2]), parseInt(arr[3]));
							}
							else if (arr[1] == 'player')
							{
								(_scene.player.controller as IControllerMovable).moveTo(parseInt(arr[2]), parseInt(arr[3]));
							}
							else
							{
								var target: CCharacterObject = _scene.getCharacterById(arr[1]);
								if (target != null)
								{
									(target.controller as IControllerMovable).moveTo(parseInt(arr[2]), parseInt(arr[3]));
								}
							}
							break;
					}
				}
				catch (err: Error)
				{
					trace('脚本语法错误: ' + err.message);
				}
				if (_currentStep >= scriptData[_currentBlock].length - 1)
				{
					_currentStep = 0;
					return;
				}
				else
				{
					_currentStep++;
					if (timer == null || !timer.running)
					{
						triggerEvent(_currentBlock);
					}
				}
			}
		}
	}

}