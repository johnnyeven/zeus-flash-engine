package apollo.network.command.receiving 
{
	import apollo.configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_CameraView extends CNetPackageReceiving 
	{
		
		public function Receive_Info_CameraView() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_CAMERAVIEW_OBJECT_LIST);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				
			}
		}
	}

}