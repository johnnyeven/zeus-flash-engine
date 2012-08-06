///////////////////////////////////////////////////////////
//  CWorldMap.as
//  Macromedia ActionScript Implementation of the Class CWorldMap
//  Generated by Enterprise Architect
//  Created on:      15-����-2012 10:17:55
//  Original author: Administrator
///////////////////////////////////////////////////////////

/**
 * ʹ������
 * 1. ʵ����CWorldMap
 * 2. ����һ��MapEvent.MAP_DATA_LOADED�¼�������
 * 3. ����loadMapData()
 * 4. ����MapEvent.MAP_DATA_LOADED�¼�
 * 4-1. ����initBuffer() ��ʼ��������
 * 4-2. ����һ��Shape����CWorldMap.displayBuffer
 * 4-3. �����Shape���ӽ���̨�����յ���ʾ
 * 4-4. ����init() ��ʾ��ͼ
 */

package Apollo.Maps
{
	import Apollo.Objects.CActionObject;
	import Apollo.utils.Loader.CLoaderEx;
	import Apollo.Algorithms.SilzAstar;
	import Apollo.Controller.Action;
	import Apollo.utils.CXYArray;
	import Apollo.Events.MapEvent;
	import Apollo.Configuration.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Administrator
	 * @version 1.0
	 * @created 15-����-2012 10:17:55
	 */

	public class CWorldMap implements IEventDispatcher
	{
		public var MapId: String = 'default';
		public static var RES_DIR: String = 'asset/';
		private var thumbnail: String;
		private static var _astar: SilzAstar;
		private var _urlLoader: URLLoader;
		/**
		 * ��ͼ��������Դ��ͼ��
		 */
		private var _buffer: BitmapData;
		/**
		 * ��ͼ��������������ʾ��
		 */
		private var _displayBuffer: Shape;
		/**
		 * �����жϵ�ͼ�Ƿ��ƶ��Ծ����Ƿ���Ҫ��Ⱦ
		 */
		private var _pre_center: CXYArray;
		/**
		 * �����ж��Ƿ���Ҫ�����µ�Tiles
		 */
		private var _pre_start: CXYArray;
		/**
		 * ������ʾ����
		 */
		private var _center: CXYArray;
		/**
		 * �ƶ����յ�Ŀ��
		 */
		private var _target: CXYArray;
		/**
		 * ��ͼ�����ٶȣ���λ�����أ�
		 */
		private var _speed: uint = 10;
		/**
		 * �����ߵ�����, trueΪ���ƶ�, falseΪ�����ƶ�
		 */
		private var _negativePath: Array;
		protected var _smallMap: BitmapData;
		protected var _smallMapCache: BitmapData;
		private var _loadList: Vector.<CLoaderEx>;
		/**
		 * ͸����ײ���λͼ
		 */
		private var _alphaMap: BitmapData;
		/**
		 * ��ͼ�ķֿ�ͼ������
		 */
		protected var _mapResource: Object = {tiles: new Object()};
		/**
		 * ��Ļ���ϽǶ�Ӧ�ĵ�ͼʵ������X
		 */
		private var _screenStartX: int;
		/**
		 * ��Ļ���ϽǶ�Ӧ�ĵ�ͼʵ������Y
		 */
		private var _screenStartY: int;
		/**
		 * ��ȡ��ͼ�زĹ����е�ƫ��ֵX
		 */
		private var _tileOffsetX: int = 0;
		/**
		 * ��ȡ��ͼ�زĹ����е�ƫ��ֵY
		 */
		private var _tileOffsetY: int = 0;
		/**
		 * ��Ⱦ��ͼ�����е�ƫ��ֵX
		 */
		private var _renderMapOffsetX: int = 0;
		/**
		 * ��Ⱦ��ͼ�����е�ƫ��ֵY
		 */
		private var _renderMapOffsetY: int = 0;
		protected var eventDispatcher: EventDispatcher;
		
		private var _cameraView: Rectangle = new Rectangle();
		private var _cameraCutView: Rectangle = new Rectangle();
		
		/**
		 * ����Ⱦ�ĵ�ͼ��Ƭ
		 */
		private var _prepareRenderPos: Array;
		
		/**
		 * ��ǰ��Ļ�����ɵ�����ͼ��Ƭ����
		 */
		private var _screenTileNum: CXYArray;
		
		/**
		 * ֻ����ͼƬ��Ƭ ����ʾ�Ŀ���
		 */
		private var _prepareLoadTile: Boolean;
		
		/**
		 *  ��ͷ�����Ŀ��
		 */
		private var focus:CActionObject;
		
		protected var _mapXMLData: XML;
		
		public function CWorldMap()
		{
			_pre_center = new CXYArray();
			_pre_start = new CXYArray(-1, -1);
			_center = new CXYArray();
			_target = new CXYArray();
			_screenTileNum = new CXYArray();
			eventDispatcher = new EventDispatcher(this);
			_loadList = new Vector.<CLoaderEx>();
			_prepareLoadTile = false;
		}
		
		public function get mapXMLData(): XML
		{
			return _mapXMLData;
		}
		
		public function get smallMap(): BitmapData
		{
			return _smallMap;
		}
		
		public function get center(): CXYArray
		{
			if (focus != null)
			{
				_center.x = focus.pos.x;
				_center.y = focus.pos.y;
			}
			return _center;
		}
		
		public function set center(_pos: CXYArray): void
		{
			_pos.x = Math.max(_pos.x, GlobalContextConfig.Width / 2);
			_pos.x = Math.min(_pos.x, MapContextConfig.MapSize.x - GlobalContextConfig.Width / 2);
			
			_pos.y = Math.max(_pos.y, GlobalContextConfig.Height / 2);
			_pos.y = Math.min(_pos.y, MapContextConfig.MapSize.y- GlobalContextConfig.Height / 2);
			
			this._center = _pos;
		}
		
		public function pointToCenter(_pos: CXYArray): CXYArray
		{
			_pos.x = Math.max(_pos.x, GlobalContextConfig.Width / 2);
			_pos.x = Math.min(_pos.x, MapContextConfig.MapSize.x - GlobalContextConfig.Width / 2);
			
			_pos.y = Math.max(_pos.y, GlobalContextConfig.Height / 2);
			_pos.y = Math.min(_pos.y, MapContextConfig.MapSize.y- GlobalContextConfig.Height / 2);
			
			return _pos;
		}
		
		/**
		 * ������Ļ���ϽǶ�Ӧ��ʵ�ʵ�ͼ����X
		 */
		protected function get screenStartX(): int
		{
			var _screenStartX: int = center.x - int(GlobalContextConfig.Width / 2);
			_screenStartX = Math.max(0, _screenStartX);
			_screenStartX = Math.min(MapContextConfig.MapSize.x - GlobalContextConfig.Width, _screenStartX);
			return _screenStartX;
		}
		
		/**
		 * ������Ļ���ϽǶ�Ӧ��ʵ�ʵ�ͼ����Y
		 */
		protected function get screenStartY(): int
		{
			var _screenStartY: int = center.y - int(GlobalContextConfig.Height / 2);
			_screenStartY = Math.max(0, _screenStartY);
			_screenStartY = Math.min(MapContextConfig.MapSize.y - GlobalContextConfig.Height, _screenStartY);
			return _screenStartY;
		}
		
		/**
		 * ���㾵ͷ�����������ϽǶ�Ӧʵ�ʵ�ͼ����X
		 */
		protected function get cutviewStartX(): int
		{
			var _cutviewStartX: int = screenStartX - MapContextConfig.TileSize.x;
			_cutviewStartX = Math.max(0, _cutviewStartX);
			return _cutviewStartX;
		}
		
		/**
		 * ���㾵ͷ�����������ϽǶ�Ӧʵ�ʵ�ͼ����Y
		 */
		protected function get cutviewStartY(): int
		{
			var _cutviewStartY: int = screenStartY - MapContextConfig.TileSize.y;
			_cutviewStartY = Math.max(0, _cutviewStartY);
			return _cutviewStartY;
		}

		/**
		 * ��ͷ��ʾ������
		 */
		public function get cameraView(): Rectangle
		{
			_cameraView.x = screenStartX > MapContextConfig.MapSize.x - GlobalContextConfig.Width ? MapContextConfig.MapSize.x - GlobalContextConfig.Width : screenStartX;
			_cameraView.y = screenStartY > MapContextConfig.MapSize.y - GlobalContextConfig.Height ? MapContextConfig.MapSize.y - GlobalContextConfig.Height : screenStartY;
			
			_cameraView.width = GlobalContextConfig.Width;
			_cameraView.height = GlobalContextConfig.Height;
			
			return _cameraView;
		}

		/**
		 * ��ͷ����������Ұ
		 */
		public function get cameraCutView(): Rectangle
		{
			_cameraCutView.x = cutviewStartX;
			_cameraCutView.y = cutviewStartY;
			_cameraCutView.width = center.x < MapContextConfig.TileSize.x + GlobalContextConfig.Width / 2 ? center.x + GlobalContextConfig.Width / 2 + MapContextConfig.TileSize.x : GlobalContextConfig.Width + MapContextConfig.TileSize.x * 2;
			_cameraCutView.height = center.y < MapContextConfig.TileSize.y + GlobalContextConfig.Height / 2 ? center.y + GlobalContextConfig.Height / 2 + MapContextConfig.TileSize.y : GlobalContextConfig.Height + MapContextConfig.TileSize.y * 2;
			_cameraCutView.width = cutviewStartX > MapContextConfig.MapSize.x - (GlobalContextConfig.Width + MapContextConfig.TileSize.x * 2) ? MapContextConfig.MapSize.x - cutviewStartX : _cameraCutView.width;
			_cameraCutView.height = cutviewStartY > MapContextConfig.MapSize.y - (GlobalContextConfig.Width + MapContextConfig.TileSize.y * 2) ? MapContextConfig.MapSize.y - cutviewStartY : _cameraCutView.height;
			
			return _cameraCutView;
		}

		public function get nagetivePath(): Array
		{
			return _negativePath;
		}

		public static function get AStar(): SilzAstar
		{
			return _astar;
		}
		
		/**
		 * ���þ�ͷ����ĳĿ��
		 */
		public function follow(o: CActionObject, cancel: Boolean = false): void
		{
			if (cancel)
			{
				if (focus != null)
				{
					focus.beFocus = false;
				}
				focus = null;
				return;
			}
			if (focus != null)
			{
				focus.beFocus = false;
				
				if (o == null)
				{
					_center.x = center.x;
					_center.y = center.y;
				}
			}
			
			focus = o;
			if (o != null)
			{
				o.beFocus = true;
			}
			
			render(true);
		}
		
		public function get follower(): CActionObject
		{
			return focus;
		}
		 
		/**
		 * ��ȡ��ͼ����
		 */
		public function loadMapData(): void
		{
			var mapConfig: String = SocketContextConfig.resource_server_ip + GlobalContextConfig.MAP_RES_PATH + MapId + '/map.xml';
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(Event.COMPLETE, configMapData);
			loader.load(new URLRequest(mapConfig));
		}

		/**
		 * 
		 * @param _pos
		 */
		public function isPathAvailable(_pos:Point): Boolean
		{
			if (_pos.x >= MapContextConfig.BlockNum.x || _pos.y >= MapContextConfig.BlockNum.y)
			{
				return false;
			}
			else
			{
				return _negativePath[_pos.x][_pos.y];
			}
		}
		
		public function loadAlphaMap(): void
		{
			if (_alphaMap != null)
			{
				_alphaMap.dispose();
				_alphaMap = null;
			}
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, configAlphaMap);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(new URLRequest(SocketContextConfig.resource_server_ip + GlobalContextConfig.MAP_RES_PATH + MapId + '/alpha.png'));
		}
		
		private function configAlphaMap(event: Event): void
		{
			var loader: Loader = (event.target as LoaderInfo).loader;
			_alphaMap = (loader.content as Bitmap).bitmapData;
			
			loader.unload();
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, configAlphaMap);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader = null;
		}
		
		public function loadRoadMap(): void
		{
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, configRoadMap);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(new URLRequest(SocketContextConfig.resource_server_ip + GlobalContextConfig.MAP_RES_PATH + MapId + '/road.png'));
		}
		
		private function configRoadMap(event: Event): void
		{
			var loader: LoaderInfo = event.target as LoaderInfo;
			
			loader.removeEventListener(Event.COMPLETE, configRoadMap);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			resetRoadPath();
			var roadMap: BitmapData = (loader.content as Bitmap).bitmapData;
			
			var percentage: Number = roadMap.width / MapContextConfig.MapSize.x;
			var width: uint = int(MapContextConfig.MapSize.x / MapContextConfig.BlockSize.x);
			var height: uint = int(MapContextConfig.MapSize.y / MapContextConfig.BlockSize.y);
			
			for (var y: uint = 0; y < height; y++)
			{
				for (var x: uint = 0; x < width; x++)
				{
					_negativePath[y][x] = roadMap.getPixel32(int(MapContextConfig.BlockSize.x * x * percentage), int(MapContextConfig.BlockSize.y * y * percentage)) == 0x00000000 ? true : false;
				}
			}
			roadMap.dispose();
			setupAstar();
		}
		
		private function setupAstar(): void
		{
			_astar = new SilzAstar(_negativePath);
		}
		
		protected function resetRoadPath(): void
		{
			if (_negativePath != null)
			{
				_negativePath.splice(0, _negativePath.length);
				_negativePath = null;
			}
			_negativePath = new Array();
			
			var width: uint = int(MapContextConfig.MapSize.x / MapContextConfig.BlockSize.x) + 1;
			var height: uint = int(MapContextConfig.MapSize.y / MapContextConfig.BlockSize.y) + 1;
			
			for (var y: uint = 0; y < height; y++)
			{
				var temp: Array = new Array();
				for (var x: uint = 0; x < width; x++)
				{
					temp.push(true);
				}
				_negativePath.push(temp);
			}
		}
		
		public function isInAlphaArea(x: uint, y: uint): Boolean
		{
			if (_alphaMap == null)
			{
				return false;
			}
			return _alphaMap.getPixel32(int(_alphaMap.width / MapContextConfig.MapSize.x * x), int(_alphaMap.height / MapContextConfig.MapSize.y * y)) != 0x00000000;
		}

		/**
		 * ������Ļ�����ȡ�ڵ�ͼ�ϵ�����
		 * 
		 * @param _pos
		 */
		public function getMapPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = screenStartX + _pos.x;
			result.y = screenStartY + _pos.y;
			return result;
		}

		/**
		 * ���ݵ�ͼ�����ȡ��Ļ�ϵ�����
		 * 
		 * @param _pos
		 */
		public function getScreenPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = _pos.x - screenStartX;
			result.y = _pos.y - screenStartY;
			return result;
		}

		/**
		 * ���������ͼ�ϵ�����ת��ΪѰ·���ӵ�����
		 * 
		 * @param _pos
		 */
		public static function mapToBlockPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = int(_pos.x / MapContextConfig.BlockSize.x);
			result.y = int(_pos.y / MapContextConfig.BlockSize.y);
			return result;
		}

		/**
		 * ����Ѱ·���ӵ������ȡ�����ͼ�ϵ�����
		 * 
		 * @param _pos
		 */
		public static function blockToMapPosition(_pos:Point): Point
		{
			var result: Point = new Point();
			result.x = _pos.x * MapContextConfig.BlockSize.x + MapContextConfig.BlockSize.x * .5;
			result.y = _pos.y * MapContextConfig.BlockSize.y + MapContextConfig.BlockSize.y * .5;
			return result;
		}

		/**
		 * 
		 * @param _data
		 */
		public function set displayBuffer(_data:Shape): void
		{
			_displayBuffer = _data;
			_displayBuffer.graphics.beginBitmapFill(_buffer);
			_displayBuffer.graphics.drawRect(0, 0, _buffer.width, _buffer.height);
		}

		public function render(enforceRender: Boolean = false): void
		{
			if (!enforceRender && focus != null && focus.action == Action.STOP)
			{
				return;
			}
			else
			{
				prepareRenderData();
				//��ʼ��Ⱦ
				if (!enforceRender && _center.x == _pre_center.x && _center.y == _pre_center.y)
				{
					return;
				}
				_displayBuffer.x = -(screenStartX % MapContextConfig.TileSize.x);
				_displayBuffer.y = -(screenStartY % MapContextConfig.TileSize.y);
				//��Ⱦ����
				_pre_center.x = _center.x;
				_pre_center.y = _center.y;
			}
		}
		
		/**
		 * ��̬������Ҫ��ȡ�ĵ�ͼ��Ƭ
		 */
		private function prepareRenderData(): void
		{
			var startX: int = int(screenStartX / MapContextConfig.TileSize.x);
			var startY: int = int(screenStartY / MapContextConfig.TileSize.y);
			
			if (startX == _pre_start.x && startY == _pre_start.y)
			//if (_center.x == _pre_center.x && _center.y == _pre_center.y)
			{
				return;
			}
			else
			{
				//��������֮ǰ��������ͼ������ʾ
				drawThumbnail(startX, startY);
				
				if (_prepareRenderPos != null)
				{
					_prepareRenderPos.splice(0, _prepareRenderPos.length);
				}
				_prepareRenderPos = new Array();
				var maxX: int = Math.min(startX + _screenTileNum.x, MapContextConfig.TileNum.x);
				var maxY: int = Math.min(startY + _screenTileNum.y, MapContextConfig.TileNum.y);
				
				for (var i:int = startX; i < maxX; i++)
				{
					var tempPos: Array = new Array();
					for (var j:int = startY; j < maxY; j++)
					{
						tempPos.push(j + "_" + i);
					}
					_prepareRenderPos.push(tempPos);
				}
				if (!_prepareLoadTile)
				{
					_pre_start.x = startX;
					_pre_start.y = startY;
				}
			}
			loadTiles();
		}
		
		/**
		 * ������ͼ��ʱ���
		 */
		protected function drawThumbnail(startX: int, startY: int): void
		{
			if (_smallMap == null || _smallMapCache == null)
			{
				return;
			}
			var per: Number = _smallMap.width / MapContextConfig.MapSize.x;
			_smallMapCache.fillRect(_smallMapCache.rect, 0);
			var rect: Rectangle = new Rectangle(startX * MapContextConfig.TileSize.x * per, startY * MapContextConfig.TileSize.y * per, _smallMapCache.width, _smallMapCache.height);
			_smallMapCache.copyPixels(_smallMap, rect, new Point());
			
			per = MapContextConfig.MapSize.x / _smallMap.width;
			_buffer.draw(_smallMapCache, new Matrix(per, 0, 0, per), null, null, null, true);
		}

		/**
		 * ���õ�ͼ������Clear
		 */
		public function reset(): void
		{
			clear();
			_buffer.fillRect(_buffer.rect, 0);
		}

		/**
		 * ��յ�ͼ����
		 */
		private function clear(): void
		{
			_mapXMLData = null;
			_negativePath.splice(0, _negativePath.length);
		}
		
		/**
		 * ��ʼ��������
		 */
		public function initBuffer(): void
		{
			//��ʼ��������
			_buffer = new BitmapData(GlobalContextConfig.Width + 2 * MapContextConfig.TileSize.x, GlobalContextConfig.Height + 2 * MapContextConfig.TileSize.y, false);
		}

		/**
		 * ��ʼ����ͼ
		 */
		public function init(): void
		{
			//��ȡ����ͼ
			var mapThumbnail: String = SocketContextConfig.resource_server_ip + GlobalContextConfig.MAP_RES_PATH + MapId + '/' + thumbnail;
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSmallMapLoaded);
			loader.load(new URLRequest(mapThumbnail));
		}
		
		/**
		 * IO����������
		 * 
		 * @param	e
		 */
		private function onIOError(e:IOErrorEvent): void
		{
			trace(e.text);
		}

		/**
		 * ��ͼ���ݼ�����ɣ���������
		 * 
		 * @param e
		 */
		private function configMapData(e:Event): void
		{
			_mapXMLData = new XML();
			_mapXMLData.ignoreComments = true;
			_mapXMLData = XML(e.target.data);
			
			if (_mapXMLData.id != MapId)
			{
				dispatchEvent(new IOErrorEvent(IOErrorEvent.VERIFY_ERROR));
			}
			else
			{
				//��ͼ��Ƭ����
				MapContextConfig.TileNum.x = parseInt(_mapXMLData.tileNumWidth);
				MapContextConfig.TileNum.y = parseInt(_mapXMLData.tileNumHeight);
				//��ͼ��Ƭ��С
				MapContextConfig.TileSize.x = parseInt(_mapXMLData.tileWidth);
				MapContextConfig.TileSize.y = parseInt(_mapXMLData.tileHeight);
				//��ͼ��С
				MapContextConfig.MapSize.x = MapContextConfig.TileNum.x * MapContextConfig.TileSize.x;
				MapContextConfig.MapSize.y = MapContextConfig.TileNum.y * MapContextConfig.TileSize.y;
				//Ѱ·���Ӵ�С
				MapContextConfig.BlockSize.x = parseInt(_mapXMLData.blockWidth);
				MapContextConfig.BlockSize.y = parseInt(_mapXMLData.blockHeight);
				//Ѱ·��������
				MapContextConfig.BlockNum.x = int(MapContextConfig.MapSize.x / MapContextConfig.BlockSize.x);
				MapContextConfig.BlockNum.y = int(MapContextConfig.MapSize.y / MapContextConfig.BlockSize.y);
				//��Ļ�����ɵ������Ƭ����
				_screenTileNum.x = Math.ceil(GlobalContextConfig.Width / MapContextConfig.TileSize.x) + 2;
				_screenTileNum.y = Math.ceil(GlobalContextConfig.Height / MapContextConfig.TileSize.y) + 2;
				//����X��Y���ϵ��ٶ�������
				MapContextConfig.xFixNum = Math.cos(Math.atan2(parseInt(_mapXMLData.radiansOffsetY) , parseInt(_mapXMLData.radiansOffsetX)));
				MapContextConfig.yFixNum = Math.cos(Math.atan2(parseInt(_mapXMLData.radiansOffsetX) , parseInt(_mapXMLData.radiansOffsetY)));
				
				//���ó�ʼ��
				//var centerPos: CXYArray = new CXYArray(CharacterData.PosX, CharacterData.PosY);
				var centerPos: CXYArray = new CXYArray(parseInt(_mapXMLData.startPointX), parseInt(_mapXMLData.startPointY));
				center = centerPos;
				//����ͼ��ַ
				thumbnail = _mapXMLData.thumbnail;
				
				resetRoadPath();
				loadAlphaMap();
				loadRoadMap();
				
				dispatchEvent(new MapEvent(MapEvent.MAP_DATA_LOADED));
			}
		}

		/**
		 * ����ͼ������ɣ���������ͼ
		 * 
		 * @param e
		 */
		public function onSmallMapLoaded(e:Event): void
		{
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loaderInfo.removeEventListener(Event.COMPLETE, onSmallMapLoaded);
			
			_smallMap = (loaderInfo.content as Bitmap).bitmapData;
			
			loaderInfo.loader.unload();
			loaderInfo = null;
			
			var per: Number = _smallMap.width / MapContextConfig.MapSize.x;
			_smallMapCache = new BitmapData(_buffer.width * per, _buffer.height * per, false, 0);
			
			//Ԥ����ͼ��Ƭ
			_prepareLoadTile = true;
			prepareRenderData();
		}

		/**
		 * ���ص�ͼ�ز�
		 */
		public function loadTiles(): void
		{
			var x: int = 0;
			var y: int = 0;
			var _dataName: Array = new Array();
			
			if (_prepareRenderPos == null) 
			{
				return;
			}
			else
			{
				_displayBuffer.cacheAsBitmap = false;
				for (var i:int = 0; i < _prepareRenderPos.length; i++)
				{
					for (var j:int = 0; j < _prepareRenderPos[i].length; j++)
					{
						if (_mapResource.tiles[_prepareRenderPos[i][j]] != null)
						{
							if (!_prepareLoadTile)
							{
								var _bufferPoint: Point = new Point();
								_bufferPoint.x = i * MapContextConfig.TileSize.x;
								_bufferPoint.y = j * MapContextConfig.TileSize.y;
								_buffer.copyPixels(_mapResource.tiles[_prepareRenderPos[i][j]], _mapResource.tiles[_prepareRenderPos[i][j]].rect, _bufferPoint);
								//trace('tile loaded:' + _bufferPoint.toString());
							}
						}
						else
						{
							_dataName = _prepareRenderPos[i][j].split("_");
							var loader:CLoaderEx = new CLoaderEx();
							loader.name = SocketContextConfig.resource_server_ip + GlobalContextConfig.MAP_RES_PATH + MapId + '/' + CWorldMap.RES_DIR + _prepareRenderPos[i][j] + '.jpg';
							loader.data = _prepareRenderPos[i][j];
							_loadList.push(loader);
						}
					}
				}
				startLoad();
			}
		}

		public function startLoad(): void
		{
			if (_loadList.length == 0)
			{
				return;
			}
			else
			{
				var loader:CLoaderEx = _loadList[0];
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onTileLoadComplete);
				loader.load(new URLRequest(loader.name));
				_loadList.splice(0, 1);
			}
		}

		/**
		 * 
		 * @param e
		 */
		public function onTileLoadComplete(e:Event): void
		{
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			var loader:CLoaderEx = loaderInfo.loader as CLoaderEx;
			
			_mapResource.tiles[loader.data] = (loaderInfo.content as Bitmap).bitmapData;
			/*
			if (!_prepareLoadTile)
			{
				var _pos: Array = loader.data.split("_");
				var _bufferPoint: Point = new Point();
				_bufferPoint.x = parseInt(_pos[1]) * Config.TileSize.x;
				_bufferPoint.y = parseInt(_pos[0]) * Config.TileSize.y;
				_buffer.copyPixels(_mapResource.tiles[loader.data], _mapResource.tiles[loader.data].rect, _bufferPoint);
			}
			*/
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loaderInfo.removeEventListener(Event.COMPLETE, onTileLoadComplete);
			loader.unload();
			
			if (_loadList.length > 0)
			{
				startLoad();
			}
			else
			{
				_displayBuffer.cacheAsBitmap = true;
				if (_prepareLoadTile)
				{
					_prepareLoadTile = false;
				}
				dispatchEvent(new MapEvent(MapEvent.MAP_LOADED));
			}
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

	} //end CWorldMap

}