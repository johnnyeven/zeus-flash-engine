package apollo.network.data 
{
	import apollo.network.data.interfaces.IParameterFill;
	import apollo.objects.dependency.CDependency;
	
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
		private var _dependency: CDependency;
		
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
		
		public function get dependency():CDependency 
		{
			return _dependency;
		}
		
		public function set dependency(value:CDependency):void 
		{
			_dependency = value;
		}
		
		public function fill(data: Object): void
		{
			_objectId = data.object_id;
			_resourceId = data.resource_id;
			_buildingId = data.building_id;
			_buildingName = data.building_name;
			_buildingLevel = data.building_level;
			_x = data.building_pos_x;
			_y = data.building_pos_y;
			
			data.building_dependency = JSON.parse(data.building_dependency);
			
			data.building_consume = JSON.parse(data.building_consume);
			for (var i: String in data.building_consume)
			{
				var consumeResource: CResourceParameter = new CResourceParameter(parseInt(i), data.building_consume[i].resource_name, 0, parseInt(data.building_consume[i].resource_incremental));
				_consumeList.push(consumeResource);
			}
			
			data.building_produce = JSON.parse(data.building_produce);
			for (var j: String in data.building_produce)
			{
				var produceResource: CResourceParameter = new CResourceParameter(parseInt(i), data.building_produce[i].resource_name, 0, parseInt(data.building_consume[i].resource_incremental));
				_produceList.push(produceResource);
			}
		}
		
	}

}