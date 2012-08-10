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
			
			for (var i: int in data.buildingConsumeList as Array)
			{
				var resource: CResourceParameter = new CResourceParameter();
				resource.resourceId = data.buildingConsumeList[i].resourceId;
				resource.resourceName = data.buildingConsumeList[i].resourceName;
				resource.resourceModified = data.buildingConsumeList[i].resourceModified;
				_consumeList.push(resource);
			}
			
			for (var i: int in data.buildingProduceList as Array)
			{
				var resource: CResourceParameter = new CResourceParameter();
				resource.resourceId = data.buildingProduceList[i].resourceId;
				resource.resourceName = data.buildingProduceList[i].resourceName;
				resource.resourceModified = data.buildingProduceList[i].resourceModified;
				_produceList.push(resource);
			}
		}
		
	}

}