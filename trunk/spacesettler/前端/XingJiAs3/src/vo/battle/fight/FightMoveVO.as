package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;

	/**
	 * 战车移动
	 * @author zn
	 *
	 */
	public class FightMoveVO extends ValueObject
	{
		/**
		 * 对象ID
		 */
		public var id:String;

		public var startX:Number=0;
		public var startY:Number=0;
		
		public var angle:Number=0;
		public var moveSpeed:Number=0;

		public var endX:Number=0;
		public var endY:Number=0;


		/**
		 * 客户端发送移动可以不填写，服务器返回的结构此处表示距离此次移动已过去的时间ms
		 */
		public var durationTime:int;

		public function toBy():ByteArray
		{
			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(id, body); //攻击者id
			body.writeFloat(startX); //出发点坐标
			body.writeFloat(startY); //出发点坐标
			body.writeFloat(angle);
			body.writeFloat(moveSpeed);
			body.writeFloat(endX); //目标点坐标
			body.writeFloat(endY);
			body.writeInt(0); //客户端发送移动可以不填写，服务器返回的结构此处表示距离此次移动已过去的时间ms

			return body;
		}

		public function toObj(by:ByteArray):void
		{
			id=SocketUtil.readIdType(by);
			startX=by.readFloat();
			startY=by.readFloat();
			angle=by.readFloat();
			moveSpeed=by.readFloat();
			endX=by.readFloat();
			endY=by.readFloat();
			durationTime=by.readUnsignedInt();
		}
	}
}
