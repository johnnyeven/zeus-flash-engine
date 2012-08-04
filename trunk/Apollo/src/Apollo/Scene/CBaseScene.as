///////////////////////////////////////////////////////////
//  CBaseScene.as
//  Macromedia ActionScript Implementation of the Class CBaseScene
//  Generated by Enterprise Architect
//  Created on:      15-二月-2012 10:17:53
//  Original author: Administrator
///////////////////////////////////////////////////////////

package Apollo.Scene
{
	import Apollo.Controller.*;
	import Apollo.Events.*;
	import Apollo.Objects.*;
	import Apollo.Objects.Effects.*;
	import Apollo.Maps.CWorldMap;
	import Apollo.Algorithms.data.CQtree;
	import Apollo.Display.CCamera;
	import Apollo.utils.CCharacterData;
	import Apollo.Configuration.*;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.events.Event;
	
	/**
	 * @author Administrator
	 * @version 1.0
	 * @created 15-二月-2012 10:17:53
	 */

	public class CBaseScene implements IEventDispatcher
	{
		protected var _container: DisplayObjectContainer;
		protected var _ctrlCenter: CControllerCenter;
		protected var _isReady: Boolean = false;
		protected var _map: CWorldMap;
		protected var _objectList: Array;
		protected var _renderList: Array;
		protected var _stage: Stage;
		protected var _mapGround: Shape;
		protected var _player: CCharacterObject;
		protected var _layer_background: Sprite;
		protected var _layer_sing: Sprite;
		protected var _layer_object: Sprite;
		protected var _layer_effect: Sprite;
		protected var eventDispatcher: EventDispatcher;
		/**
		 * 游戏显示四叉树优化
		 */
		protected var qtree: CQtree;
		protected static var _allowInstance: Boolean = false;
		
		/**
		 * 
		 * @param _target
		 * @param _stage
		 */
		public function CBaseScene(_target:DisplayObjectContainer, _stage:Stage)
		{
			if (_target == null || _stage == null)
			{
				throw new IllegalOperationError("_target and _stage must be initialized!");
			}
			this._stage = _stage;
			this._container = _target;
			
			eventDispatcher = new EventDispatcher(this);
			_objectList = new Array();
			
			_layer_background = new Sprite();
			_layer_sing = new Sprite();
			_layer_object = new Sprite();
			_layer_effect = new Sprite();
			
			_container.addChild(_layer_background);
			_container.addChild(_layer_sing);
			_container.addChild(_layer_object);
			_container.addChild(_layer_effect);
			
			_mapGround = new Shape();
			_mapGround.visible = false;
			_ctrlCenter = CControllerCenter.getInstance();
			
			buildQtree();
		}
		
		public function buildQtree(): void
		{
			qtree = new CQtree(new Rectangle(0, 0, MapContextConfig.MapSize.x, MapContextConfig.MapSize.y), 4);
			_renderList = new Array();
		}
		
		public function refresh(updateView: Boolean = true): void
		{
			if (updateView)
			{
				CCamera.cameraView = _map.cameraView;
			}
			for each(var o: CGameObject in _objectList)
			{
				if (o == _player)
				{
					continue;
				}
				if (CCamera.cameraView.containsPoint(o.pos))
				{
					pushRenderList(o);
				}
				else
				{
					(o.controller == null || o is CCharacterObject) ? pullRenderList(o) : o.isMovingOut(); 
				}
				if (!_map.cameraCutView.containsPoint(o.pos))
				{
					pullRenderList(o);
					o.destroy();
				}
			}
		}

		/**
		 * 
		 * @param o
		 */
		public function addObject(o:CGameObject): void
		{
			if (_objectList.indexOf(o) != -1)
			{
				return;
			}
			else
			{
				_objectList.push(o);
				if (map.cameraCutView.containsPoint(o.pos))
				{
					pushRenderList(o);
				}
			}
		}

		/**
		 * 
		 * @param o
		 */
		public function pushRenderList(o:CGameObject): void
		{
			var i: int = _renderList.indexOf(o);
			if (i != -1)
			{
				return;
			}
			else
			{
				_renderList.push(o);
				if (o is CSingEffect)
				{
					_layer_sing.addChild(o);
				}
				else if (o is CEffectObject)
				{
					_layer_effect.addChild(o);
				}
				else
				{
					_layer_object.addChild(o);
				}
				o.inUse = true;
				o.isMovingIn();
			}
		}

		/**
		 * 
		 * @param o
		 */
		public function removeObject(o:CGameObject): void
		{
			var i: int = _objectList.indexOf(o);
			if (i != -1)
			{
				_objectList.splice(i, 1);
			}
			pullRenderList(o);
		}

		/**
		 * 
		 * @param o
		 */
		public function pullRenderList(o:CGameObject): void
		{
			var i: int = _renderList.indexOf(o);
			if (i != -1)
			{
				_renderList.splice(i, 1);
				if (o is CSingEffect)
				{
					_layer_sing.removeChild(o);
				}
				else if (o is CEffectObject)
				{
					_layer_effect.removeChild(o);
				}
				else
				{
					_layer_object.removeChild(o);
				}
				o.inUse = false;
				//o.alpha = 0;
				o.isMovingOut();
			}
		}

		public function getAllObjects(): Array
		{
			return _objectList;
		}

		/**
		 * 
		 * @param index
		 */
		public function getCharacter(index:uint): CCharacterObject
		{
			if (index > ObjectsNumber)
			{
				return null;
			}
			else
			{
				return _objectList[index] as CCharacterObject;
			}
		}
		
		public function getCharacterById(objectId: String): CCharacterObject
		{
			for (var i: uint = 0; i < _objectList.length; i++)
			{
				if (_objectList[i].objectId == objectId)
				{
					return _objectList[i] as CCharacterObject;
				}
			}
			return null;
		}

		/**
		 * 
		 * @param index
		 */
		public function getObject(index:uint): CGameObject
		{
			if (index > ObjectsNumber)
			{
				return null;
			}
			else
			{
				return _objectList[index] as CGameObject;
			}
		}
		
		public function getObjectById(objectId: String): CGameObject
		{
			for (var i: uint = 0; i < _objectList.length; i++)
			{
				if (_objectList[i].objectId == objectId)
				{
					return _objectList[i] as CGameObject;
				}
			}
			return null;
		}

		public function render(): void
		{
			updateTimer();
			map.render();
			if (_renderList.length == 0)
			{
				return;
			}
			else
			{
				var listLength: uint = _renderList.length;
				_renderList.sortOn('zIndex', Array.NUMERIC);
				CCamera.needRefresh = false;
				
				var _renderItem:CGameObject = new CGameObject();
				var _children:CGameObject = new CGameObject();
				while (listLength--)
				{
					_renderItem = _renderList[listLength];
					try
					{
						_children = _layer_object.getChildAt(listLength) as CGameObject;
						if (_children != _renderItem)
						{
							_layer_object.setChildIndex(_renderItem, listLength);
						}
					}
					catch (err: Error)
					{
						
					}
					_renderItem.RenderObject();
				}
				//if (CCamera.needRefresh)
				//{
					refresh();
				//}
			}
		}

		public function get ctrlCenter(): CControllerCenter
		{
			return _ctrlCenter;
		}

		public function get isReady(): Boolean
		{
			return _isReady;
		}

		public function get map(): CWorldMap
		{
			return _map;
		}

		public function get ObjectsNumber(): uint
		{
			return _objectList.length;
		}

		public function get renderList(): Array
		{
			return _renderList;
		}
		
		public function get player(): CCharacterObject
		{
			return _player;
		}

		public function get stage(): Stage
		{
			return _stage;
		}

		/**
		 * 
		 * @param _stage
		 */
		public function set stage(_stage:Stage): void
		{
			this._stage = _stage;
		}

		public function initMap(mapId: String): void
		{
			_map = new CWorldMap();
			_map.MapId = mapId;
			_map.addEventListener(MapEvent.MAP_DATA_LOADED, onMapDataLoaded);
			_map.loadMapData();
		}
		
		private function onMapDataLoaded(e:MapEvent): void
		{
			_map.initBuffer();
			_map.displayBuffer = _mapGround;
			CCamera.needRefresh = true;
			_map.addEventListener(MapEvent.MAP_LOADED, onMapLoaded);
			_map.init();
		}
		
		public function showMap(): void
		{
			_ctrlCenter.requestRefreshCamaraView();
			if (_layer_background.numChildren == 0)
			{
				_layer_background.addChild(_mapGround);
				_mapGround.visible = true;
			}
		}
		
		private function onMapLoaded(e: MapEvent): void
		{
			_map.removeEventListener(MapEvent.MAP_LOADED, onMapLoaded);
			_isReady = true;
			dispatchEvent(new SceneEvent(SceneEvent.SCENE_READY));
		}
		
		public function clear(): void
		{
			_objectList.splice(0, _objectList.length);
			_renderList.splice(0, _renderList.length);
			
			while (_layer_object.numChildren)
			{
				_layer_object.removeChildAt(0);
			}
			while (_layer_background.numChildren)
			{
				_layer_background.removeChildAt(0);
			}
			while (_layer_effect.numChildren)
			{
				_layer_effect.removeChildAt(0);
			}
			
			_mapGround.graphics.clear();
			_mapGround = null;
		}
		
		public function inScene(o: CGameObject): Boolean
		{
			if (qtree == null)
			{
				return true;
			}
			return qtree.isIn(o.pos.x, o.pos.y);
		}
		
		protected function updateTimer(): void
		{
			GlobalContextConfig.Timer = getTimer();
		}

		protected function setRoleController(ctrl: CCharacterController, key: Object ): void
		{
			_ctrlCenter.addRoleController(ctrl, key);
		}
		
		public function changeScene(mapId: String, startX: uint = 0, startY:uint = 0): void
		{
			_stage.dispatchEvent(new MapEvent(MapEvent.MAP_CHANGE, mapId, startX, startY));
		}
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false): void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 
		 * @param e
		 */
		public function dispatchEvent(e:Event): Boolean
		{
			return eventDispatcher.dispatchEvent(e);
		}

		/**
		 * 
		 * @param type
		 */
		public function hasEventListener(type:String): Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}

		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false): void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * 
		 * @param type
		 */
		public function willTrigger(type:String): Boolean
		{
			return eventDispatcher.willTrigger(type);
		}

	} //end CBaseScene

}