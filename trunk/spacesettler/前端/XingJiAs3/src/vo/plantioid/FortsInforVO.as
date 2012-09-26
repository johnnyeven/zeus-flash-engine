package vo.plantioid
{
    import flash.geom.Point;
    
    import ui.vo.ValueObject;

    /**
     * 行星要塞
     * @author lw
     *
     */
    public class FortsInforVO extends ValueObject
    {
        /**
         *要塞ID
         */
        public var id:String;

        /**
         *要塞等级
         */
        public var level:int;

        /**
         *要塞在X坐标
         */
        public var x:Number;

        /**
         *要塞在y坐标
         */
        public var y:Number;

        /**
         *攻击保护时间
         */
        public var protected_until:int;

        /**
         *要塞类型
         *
         * 要塞类型
			具体类型参考策划文档
			1-10为普通小行星，目前取值只有1、2、3，分别对应三张小行星图片
			10以上为NPC行星，分别对应四张NPC行星图片
     */
        public var fort_type:int;

        /**
         *所属玩家ID
         */
        public var player_id:String;

        /**
         *要塞名称
         */
        public var fort_name:String;

        /**
         *产出资源
         */
        public var resources:Object;

        private var _crystal_output:int;

        private var _tritium_output:int;

        private var _broken_crystal_output:int;

        /**
         *科技时代

         */
        public var age_level:int;

        public var z:int;
		
		public var type:int;

        public function FortsInforVO()
        {
        }


        /**
         *产出水晶矿
         */
        public function get crystal_output():int
        {
            _crystal_output = resources.crystal_output;
            return _crystal_output;
        }

        /**
         *产出氚氢气
         */
        public function get tritium_output():int
        {
            _tritium_output = resources.tritium_output;
            return _tritium_output;
        }

        /**
         *产出暗物质
         */
        public function get broken_crystal_output():int
        {
            _broken_crystal_output = resources.broken_crystal_output;
            return _broken_crystal_output;
        }

		public function updateType():void
		{
			
		}
		
    }
}
