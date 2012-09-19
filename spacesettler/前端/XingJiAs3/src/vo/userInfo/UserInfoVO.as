package vo.userInfo
{
    import ui.vo.ValueObject;

    [Bindable]
    public class UserInfoVO extends ValueObject
    {
		/**
		 * 玩家Id
		 */		
        public var player_id:String;
		
		/**
		 * 玩家昵称
		 */		
        public var nickname:String;

		/**
		 * 玩家名字
		 */		
        public var userName:String;
		
		/**
		 * 水晶矿数量 取值为正整数；
		 */		
        public var crystal:int;
		
		/**
		 * 氚气数量 取值为正整数；
		 */		
        public var tritium:int;
		
		/**
		 * 暗物质数量 取值为正整数；
		 */		
        public var broken_crysta:int;
		
		/**
		 * 暗能水晶数量 取值为正整数；
		 */		
        public var dark_crystal:int;

		/**
		 * 基地时代
		 */		
        public var level:int;
		
		/**
		 * 基地ID
		 */	
        public var id:int;		
		
		/**
		 *军衔  
		 */		
		public var militaryRrank:String;
		
		/**
		 *声望 
		 */		
		public var prestige:int;
		
		/**
		 *阵营 
		 */		
		public var camp:int=1;
		
		/**
		 *电量百分比 
		 */		
		public var power:Number;
		
		/**
		 *当前能量供应 
		 */		
		private var _current_power_supply:int;

		/**
		 *当前能量损耗 
		 */		
		private var _current_power_consume:int;
		
		public function get current_power_supply():int
		{
			return _current_power_supply;
		}

		
		public function set current_power_supply(value:int):void
		{
			_current_power_supply = value;
			
			power=(_current_power_supply-_current_power_consume)/_current_power_supply;
		}
		
		public function get current_power_consume():int
		{
			return _current_power_consume;
		}
		
		public function set current_power_consume(value:int):void
		{
			_current_power_consume = value;
			
			power=(_current_power_supply-_current_power_consume)/_current_power_supply;			
		}
		
		
		
    }
}
