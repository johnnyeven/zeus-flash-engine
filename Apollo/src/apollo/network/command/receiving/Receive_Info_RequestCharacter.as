package apollo.network.command.receiving 
{
	import apollo.configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_RequestCharacter extends CNetPackageReceiving 
	{
		public var Result: Array;
		
		public function Receive_Info_RequestCharacter() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_REQUEST_CHARACTER);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				Result = new Array();
			}
		}
	}

}