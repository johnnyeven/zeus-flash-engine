package vo.cangKu
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;

    import ui.vo.ValueObject;

    import vo.scienceResearch.ScienceResearchVO;

    /**
     * 道具图纸
     * @author zn
     *
     */
	[Bindable]
    public class ItemVO extends BaseItemVO
    {
        /**
         * 是否使用
         */
        public var in_using:int;

        /**
         * 道具标识
         */
        public var key:String;

        /**
         * 暗能水晶消耗
         */
        public var dark_crystal:int;


        /**
         * 道具效果持续时间
         */
        public var time:int;

        /**
         * VIP等级
         */
        public var vip_level:int;

        /**
         * 水晶增产量
         */
        public var crystal_inc:Number;

        /**
         * 氚氢增产量
         */
        public var tritium_inc:Number;

        /**
         * 暗物质增产率
         */
        public var broken_crystal_inc:Number;

        /**
         * 折扣
         */
        public var discount:Number;

        /**
         * 图纸ID
         * 2:21:1:6
            这四个数字分别代表recipe_type:category:enhanced:type，由这四个数字确定唯一图纸
    */
        public var recipe_id:String;

        /**
         * 是否能使用
         */
        public var can_use:Boolean;

        /**
         * 生成的挂件类型
         */
        public var tank_part_type:int;

        /**
         *图纸类型
         */
        public var recipe_type:int;

        /**
         * 生产的战车
         */
        public var zhanCheVO:ZhanCheInfoVO;

        /**
         * 生产的挂件
         */
        public var guaJianVO:GuaJianInfoVO;


        /**
         *科技条件
         * value:ScienceResearchVO
         */
        public var techVOList:Array = [];

        /**
         *科技描述
         */
        public var techPropertyDes:String = "";
		/**
		 *
		 */
		public var index:String;

        public function createTechPropertyDes():void
        {
            var str:String = "<p>";

            var techVO:ScienceResearchVO;
            for (var i:int = 0; i < techVOList.length; i++)
            {
                techVO = techVOList[i];
                str += StringUtil.formatString("<s>{0} {1}</s><n/>", techVO.scienceName, techVO.currentLevel + "/" + techVO.level);
            }

            str += "</p>";

            techPropertyDes = str;
        }


    }
}
