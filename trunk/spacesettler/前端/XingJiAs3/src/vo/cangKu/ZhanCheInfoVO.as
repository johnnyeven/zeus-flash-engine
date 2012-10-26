package vo.cangKu
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.StringUtil;

	/**
	 *战车
	 * @author zn
	 *
	 */
    [Bindable]
    public class ZhanCheInfoVO extends BaseItemVO
    {
        /**
         *战车插槽数
         */
        public var slots:int;

        /**
         *战车攻击力
         */
        public var attack:Number;

        /**
         *战车能量转换速度
         */
        public var attackSpeed:Number;

        /**
         *战车实弹减伤
         */
        public var damageDescShiDan:Number;

        /**
         *战车电磁减伤
         */
        public var damageDescDianCi:Number;

        /**
         *战车激光减伤
         */
        public var damageDescJiGuang:Number;

        /**
         *战车暗能减伤
         */
        public var damageDescAnNeng:Number;

        /**
         * 升级用时 单位秒
         */
        public var time:int;

        /**
         * 消耗水晶
         */
        public var crystal:int;

        /**
         * 消耗氚氢
         */
        public var tritium:int;        

        /**
         * 消耗暗物质
         */
        public var broken_crystal:int;

        /**
         * 消耗暗能水晶
         */
        public var dark_crystal:int;

        /**
         *战车评分
         */
 //       public var value:int;

        /**
         *战车等级
         */
//        public var level:int;

        /**
         * 攻击速度
         */
        public var attack_speed:int;

        /**
         * 雷达范围
         */
        public var search_area:int;

        /**
         * 攻击范围
         */
        public var attack_area:int;

        /**
         * 耐力
         */
        public var endurance:int;

        /**
         * 重量
         */
        public var weight:int;

        /**
         * 能量
         */
        public var energy:int;

        /**
         * 移动速度
         */
        public var speed:int;

        /**
         * 大型挂件槽数量
         */
        public var big_slot:int;

        /**
         * 中型挂件槽数量
         */
        public var medium_slot:int;

        /**
         * 小型挂件槽数量
         */
        public var small_slot:int;

        /**
         * 时代等级
         */
        public var age_level:int;

        /**
         *最大攻击速度
         */
        public var max_attack_speed:int;

        /**
         *最大搜索范围
         */
        public var max_search_area:int;

        /**
         *最大攻击范围
         */
        public var max_attack_area:int;

        /**
         *最大耐力
         */
        public var max_endurance:int;

        /**
         *最大重量
         */
        public var max_weight:int;

        /**
         *最大能量
         */
        public var max_energy:int;

        /**
         *最大速度
         */
        public var max_speed:int;

        /**
         *攻击速度百分比
         */
        public var attack_speed_inc:Number=attack_speed/max_attack_speed;

        /**
         *搜索范围百分比
         */
        public var search_area_inc:Number;

        /**
         *攻击范围百分比
         */
        public var attack_area_inc:Number=attack_area/max_attack_area;

        /**
         *耐力百分比
         */
        public var endurance_inc:Number=endurance/max_endurance;

        /**
         *重量百分比
         */
        public var weight_inc:Number;

        /**
         *能量百分比
         */
        public var energy_inc:Number=energy/max_energy;

        /**
         *速度百分比
         */
        public var speed_inc:Number=speed/max_speed;

        /**
         *战车折合暗物质数
         */
        public var dark_matter_value:int;

        /**
         *所属玩家ID
         */
        public var player_id:String;

		/**
		 * 剩余高槽数量
		 */		
        public var vice_slot:int;
		
		/**
		 * 攻速
		 */		
        public var total_attack_speed:int;
		
		/**
		 * 雷达范围
		 */		
        public var total_search_area:int;
		
		/**
		 * 攻击范围
		 */		
        public var total_attack_area:int;
		
		/**
		 * 耐久
		 */		
        public var total_endurance:int;
		
		/**
		 * 重量
		 */		
        public var total_weight:int;
		
		/**
		 * 能量
		 */		
        public var total_energy:int;
		
		/**
		 *护盾 
		 */		
        public var total_shield:int;
		
		/**
		 *移动速度 
		 */		
        public var total_speed:int;
		
		/**
		 *剩余耐久 
		 */		
        public var current_endurance:int;
		
		/**
		 *当前维修速度 
		 */		
        public var current_repair_speed:int;
		
		/**
		 *已使用的能量 
		 */		
        public var energy_in_use:int;
		
		/**
		 *回收可得到的资源 
		 * 
		 * 暗物质
		 */		
        public var recycle_price_broken_crystal:int;
		
		/**
		 *修理所需要花费的资源
		 *  
		 * 暗物质
		 */		
        public var repair_cost_broken_crystal:int;
		
		/**
		 *已装备的挂件数据 
		 */		
        public var guaJianItemVOList:Array=[];
		
		/**
		 *挂件描述 
		 */		
		public var propertyDes:String;
		
		private var _type:String;
		private var _naiLi:String;
		private var _nengLiang:String;
				
		public function createPropertyDes():void
		{
			var str:String="<p>";
			
			str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_value"),value);
			str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_level"),level);
			
			if(attack_area!=0)
				str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_attack_area"),attack_area);
			
			if(energy!=0)
				str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_energy"),energy);
			
			if(attack_speed!=0)
				str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_attack_speed"),attack_speed);
			
			if(endurance!=0)
				str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_endurance"),endurance);
			
			if(speed!=0)
				str+=StringUtil.formatString("<s>{0} {1}</s><n/>",MultilanguageManager.getString("guanJianDes_speed"),speed);
			
			if(gongJiType!=null)
				str+=StringUtil.formatString("<s>{0} {1}</s>",MultilanguageManager.getString("zhanJheDes_slot_type"),gongJiType);
			
			str+="</p>";
			
			propertyDes=str;
		}

		/**
		 * 攻击类型
		 */
		public function get gongJiType():String
		{
			if(category==1||category==2||category==3)
				_type="实弹";
			if(category==4||category==5||category==6)
				_type="激光";
			if(category==7||category==8||category==9)
				_type="电磁";
			if(category==10||category==11||category==12)
				_type="暗能";
			
			return _type;
		}

		/**
		 * @private
		 */
		public function set gongJiType(value:String):void
		{
			_type = value;
		}
		
		/**
		 *耐力比 耐久 
		 * @return 
		 * 
		 */		
		public function get naiLi():String
		{
			_naiLi=current_endurance.toString()+"/"+endurance.toString();
			
			return _naiLi;
		}

		public function set naiLi(value:String):void
		{
			_naiLi = value;
		}
    }
}
