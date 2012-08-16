package apollo.network.command.sending 
{
	import apollo.configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_CameraView extends CNetPackageSending 
	{
		public var AccountId: String;
		
		public function Send_Info_CameraView() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_CAMERAVIEW_OBJECT_LIST);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.account_id = AccountId;
		}
	}

}