package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;

	/**
	 *击毁建筑（炮台）获得荣誉
	 * @author zn
	 *
	 */
	public class FightHonorVO extends ValueObject
	{
		public var playerID:String;
		public var buildingID:String;
		public var value:int;
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(playerID, body);
			SocketUtil.writeIdType(buildingID, body);
			body.writeUnsignedInt(value);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			playerID = SocketUtil.readIdType(by);
			buildingID = SocketUtil.readIdType(by);
			value =by.readUnsignedInt();
		}
	}
}
