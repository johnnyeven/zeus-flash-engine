package vo.userInfo
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    
    import ui.vo.ValueObject;

    [Bindable]
    public class UserInfoVO extends ValueObject
    {
        private var _tweenLite:TweenLite;

        /**
         * 玩家Id
         */
        public var player_id:String;

        /**
         * vip等级
         */
        public var vip_level:int;

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
        private var _crystal:int;

        /**
         * 水晶矿最大容量
         */
        public var crystal_volume:int;

        /**
         *水晶矿产出值
         */
        public var crystal_output:int;

        /**
         * 氚气数量 取值为正整数；
         */
        private var _tritium:int;

        /**
         *（氚氢最大容量）
         */
        public var tritium_volume:int;

        /**
         *（氚氢产出）
         */
        public var tritium_output:int;
		
		/**
		 * 暗物质数量 取值为正整数；
		 */
       private var _broken_crysta:int;

        /**
         *（暗物质产出）
         */
        public var broken_crystal_output:int;

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
        public var id:String;

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
        public var camp:int = 1;
		

		public var server_camp:int;
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
		
		private var _legion_id:String;

		/**
		 *军团ID 
		 */
		public function get legion_id():String
		{
			return _legion_id;
		}

		/**
		 * @private
		 */
		public function set legion_id(value:String):void
		{
			_legion_id = value;
		}


        public function get current_power_supply():int
        {
            return _current_power_supply;
        }


        public function set current_power_supply(value:int):void
        {
            _current_power_supply = value;

            updatePower();
        }

        public function get current_power_consume():int
        {
            return _current_power_consume;
        }

        public function set current_power_consume(value:int):void
        {
            _current_power_consume = value;

            updatePower();
        }

        public function updatePower():Number
        {
            power = Math.max(0, (_current_power_supply - _current_power_consume) / _current_power_supply);
			return power;
        }

        public function start():void
        {
            var endCrystal:int = crystal + crystal_output;
            var endTritium:int = tritium + tritium_output;
//            var endBroken:int = broken_crysta + broken_crystal_output;
//            _tweenLite = TweenLite.to(this, 3600, { crystal: endCrystal, tritium: endTritium, broken_crysta: endBroken,
//                                          ease: Linear.easeNone, onComplete: start });
        }


        public function get crystal():int
        {
            return _crystal;
        }

        public function set crystal(value:int):void
        {
			_crystal=value;
            _crystal = Math.min(value, crystal_volume);
        }

        public function get tritium():int
        {
            return _tritium;
        }

        public function set tritium(value:int):void
        {
			_tritium=value;
            _tritium = Math.min(value, tritium_volume);
        }       

	  
	   public function get broken_crysta():int
	   {
		   return _broken_crysta;
	   }

	   /**
	    * @private
	    */
	   public function set broken_crysta(value:int):void
	   {
		   _broken_crysta = value;
	   }
	   
	   public var session_key:String;

    }
}
