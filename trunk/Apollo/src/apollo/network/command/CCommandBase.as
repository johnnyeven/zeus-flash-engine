package apollo.network.command 
{
	import apollo.network.command.interfaces.INetPackageProtocol;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CCommandBase extends Object implements INetPackageProtocol
	{
		private var _controller: String;
		private var _action: String;
		
		public function CCommandBase(controller: String, action: String) 
		{
			super();
			_controller = controller;
			_action = action;
		}
		
		public function get controller(): String
		{
			return _controller;
		}
		
		public function get action(): String
		{
			return _action;
		}
		
		public function get urlPath(): String
		{
			return _controller + "/" + _action;
		}
	}

}