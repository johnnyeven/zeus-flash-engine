package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;

	/**
	 *开火
	 * @author zn
	 *
	 */
	public class FightFireVO extends ValueObject
	{
		/**
		 *开火对象
		 */
		public var id:String;

		/**
		 *被攻击对象ID
		 */
		public var hitID:String;
		
		public var startX:Number=0;
		public var startY:Number=0;
		
		public var endX:Number=0;
		public var endY:Number=0;

		public var rotation:Number=0;
		
		public function toBy():ByteArray
		{
			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(id, body);
			SocketUtil.writeIdType(hitID, body);
			body.writeFloat(startX);
			body.writeFloat(startY);
			body.writeFloat(endX);
			body.writeFloat(endY);
			body.writeFloat(rotation);
			
			return body;
		}

		public function toObj(by:ByteArray):void
		{
			id=SocketUtil.readIdType(by);
			hitID=SocketUtil.readIdType(by);
			
			startX=by.readFloat();
			startY=by.readFloat();
			endX=by.readFloat();
			endY=by.readFloat();
			rotation=by.readFloat();
		}
	}
}
