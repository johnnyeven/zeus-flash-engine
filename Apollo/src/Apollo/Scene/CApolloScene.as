package Apollo.Scene 
{
	import Apollo.Controller.*;
	import Apollo.Network.Data.CBuildingParameter;
	import Apollo.Network.Data.CRoleParameter;
	import Apollo.Objects.*;
	import Apollo.Objects.Effects.*;
	import Apollo.Renders.*;
	import Apollo.Graphics.*;
	import Apollo.Maps.CWorldMap;
	import Apollo.utils.GUID;
	import Apollo.Configuration.*;
	import flash.errors.IllegalOperationError;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CApolloScene extends CBaseScene 
	{
		private static var instance: CApolloScene;
		private static var allowInstance: Boolean = false;
		
		public function CApolloScene() 
		{
			super(GlobalContextConfig.container, GlobalContextConfig.stage);
			if (!allowInstance)
			{
				throw new IllegalOperationError("CApolloScene类不允许实例化");
			}
		}
		
		public static function getInstance(): CApolloScene
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CApolloScene();
				allowInstance = false;
			}
			return instance;
		}
		
		public static function terminateInstance(): void
		{
			instance.clear();
			instance = null;
		}
		
		public function createBuilding(parameter: CBuildingParameter): CBuildingObject
		{
			//图形素材
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool(resourceId, 8, 4, 7);
			
			//感知器
			var perception: CPerception = new CPerception(this);
			//配置控制器
			var controller: CCharacterController = new CCharacterController(perception);
			//渲染器
			var render: CRenderCharacter = new CRenderCharacter();
			
			//初始化游戏对象
			var id: String;
			if (parameter != null)
			{
				if (parameter.objectId != null)
				{
					id = parameter.objectId;
				}
				else
				{
					id = GUID.create();
				}
			}
			var building: CBuildingObject = new CBuildingObject(controller, parameter.buildingId);
			building.objectId = id;
			building.graphic = rs;
			building.render = render;
			building.setPos(new Point(parameter.x, parameter.y));
			addObject(building);
			
			return building;
		}
		
		public function createRole(resourceId: String, startDirection: uint = CDirection.DOWN, parameter: CRoleParameter = null): CCharacterObject
		{
			var c: CCharacterController = _ctrlCenter.getRoleController(parameter.objectId);
			if (parameter != null && parameter.objectId != null && c != null)
			{
				return null;
			}
			//图形素材
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool(resourceId, 8, 4, 7);
			
			//感知器
			var perception: CPerception = new CPerception(this);
			//配置控制器
			var controller: CCharacterController = new CCharacterController(perception);
			//渲染器
			var render: CRenderCharacter = new CRenderCharacter();
			
			//初始化游戏对象
			var id: String;
			if (parameter != null)
			{
				if (parameter.objectId != null)
				{
					id = parameter.objectId;
				}
				else
				{
					id = GUID.create();
				}
			}
			var player: CCharacterObject = new CCharacterObject(controller, startDirection);
			
			player.objectId = id;
			player.graphic = rs;
			player.render = render;
			player.action = Action.STOP;
			player.speed = (parameter.speed == int.MIN_VALUE ? 0 : parameter.speed);
			
			if (parameter != null)
			{
				if (parameter.playerName != null)
				{
					player.setCharacterName(parameter.playerName, 0x00FFFF, 0x000000);
				}
				if (parameter.startX != int.MIN_VALUE && parameter.startY != int.MIN_VALUE)
				{
					player.setPos(new Point(parameter.startX, parameter.startY));
				}
			}
			setRoleController(controller, player.objectId);
			addObject(player);
			
			return player;
		}
	}

}