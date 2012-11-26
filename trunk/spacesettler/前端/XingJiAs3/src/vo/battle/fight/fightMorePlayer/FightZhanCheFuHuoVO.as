package vo.battle.fight.fightMorePlayer
{
	import com.zn.net.socket.ClientSocket;
	
	import enum.battle.FightCustomMessageTypeEnum;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;
	
	/**
	 *战车复活 
	 * 小队其他玩家可以看到复活战车 
	 * 
	 */
	public class FightZhanCheFuHuoVO extends ValueObject
	{
		/**
		 *复活对象ID
		 */		
		public var id:String;
		
		/**
		 *是否复活  1=复活   0=没有复活
		 */		
		public var isFuHuo:int;
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			body.writeUnsignedInt(FightCustomMessageTypeEnum.FU_HUO);
			SocketUtil.writeIdType(id, body);
			SocketUtil.writeIdType(String(isFuHuo), body);
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			id = SocketUtil.readIdType(by);
			isFuHuo = int(SocketUtil.readIdType(by));
		}
		
		public function FightZhanCheFuHuoVO()
		{
		}
	}
}