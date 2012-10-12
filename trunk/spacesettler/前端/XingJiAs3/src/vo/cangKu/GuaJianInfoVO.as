package vo.cangKu
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;
    
    import enum.item.AttackTypeEnum;
    import enum.item.SlotEnum;
    
    import ui.vo.ValueObject;

	/**
	 * 
	 * @author zn
	 * 
	 */
    public class GuaJianInfoVO extends BaseItemVO
    {

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
		 * 口径
		 */
        public var caliber:int;

		/**
		 * 评分
		 */
        public var value:int;

		/**
		 * 挂件等级
		 */
        public var level:int;

		/**
		 * 插槽类型
		 */
        public var slot_type:int;

		/**
		 * 伤害类型
		 */
        public var attack_type:int;

		/**
		 * 攻击力
		 */
        public var attack:int;

		/**
		 * 冷却时间
		 */
        public var attack_cool_down:Number;

		/**
		 * 所需能量
		 */
        public var energy:int;

		/**
		 * 爆炸范围
		 */
        public var explode_area:int;

		/**
		 * 
		 */
        public var sort:Object;
		
		/**
		 * 耐力
		 */
		public var endurance:Number;

		/**
		 * 抵消伤害类型
		 */
        public var damage_desc_type:int;

		/**
		 * 抵消伤害
		 */
        public var damage_desc:Number;

		/**
		 * 战车折合暗物质数
		 */
		public var dark_matter_value:int;
		
		/**
		 * 是否已装备
		 */
		public var is_mounted:int;
		
		/**
		 * 所属玩家ID
		 */		
		public var player_id:String;
		
		/**
		 *重量 
		 */		
		public var weight:int;
		
		/**
		 *提供能量 
		 */		
		public var energy_supply:int;
		
		/**
		 *行走速度 
		 */		
		public var speed:int;
		
		/**
		 * 维修速度
		 */		
		public var repair_speed:int;
		
		/**
		 * 雷达范围
		 */		
		public var area:int;
		
		/**
		 *攻速 
		 */		
		public var attack_speed:int;
		
		/**
		 *攻击范围 
		 */		
		public var attack_area:int;
		
		/**
		 *战车ID 
		 */		
		public var chariot_id:String;
		
		/**
		 *是否可用 
		 */		
		public var disable:Boolean;
		
		/**
		 *挂件描述 
		 */		
		public var propertyDes:String;
		
		/**
		 *能量护盾
		 */		
		public var shield:int;
		
		/**
		 *类型
		 */		
		public var age_level:int;
		
		public function createPropertyDes():void
		{
			var str:String="<p>";
			
			str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_value"),value);
			str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_level"),level);
			
			if(slot_type==SlotEnum.BIG)
			{
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_attack_type"),AttackTypeEnum.getAttckTypeStr(attack_type));
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_attack"),attack);
			}
			if(slot_type==SlotEnum.MID)
			{
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_damage_desc_type"),AttackTypeEnum.getAttckTypeStr(damage_desc_type));
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_damage_desc"),int(damage_desc*100)+"%");
			}
			
			if(area!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_area"),area);
			
			if(attack_area!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_attack_area"),attack_area);
			
			if(energy!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_energy"),energy);
			
			if(attack_speed!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_attack_speed"),attack_speed);
			
			if(endurance!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_endurance"),endurance);
			
			if(energy_supply!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_energy_supply"),energy_supply);
			
			if(explode_area!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_explode_area"),explode_area);
			
			if(repair_speed!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_repair_speed"),repair_speed);
			
			if(shield!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_shield"),shield);
			
			if(speed!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s><n/>",MultilanguageManager.getString("guanJianDes_speed"),speed);
			
			if(slot_type!=0)
				str+=StringUtil.formatString("<s>{0}:{1}</s>",MultilanguageManager.getString("guanJianDes_slot_type"),SlotEnum.getSlotTypeStr(slot_type));
			
			str+="</p>";
			
			propertyDes=str;
		}
    }
}
