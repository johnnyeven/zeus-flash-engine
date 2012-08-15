package apollo.center 
{
	import apollo.network.command.interfaces.*;
	import apollo.network.command.CCommandList;
	import apollo.network.command.sending.*;
	import apollo.network.CWebConnector;
	import apollo.objects.CGameObject;
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class CCommandCenter extends CBaseCenter 
	{
		private var connector: CWebConnector;
		private var command: CCommandList;
		private static var instance: CCommandCenter;
		private static var allowInstance: Boolean = false;
		
		public function CCommandCenter() 
		{
			super();
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			command = CCommandList.getInstance();
			connector = CWebConnector.getInstance();
			connector.addCallback(process);
		}
		
		private function process(flag: uint, data: Object): void
		{
			var protocol: INetPackageReceiving = command.getCommand(flag);
			if (protocol != null)
			{
				protocol.fill(data);
				triggerCallback(flag, protocol);
			}
		}
		
		public function add(flag: uint, processor: Function): void
		{
			addCallback(flag, processor);
		}
		
		public function remove(flag: uint, processor: Function): void
		{
			removeCallback(flag, processor);
		}
		
		public function send(protocol: CNetPackageSending): void
		{
			protocol.fill();
			connector.send(protocol.urlPath, protocol.urlVariables);
		}
		
		public static function getInstance(): CCommandCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CCommandCenter();
				allowInstance = false;
			}
			return instance;
		}
	}

}