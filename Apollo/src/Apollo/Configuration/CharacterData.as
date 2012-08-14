///////////////////////////////////////////////////////////
//  CCharacterData.as
//  Macromedia ActionScript Implementation of the Class CCharacterData
//  Generated by Enterprise Architect
//  Created on:      15-二月-2012 10:17:54
//  Original author: Administrator
///////////////////////////////////////////////////////////

package Apollo.Configuration
{
	import Apollo.Controller.KeyCode;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;


	/**
	 * @author Administrator
	 * @version 1.0
	 * @created 15-二月-2012 10:17:54
	 */

	public class CharacterData extends Object
	{
		public static var Camp: uint = 0;
		public static var AccountId: int = 0;
		public static var Guid: String;
		public static var UserName: String;
		public static var Level: uint;
		public static var ResourceId: String;
		public static var Direction: int;
		public static var PosX: int;
		public static var PosY: int;
		public static var Speed: int;
		public static var HealthMax: int;
		public static var Health: int;
		public static var ManaMax: int;
		public static var Mana: int;
		public static var EnergyMax: int;
		public static var Energy: int;
		public static var AttackRange: int;
		public static var AttackSpeed: Number;
		
		private static var missionList: Array;
		private static var _skillList: Dictionary;
		private static var instance: CharacterData;
		private static var allowInstance: Boolean = false;

		public function CharacterData()
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CharacterData类不允许实例化");
				return;
			}
			_skillList = new Dictionary();
			_skillList[KeyCode.F1] = new Array("skill1", 0);
			_skillList[KeyCode.F2] = new Array("skill2", 0);
			_skillList[KeyCode.F3] = new Array("skill3", 1);	//2级
			_skillList[KeyCode.F4] = new Array("skill4", 0);
			_skillList[KeyCode.F5] = new Array("skill5", 0);
			_skillList[KeyCode.F6] = new Array("skill6", 0);
			_skillList[KeyCode.F7] = new Array("skill7", 0);
			_skillList[KeyCode.F8] = new Array("skill8", 0);
			_skillList[KeyCode.F9] = new Array("skill9", 0);
		}
		
		public static function isCharacterAvailable(): Boolean
		{
			if (Guid == null)
			{
				return false;
			}
			else if (UserName == null)
			{
				return false;
			}
			else if (Level == 0)
			{
				return false;
			}
			else if (ResourceId == null)
			{
				return false;
			}
			else if (Speed == 0)
			{
				return false;
			}
			else if (HealthMax == 0)
			{
				return false;
			}
			else if (ManaMax == 0)
			{
				return false;
			}
			else if (AttackRange == 0)
			{
				return false;
			}
			else if (AttackSpeed == 0)
			{
				return false;
			}
			return true;
		}
		
		public static function getInstance(): CharacterData
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CharacterData();
				allowInstance = false;
			}
			return instance;
		}
		
		public function get skillList(): Dictionary
		{
			return _skillList;
		}

		public function get AllMissionList(): Array
		{
			return missionList;
		}

		public function get CanSeeMissionList(): Array
		{
			return missionList;
		}

		public function initMissionList(): void
		{
		}

	} //end CCharacterData

}