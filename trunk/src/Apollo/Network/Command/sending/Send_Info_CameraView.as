package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.SocketContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_CameraView extends CNetPackageSending 
	{
		public var guid: String;
		public var x: int;
		public var y: int;
		public var width: int;
		public var height: int;
		
		public function Send_Info_CameraView() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_CAMERAVIEW_OBJECT_LIST);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(guid.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(guid);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(x);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(y);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(width);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(height);
		}
	}

}