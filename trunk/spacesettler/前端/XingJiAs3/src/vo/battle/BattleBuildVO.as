package vo.battle
{
    import com.zn.utils.DateFormatter;

    import enum.battle.BattleBuildTypeEnum;

    import ui.vo.ValueObject;

    /**
     *战场建筑
     * @author zn
     *
     */
    [Bindable]
    public class BattleBuildVO extends ValueObject
    {
        public static const FIELD_XY:String = "xy";

        /**
         *
         */
        public var id:String;

        /**
         *
         */
        public var name:String;

        /**
         *
         */
        private var _type:int;

        /**
         *
         */
        public var level:int;

        /**
         *
         */
        public var x:Number = 0;

        /**
         *
         */
        public var y:Number = 0;

        /**
         *
         */
        public var isEdit:Boolean = false;

        /**
         *
         */
        public var state:int = 0;

        /**
         *
         * @return
         *
         */
        public function get type():int
        {
            return _type;
        }

        /**
         *
         * @param value
         *
         */
        public function set type(value:int):void
        {
            _type = value;

            name = BattleBuildTypeEnum.getBuildName(type);
            des = BattleBuildTypeEnum.getBuildDes(type);
        }

        /**
         *攻击力
         */
        public var attack:int;

        /**
         *耐久
         */
        public var endurance:int;

        /**
         *修建时间
         */
        public var time:int;

        public var endTime:Number = 0;

        public function get remainTime():Number
        {
            return Math.max(0, endTime - DateFormatter.currentTime);
        }

        public function initTime():void
        {
            endTime = DateFormatter.currentTime + time * 1000;
        }

        /**
         * 水晶矿
         */
        public var crystal:int;

        /**
         * 氚气
         */
        public var tritium:int;

        /**
         * 暗物质
         */
        public var broken_crystal:int;

        /**
         *
         */
        public var min_attack:int;

        /**
         *
         */
        public var max_attack:int;

        /**
         * 攻击范围
         */
        public var attack_range:int;

        /**
         * 攻击火范围
         */
        public var attack_area:int;

        /**
         * 攻击类型
         */
        public var attack_type:int;

        /**
         * 攻击冷却时间
         */
        public var attack_cool_down:int;

        /**
         *编辑选择时使用的显示信息
         */
        public var selectedInfo:String;

        /**
         *描述
         */
        public var des:String;

        public function get xy():String
        {
            return x + "." + y;
        }
    }
}
