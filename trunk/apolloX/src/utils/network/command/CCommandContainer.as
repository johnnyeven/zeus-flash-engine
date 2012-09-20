package apollo.network.command 
{
	import apollo.network.command.interfaces.INetPackageReceiving;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author john
	 */
	public class CCommandContainer extends Object 
	{
		protected var commandList: Dictionary;
		
		public function CCommandContainer() 
		{
			super();
			commandList = new Dictionary();
		}
		
		public function getCommand(flag: uint): INetPackageReceiving
		{
			if (commandList[flag] != null)
			{
				return new commandList[flag];
			}
			CONFIG::DebugMode
			{
				trace("Undefined protocol id: " + flag);
			}
			return null;
		}
	}

}