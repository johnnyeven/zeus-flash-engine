package Apollo.Network 
{
	import Apollo.Controller.CControllerCenter;
	import Apollo.Events.NetworkEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.Socket;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import Apollo.Configuration.*;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CNetConnection implements IEventDispatcher
	{
		protected var socket: Socket;
		protected var _ctrlCenter: CControllerCenter;
		protected var eventDispatcher: EventDispatcher;
		
		public static const CONTROLLER_INFO: int = 0
		public static const CONTROLLER_BATTLE: int = 3;
		public static const CONTROLLER_MSG: int = 2;
		public static const CONTROLLER_MOVE: int = 1;
		public static const NPC_CONTROLLER_BATTLE: int = 13;
		public static const NPC_CONTROLLER_MOVE: int = 11;
		
		public static const ACTION_MOVETO: int = 0;
		public static const ACTION_MOVE: int = 1;
		public static const ACTION_LOGIN: int = 1;
		public static const ACTION_LOGOUT: int = 2;
		public static const ACTION_PUBLIC_MSG: int = 0;
		public static const ACTION_PRIVATE_MSG: int = 1;
		public static const ACTION_ATTACK: int = 0;
        public static const ACTION_PREPARE_ATTACK: int = 2;
		public static const ACTION_UNDERATTACK: int = 1;
		//INFO
		public static const ACTION_CAMERAVIEW_OBJECT_LIST: int = 0;
		public static const ACTION_CHANGE_ACTION: int = 1;
		
		public static const TYPE_INT: int = 0;
		public static const TYPE_LONG: int = 1;
		public static const TYPE_STRING: int = 2;
		
		public static const ACK_CONFIRM: int = 1;
		public static const ACK_ERROR: int = 0;
		public static const ORDER_CONFIRM: int = 2;
		
		public function CNetConnection(_ctrlCenter: CControllerCenter) 
		{
			eventDispatcher = new EventDispatcher(this);
			this._ctrlCenter = _ctrlCenter;
		}
		
		protected function connect(): void
		{
			try
			{
				socket = new Socket();
				socket.addEventListener(Event.CONNECT, onConnected);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
				socket.addEventListener(IOErrorEvent.IO_ERROR, onConnectError);
				socket.connect(SocketContextConfig.server_ip, SocketContextConfig.server_port);
			}
			catch (err: SecurityError)
			{
				trace(err.message);
				socket.removeEventListener(Event.CONNECT, onConnected);
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			}
		}
		
		protected function onConnectError(event: IOErrorEvent): void
		{
			
		}
		
		protected function onConnected(event: Event): void
		{
			dispatchEvent(new Event(Event.CONNECT));
		}
		
		protected function onSocketData(event: ProgressEvent): void
		{
			while (socket.bytesAvailable)
			{
				// Read a byte from the socket and display it
				var socketByte: ByteArray = new ByteArray();
				socketByte.endian = Endian.LITTLE_ENDIAN;
				socket.readBytes(socketByte, 0, packageLength);
				
				while (socketByte.bytesAvailable)
				{
					var packageLength: int = socketByte.readShort();
					var dataByte: ByteArray = new ByteArray();
					dataByte.endian = Endian.LITTLE_ENDIAN;
					socketByte.readBytes(dataByte, 0, packageLength);
				
					var success: int = dataByte.readByte();
					var controller: int = dataByte.readByte();
					var action: int = dataByte.readByte();
					
					var evt: NetworkEvent;
					if (success == ACK_CONFIRM)
					{
						switch(controller)
						{
							case CONTROLLER_BATTLE:
								switch(action)
								{
									case ACTION_ATTACK:
										evt = new NetworkEvent(NetworkEvent.ATTACK_CONFIRM);
										evt.data = dataByte;
										dispatchEvent(evt);
										break;
									/*
									case ACTION_UNDERATTACK:
										evt = new NetworkEvent(NetworkEvent.UNDERATTACK_CONFIRM);
										evt.data = dataByte;
										dispatchEvent(evt);
										break;
									*/
								}
								break;
							case CONTROLLER_INFO:
								switch(action)
								{
									case ACTION_CAMERAVIEW_OBJECT_LIST:
										evt = new NetworkEvent(NetworkEvent.OBJECT_LIST_CONFIRM);
										evt.data = dataByte;
										dispatchEvent(evt);
										break;
								}
								break;
						}
					}
					else if (success == ORDER_CONFIRM)
					{
						switch(controller)
						{
							case NPC_CONTROLLER_BATTLE:
								switch(action)
								{
									case ACTION_PREPARE_ATTACK:
										evt = new NetworkEvent(NetworkEvent.NPC_ATTACK_REQUEST);
										evt.data = dataByte;
										dispatchEvent(evt);
										break;
									case ACTION_ATTACK:
										evt = new NetworkEvent(NetworkEvent.NPC_ATTACK_CONFIRM);
										evt.data = dataByte;
										dispatchEvent(evt);
										break;
								}
						}
					}
				}
			}
		}
		
		public function sendPackage(data: CNetPackage): Boolean
		{
			var bytes: ByteArray = new ByteArray();
			
			bytes.writeByte((data.controller << 4) | data.action);
			
			try
			{
				socket.writeBytes(bytes);
				for (var i: uint = 0; i < data.param.length; i++)
				{
					socket.writeInt(data.param[i][0]);
					if (data.param[i][1] is int)
					{
						socket.writeByte(TYPE_INT);
						socket.writeInt(data.param[i][1]);
					}
					else if (data.param[i][1] is String)
					{
						socket.writeByte(TYPE_STRING);
						socket.writeUTFBytes(data.param[i][1]);
					}
				}
				socket.flush();
			}
			catch(err: Error)
			{
				trace(err.message);
				return false;
			}
			
			return true;
		}
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false): void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 
		 * @param e
		 */
		public function dispatchEvent(e:Event): Boolean
		{
			return eventDispatcher.dispatchEvent(e);
		}

		/**
		 * 
		 * @param type
		 */
		public function hasEventListener(type:String): Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}

		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false): void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * 
		 * @param type
		 */
		public function willTrigger(type:String): Boolean
		{
			return eventDispatcher.willTrigger(type);
		}
	}

}