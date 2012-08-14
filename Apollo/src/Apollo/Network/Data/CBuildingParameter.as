package Apollo.Network.Data 
{
	import Apollo.Network.Data.interfaces.IParameterFill;
	import Apollo.Objects.dependency.CDependency;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CBuildingParameter implements IParameterFill
	{
		private var _objectId: String;
		private var _resourceId: String;
		private var _buildingId: uint;
		private var _buildingName: String;
		private var _buildingLevel: uint;
		private var _x: int;
		private var _y: int;
		/**
		 * 消耗的资源
		 */
		private var _consumeList: Vector.<CResourceParameter>;
		/**
		 * 产出的资源
		 */
		private var _produceList: Vector.<CResourceParameter>;
		private var dependency: CDependency;
		
		public function CBuildingParameter() 
		{
			_consumeList = new Vector.<CResourceParameter>();
			_produceList = new Vector.<CResourceParameter>();
		}
		
		public function get consumeList():Vector.<CResourceParameter> 
		{
			return _consumeList;
		}
		
		public function get produceList():Vector.<CResourceParameter> 
		{
			return _produceList;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get buildingLevel():uint 
		{
			return _buildingLevel;
		}
		
		public function get buildingName():String 
		{
			return _buildingName;
		}
		
		public function get buildingId():uint 
		{
			return _buildingId;
		}
		
		public function get resourceId():String 
		{
			return _resourceId;
		}
		
		public function get objectId():String 
		{
			return _objectId;
		}
		
		public function fill(data: Object): void
		{
			_objectId = data.objectId;
			_resourceId = data.resourceId;
			_buildingId = data.buildingId;
			_buildingName = data.buildingName;
			_buildingLevel = data.buildingLevel;
			_x = data.buildingPosX;
			_y = data.buildingPosY;
			
			for (var i: String in data.buildingConsumeList as Array)
			{
				var consumeResource: CResourceParameter = new CResourceParameter(data.buildingConsumeList[i].resourceId, data.buildingConsumeList[i].resourceName, 0, parseInt(data.buildingConsumeList[i].resourceModified));
				trace("consume: " + consumeResource.resourceId + "|||" + consumeResource.resourceName + "|||" + consumeResource.resourceAmount + "|||" + consumeResource.resourceModified);
				_consumeList.push(consumeResource);
			}
			
			for (var j: String in data.buildingProduceList as Array)
			{
				var produceResource: CResourceParameter = new CResourceParameter(data.buildingProduceList[i].resourceId, data.buildingProduceList[i].resourceName, 0, parseInt(data.buildingProduceList[i].resourceModified));
				trace("produce: " + produceResource.resourceId + "|||" + produceResource.resourceName + "|||" + produceResource.resourceAmount + "|||" + produceResource.resourceModified);
				_produceList.push(produceResource);
			}
		}
		
	}

}