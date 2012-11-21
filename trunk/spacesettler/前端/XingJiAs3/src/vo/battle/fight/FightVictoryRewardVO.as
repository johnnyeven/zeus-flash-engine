package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;
	
	
	/**
	 * 战斗胜利的奖励
	 * @author 
	 *
	 */
	public class FightVictoryRewardVO extends ValueObject
	{
		/**
		 * 金晶（捡到的资源）
		 * 
		 */
		public var crystal:int;
		/**
		 * 氚氢（捡到的资源）
		 * 
		 */
		public var tritium:int;
		/**
		 * 暗物质（捡到的资源）
		 * 
		 */
		public var dark:int;
		/**
		 * 暗能水晶（捡到的资源）
		 * 
		 */
		public var dark_crystal:int;
		/**
		 * 奖励类型
		 * 
		 */
		public var resource_type:int;
		/**
		 * 奖励数目
		 * 
		 */
		public var delta:int;
		/**
		 * 赢了才会有图纸
		 * 图纸类型
		 */
		public var bluemap_recipes_type:int;
		/**
		 * 
		 * 图纸分类
		 */
		public var bluemap_recipes_category:int;
		/**
		 * 图纸等级
		 * 
		 */
		public var bluemap_level:int;
		/**
		 * 获得荣誉
		 */
		public var honour_obtain:int;
		/**
		 * 是否获取到了要塞
		 * 0=no 1=yes
		 */
		public var gain_fort:int;
		/**
		 * 暗物质数目
		 */
		public var dark_delta:int;
		/**
		 * 复活用了多少水晶
		 */
		public var dark_crystal_for_relive:int;
		
		public function FightVictoryRewardVO()
		{
			super();
		}
		
		public function toBy():ByteArray
		{
			var body:ByteArray=ClientSocket.getBy();
			body.writeUnsignedInt(crystal);
			body.writeUnsignedInt(tritium);
			body.writeUnsignedInt(dark);
			body.writeUnsignedInt(dark_crystal);
			body.writeUnsignedInt(resource_type);
			body.writeUnsignedInt(delta);
			body.writeUnsignedInt(bluemap_recipes_type);
			body.writeUnsignedInt(bluemap_recipes_category);
			body.writeUnsignedInt(bluemap_level);
			body.writeUnsignedInt(honour_obtain);
			body.writeUnsignedInt(gain_fort);
			body.writeUnsignedInt(dark_delta);
			body.writeUnsignedInt(dark_crystal_for_relive);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			crystal=by.readInt();
			tritium=by.readInt();
			dark=by.readInt();
			dark_crystal=by.readInt();
			resource_type=by.readInt();
			delta=by.readInt();
			bluemap_recipes_type=by.readInt();
			bluemap_recipes_category=by.readInt();
			bluemap_level=by.readInt();
			honour_obtain=by.readInt();
			gain_fort=by.readInt();
			dark_delta=by.readInt();
			dark_crystal_for_relive=by.readInt();
		}
	}
}