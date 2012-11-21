package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;

	/**
	 *爆炸
	 * @author zn
	 *
	 */
	public class FightExplodeVO extends ValueObject
	{
		public var startX:Number=0;
		public var startY:Number=0;
		
		/**
		 * 攻击者ID
		 */
		public var id:String;
		
		public var gid:int;
		
		public var minAttack:Number=0;
		
		public var maxAttack:Number=0;
		
		public var attackArea:Number=0;
		
		/**
		 * 被攻击的对象
		 */
		public var hitList:Array=[];
		
		public var guaJianID:String="";

		public function toBy():ByteArray
		{
			var body:ByteArray=ClientSocket.getBy();
			
			body.writeFloat(startX);
			body.writeFloat(startY);
			
			SocketUtil.writeIdType(id, body);
			body.writeUnsignedInt(gid);
			
			body.writeFloat(minAttack);
			body.writeFloat(maxAttack);
			body.writeFloat(attackArea);
			
			body.writeUnsignedInt(hitList.length);
			
			var itemVO:FightExplodeItemVO;
			for (var i:int=0; i < hitList.length; i++)
			{
				itemVO=hitList[i];
				body.writeBytes(itemVO.toBy());
			}

			SocketUtil.writeIdType(guaJianID, body);
			
			return body;
		}

		public function toObj(by:ByteArray):void
		{
			startX=by.readFloat();
			startY=by.readFloat();
			
			id=SocketUtil.readIdType(by);
			gid=by.readUnsignedInt();
			
			minAttack=by.readFloat();
			maxAttack=by.readFloat();
			attackArea=by.readFloat();
			
			var count:int=by.readUnsignedInt();
			
			hitList=[];
			var itemVO:FightExplodeItemVO;
			for (var i:int=0; i < count; i++)
			{
				itemVO=new FightExplodeItemVO();
				itemVO.toObj(by);
				hitList.push(itemVO);
			}
			
			guaJianID=SocketUtil.readIdType(by);
		}
	}
}
