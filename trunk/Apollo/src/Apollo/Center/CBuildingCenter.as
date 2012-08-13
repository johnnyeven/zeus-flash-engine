package Apollo.Center 
{
	import Apollo.Controller.CBuildingController;
	import Apollo.Controller.CPerception;
	import Apollo.Graphics.CGraphicCharacter;
	import Apollo.Network.Data.CBuildingParameter;
	import Apollo.Network.Data.CResourceParameter;
	import Apollo.Objects.CBuildingObject;
	import Apollo.Renders.CRenderBuilding;
	import Apollo.Scene.CApolloScene;
	import Apollo.utils.GUID;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CBuildingCenter
	{
		private var buildingList: Dictionary;
		private static var instance: CBuildingCenter;
		private static var allowInstance: Boolean = false;
		
		public function CBuildingCenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CBuildingCenter不允许实例化");
			}
			buildingList = new Dictionary();
		}
		
		public function createBuilding(buildingParameter: CBuildingParameter): CBuildingObject
		{
			//图形素材
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool(buildingParameter.resourceId, 8, 4, 7);
			
			//感知器
			var perception: CPerception = new CPerception(CApolloScene.getInstance());
			//配置控制器
			var controller: CBuildingController = new CBuildingController(perception);
			//渲染器
			var render: CRenderBuilding = new CRenderBuilding();
			
			//初始化游戏对象
			var id: String;
			if (buildingParameter != null)
			{
				if (buildingParameter.objectId != null)
				{
					id = buildingParameter.objectId;
				}
				else
				{
					id = GUID.create();
				}
			}
			var building: CBuildingObject = new CBuildingObject(controller, buildingParameter.buildingId);
			building.objectId = id;
			building.graphic = rs;
			building.render = render;
			building.setPos(new Point(buildingParameter.x, buildingParameter.y));
			building.setDisplayName(buildingParameter.buildingName, 0x00FFFF, 0x000000);
			for (var keyConsume: String in buildingParameter.consumeList)
			{
				building.addConsumeResource(buildingParameter.consumeList[keyConsume] as CResourceParameter);
			}
			for (var keyProduce: String in buildingParameter.produceList)
			{
				building.addProduceResource(buildingParameter.consumeList[keyProduce] as CResourceParameter);
			}
			
			registerBuilding(building);
			return building;
		}
		
		public function registerBuilding(building: CBuildingObject): void
		{
			buildingList[building.objectId] = building;
		}
		
		/**
		 * 
		 * @param	flag 建筑GUID
		 */
		public function getBuilding(flag: String): CBuildingObject
		{
			if (buildingList[flag] != null)
			{
				return buildingList[flag] as CBuildingObject;
			}
			return null;
		}
		
		public static function getInstance(): CBuildingCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CBuildingCenter();
				allowInstance = false;
			}
			return instance;
		}
	}

}