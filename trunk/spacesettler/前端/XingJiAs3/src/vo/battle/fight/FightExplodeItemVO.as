package vo.battle.fight
{
    import ui.vo.ValueObject;

    /**
     *爆炸 伤害对象
     * @author zn
     *
     */
    public class FightExplodeItemVO extends ValueObject
    {
		/**
		 * 受到伤害的目标id
		 */
        public var id_take_attack:String;

		/**
		 * 0 chariot     1 building
		 */
        public var type:int;

		/**
		 * 攻击类型
		 */
        public var attack_type:int;

		/**
		 * 受到伤害的目标当前位置
		 */
        public var x:Number = 0;

		/**
		 * 
		 */
        public var y:Number = 0;
    }
}
