package apollo.controller.skill 
{
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class SkillConfig 
	{
		public function SkillConfig() 
		{
			
		}
		
		/**
		 * 取得技能ID为skillId的技能的相关信息
		 * @param	skillId
		 * @return	Array
		 * 第一个元素表示是否有发射阶段的动画，0表示没有，其他>0的整数表示有发射动画并且为多少帧
		 * 第二个元素表示是否有爆炸阶段的动画，同上
		 * 
		 */
		public static function getSkillConfig(skillId: String): Object
		{
			var obj: Object = new Object();
			switch(skillId)
			{
				case "skill1":
					obj.fire = 9;
					obj.explode = 9;
					obj.isRangeAttack = 0;						//0表示单体伤害
					obj.level = new Array();
					
					var skill1_level1: Object = new Object();
					skill1_level1.singTime = 100;				//吟唱时间
					skill1_level1.cdTime = 4000;				//技能CD
					skill1_level1.distance = 200;				//攻击距离
					obj.level.push(skill1_level1);
					
					var skill1_level2: Object = new Object();
					skill1_level2.singTime = 2500;				//吟唱时间
					skill1_level2.cdTime = 3000;				//技能CD
					skill1_level2.distance = 300;				//攻击距离
					obj.level.push(skill1_level2);
					break;
				case "skill2":
					obj.fire = 0;
					obj.explode = 18;
					obj.isRangeAttack = 0;						//0表示单体伤害
					obj.level = new Array();
					
					var skill2_level1: Object = new Object();
					skill2_level1.singTime = 1000;				//吟唱时间
					skill2_level1.cdTime = 3000;				//技能CD
					skill2_level1.distance = 100;				//攻击距离
					obj.level.push(skill2_level1);
					break;
				case "skill3":
					obj.fire = 0;
					obj.explode = 25;
					obj.isRangeAttack = 1;
					obj.level = new Array();
					
					var skill3_level1: Object = new Object();
					skill3_level1.singTime = 1000;				//吟唱时间
					skill3_level1.cdTime = 4000;				//技能CD
					skill3_level1.distance = 200;				//攻击距离
					obj.level.push(skill3_level1);
					
					var skill3_level2: Object = new Object();
					skill3_level2.singTime = 4000;				//吟唱时间
					skill3_level2.cdTime = 6000;				//技能CD
					skill3_level2.distance = 300;				//攻击距离
					obj.level.push(skill3_level2);
					break;
				case "skill4":
					obj.fire = 0;
					obj.explode = 45;
					obj.isRangeAttack = 0;
					obj.level = new Array();
					
					var skill4_level1: Object = new Object();
					skill4_level1.singTime = 1000;				//吟唱时间
					skill4_level1.cdTime = 5000;				//技能CD
					skill4_level1.distance = 100;				//攻击距离
					obj.level.push(skill4_level1);
					break;
				case "skill5":
					obj.fire = 0;
					obj.explode = 18;
					obj.isRangeAttack = 0;
					obj.level = new Array();
					
					var skill5_level1: Object = new Object();
					skill5_level1.singTime = 1000;				//吟唱时间
					skill5_level1.cdTime = 6000;				//技能CD
					skill5_level1.distance = 100;				//攻击距离
					obj.level.push(skill5_level1);
					break;
			}
			return obj;
		}
		
		public static function isRangeAttack(skillId: String): Boolean
		{
			var obj: Object = getSkillConfig(skillId);
			if (obj.isRangeAttack > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}

}