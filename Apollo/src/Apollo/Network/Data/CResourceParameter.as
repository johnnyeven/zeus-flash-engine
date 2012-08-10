package Apollo.Network.Data 
{
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CResourceParameter 
	{
		private var _resourceId: uint;
		private var _resourceName: String;
		/**
		 * 对于CResourceCenter类来说，_resourceAmount表示剩余资源数，对于consumeList,produceList来说，没有_resourceAmount这个值，只有_resourceModified
		 */
		private var _resourceAmount: Number;
		private var _resourceModified: uint;
		
		public function CResourceParameter(_resourceId: uint, _resourceName: String, _resourceAmount: uint, _resourceModified: uint) 
		{
			this._resourceId = _resourceId;
			this._resourceName = _resourceName;
			this._resourceAmount = _resourceAmount;
			this._resourceModified = _resourceModified;
		}
		
		public function get resourceId(): uint
		{
			return _resourceId;
		}
		
		public function set resourceId(value:uint): void 
		{
			_resourceId = value;
		}
		
		public function get resourceName(): String 
		{
			return _resourceName;
		}
		
		public function set resourceName(value: String): void 
		{
			_resourceName = value;
		}
		
		public function get resourceAmount(): Number 
		{
			return _resourceAmount;
		}
		
		public function set resourceAmount(value: Number): void 
		{
			_resourceAmount = value;
		}
		
		public function get resourceModified():uint 
		{
			return _resourceModified;
		}
		
		public function set resourceModified(value:uint):void 
		{
			_resourceModified = value;
		}
		
	}

}