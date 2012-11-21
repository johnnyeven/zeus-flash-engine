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
        private var _crystal:Number;

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
        private var _tritium:Number;

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
       private var _broken_crysta:Number;

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
        public var militaryRrank:int;

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
         *军官证号
         */
        public var officer_id:String;
        
        /**
         *buff1
         */
        public var buff1:BuffVo;
		
        /**
         *buff2
         */
        public var buff2:BuffVo;
		
        /**
         *buff3
         */
        public var buff3:BuffVo;
		
        private var _current_power_supply:int;

       
        private var _current_power_consume:int;
		
		private var _legion_id:String;
		private var _junXian:String;

		/**
		 *新手任务
		 * 索引
		 */
		public var index:int;
		/**
		 *新手任务
		 * 是否完成
		 */
		public var is_finished:Boolean;
		/**
		 *新手任务
		 * 是否获取任务奖励
		 */
		public var is_rewarded:Boolean;
		
		/**
		 *礼包
		 * 是否已接受每日奖励
		 */
		public var received_daily_rewards:String="";
		/**
		 *礼包
		 * 是否已接受连续奖励
		 */
		public var received_continuous_rewards:String="";
		/**
		 *礼包
		 * 是否已接受在线奖励
		 */
		public var received_online_rewards:String="";
		
		/**
		 *军团ID 
		 */
		public function get legion_id():String
		{
			return _legion_id;
		}
		/**
		 *军团名字
		 */
		public var legion_name:String

		/**
		 * @private
		 */
		public function set legion_id(value:String):void
		{
			_legion_id = value;
		}

		/**
		 *当前能量供应
		 */
        public function get current_power_supply():int
        {
            return _current_power_supply;
        }


        public function set current_power_supply(value:int):void
        {
            _current_power_supply = value;

            updatePower();
        }
		
		/**
		 *当前能量损耗
		 */
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


        public function get crystal():Number
        {
            return _crystal;
        }

        public function set crystal(value:Number):void
        {
			_crystal=value;
//            _crystal = Math.min(value, crystal_volume);
        }

        public function get tritium():Number
        {
            return _tritium;
        }

        public function set tritium(value:Number):void
        {
			_tritium=value;
//            _tritium = Math.min(value, tritium_volume);
        }       

	  
	   public function get broken_crysta():Number
	   {
		   return _broken_crysta;
	   }

	   /**
	    * @private
	    */
	   public function set broken_crysta(value:Number):void
	   {
		   _broken_crysta = value;
	   }

		public function get junXian():String
		{
			switch(militaryRrank)
			{
				case 0:
				{
					_junXian="准尉";
					break;
				}
				case 1:
				{
					_junXian="少尉";
					break;
				}
				case 2:
				{
					_junXian="中尉";
					break;
				}
				case 3:
				{
					_junXian="上尉";
					break;
				}
				case 4:
				{
					_junXian="少校";
					break;
				}
				case 5:
				{
					_junXian="中校";
					break;
				}
				case 6:
				{
					_junXian="上校";
					break;
				}
				case 7:
				{
					_junXian="少将";
					break;
				}
				case 8:
				{
					_junXian="中将";
					break;
				}
				case 9:
				{
					_junXian="上将";
					break;
				}
				
			}
			return _junXian;
		}

	   public var session_key:String;

    }
}
