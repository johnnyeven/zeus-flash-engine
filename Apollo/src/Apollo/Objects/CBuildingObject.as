///////////////////////////////////////////////////////////
//  CBuildingObject.as
//  Macromedia ActionScript Implementation of the Class CBuildingObject
//  Generated by Enterprise Architect
//  Created on:      15-二月-2012 10:17:54
//  Original author: johnnyeven
///////////////////////////////////////////////////////////

package Apollo.Objects
{
	import Apollo.Objects.CMovieObject;
	import Apollo.Controller.CBaseController;
	import Apollo.Network.Data.CResourceParameter;
	import Apollo.Objects.dependency.CDependency;
	import Apollo.Center.CResourceCenter;
	
	import flash.events.Event;

	/**
	 * @author johnnyeven
	 * @version 1.0
	 * @created 15-二月-2012 10:17:54
	 */

	public class CBuildingObject extends CMovieObject
	{
		protected var _buildingId: uint;
		protected var _buildingName: String;
		protected var _level: uint;
		protected var _maxLevel: uint;
		/**
		 * 消耗的资源
		 */
		protected var _consumeList: Vector.<CResourceParameter>;
		/**
		 * 产出的资源
		 */
		protected var _produceList: Vector.<CResourceParameter>;
		protected var _dependency: CDependency;

		/**
		 * 
		 * @param _ctrl
		 */
		public function CBuildingObject(_ctrl:CBaseController, _buildingId: uint)
		{
			super(_ctrl);
			this._buildingId = _buildingId;
			_consumeList = new Vector.<CResourceParameter>();
			_produceList = new Vector.<CResourceParameter>();
		}
		
		public function get consumeList(): Vector.<CResourceParameter>
		{
			return _consumeList;
		}
		
		public function get produceList(): Vector.<CResourceParameter>
		{
			return _produceList;
		}
		
		public function addConsumeResource(resource: CResourceParameter): void
		{
			if (resource != null)
			{
				if (resource.resourceModified > 0)
				{
					resource.resourceModified *= -1;
					CONFIG::DebugMode
					{
						trace("Warning: ConsumeResource的resourceModified大于零，已自动更正");
					}
				}
				_consumeList.push(resource);
				CResourceCenter.getInstance().modifyResource(resource.resourceId, resource.resourceModified);
			}
		}
		
		public function addProduceResource(resource: CResourceParameter): void
		{
			if (resource != null)
			{
				if (resource.resourceModified < 0)
				{
					resource.resourceModified *= -1;
					CONFIG::DebugMode
					{
						trace("Warning: ProduceResource的resourceModified小于零，已自动更正");
					}
				}
				_produceList.push(resource);
				CResourceCenter.getInstance().modifyResource(resource.resourceId, resource.resourceModified);
			}
		}

		/**
		 * 
		 * @param level
		 */
		public function levelUp(value: uint = 1): Boolean
		{
			if (_level >= _maxLevel)
			{
				return false;
			}
			else
			{
				Upgrade();
				_level += value;
				return true;
			}
		}

		public function get level(): uint
		{
			return _level;
		}
		
		public function get buildingId(): uint
		{
			return _buildingId;
		}
		
		public function get buildingName(): String
		{
			return _buildingName;
		}

		public function get dependency(): CDependency
		{
			return _dependency;
		}

		public override function Upgrade(): void
		{
			super.Upgrade();
		}
	} //end CBuildingObject

}