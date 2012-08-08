package Apollo.Objects.Data 
{
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CResourceParameter 
	{
		private var _resourceId: uint;
		private var _resourceName: String;
		private var _resourceAmount: uint;
		private var _resourceDelay: uint;
		
		public function CResourceParameter(_resourceId: uint, _resourceName: String, _resourceAmount: uint, _resourceDelay: uint) 
		{
			this._resourceId = _resourceId;
			this._resourceName = _resourceName;
			this._resourceAmount = _resourceAmount;
			this._resourceDelay = _resourceDelay;
		}
		
		public function get resourceId():uint 
		{
			return _resourceId;
		}
		
		public function set resourceId(value:uint):void 
		{
			_resourceId = value;
		}
		
		public function get resourceName():String 
		{
			return _resourceName;
		}
		
		public function set resourceName(value:String):void 
		{
			_resourceName = value;
		}
		
		public function get resourceAmount():uint 
		{
			return _resourceAmount;
		}
		
		public function set resourceAmount(value:uint):void 
		{
			_resourceAmount = value;
		}
		
		public function get resourceDelay():uint 
		{
			return _resourceDelay;
		}
		
		public function set resourceDelay(value:uint):void 
		{
			_resourceDelay = value;
		}
		
	}

}