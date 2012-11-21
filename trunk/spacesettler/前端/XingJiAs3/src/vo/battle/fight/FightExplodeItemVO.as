package vo.battle.fight
{
    import com.zn.net.socket.ClientSocket;
    
    import flash.utils.ByteArray;
    
    import ui.vo.ValueObject;
    
    import utils.battle.SocketUtil;

    /**
     *爆炸 伤害对象
     * @author zn
     *
     */
    public class FightExplodeItemVO extends ValueObject
    {
		public static const CHARIOT:int=0;
		
		public static const BUILDING:int=1;
		
		/**
		 * 受到伤害的目标id
		 */
        public var hitID:String;
		
		/**
		 *受到伤害的类型
		 * 0 chariot     1 building 
		 */		
		public var type:int=CHARIOT;
		
		/**
		 *攻击类型 
		 */		
		public var attackType:int;
		
		/**
		 *受到伤害的目标坐标
		 */		
		public var hitX:Number=0;
		
		public var hitY:Number=0;

		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(hitID, body);
			body.writeUnsignedInt(type);
			body.writeUnsignedInt(attackType);
			body.writeFloat(hitX);
			body.writeFloat(hitY);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			hitID = SocketUtil.readIdType(by);
			type=by.readUnsignedInt();
			attackType=by.readUnsignedInt();
			hitX=by.readFloat();
			hitY=by.readFloat();
		}
    }
}
