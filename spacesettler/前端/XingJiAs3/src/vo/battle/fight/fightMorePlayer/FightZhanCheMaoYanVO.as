package vo.battle.fight.fightMorePlayer
{
	import com.zn.net.socket.ClientSocket;
	
	import enum.battle.FightCustomMessageTypeEnum;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;
	
	/**
	 * 战车冒烟特效
	 * @author lw
	 * 
	 */	
	public class FightZhanCheMaoYanVO extends ValueObject
	{
		/**
		 *冒烟对象ID
		 */		
		public var id:String;
		
		/**
		 *是否冒烟  1=冒烟   0=不冒烟
		 */		
		public var isMaoYan:int
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			body.writeUnsignedInt(FightCustomMessageTypeEnum.MAO_YAN);
			SocketUtil.writeIdType(id, body);
			SocketUtil.writeIdType(String(isMaoYan), body);
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			id = SocketUtil.readIdType(by);
			isMaoYan = int(SocketUtil.readIdType(by));
		}
	}
}