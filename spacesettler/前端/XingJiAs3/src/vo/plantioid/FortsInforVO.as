package vo.plantioid
{
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;
    
    import enum.plantioid.PlantioidTypeEnum;
    
    import proxy.userInfo.UserInfoProxy;
    
    import ui.vo.ValueObject;
    
    import vo.userInfo.UserInfoVO;

    /**
     * 行星要塞
     * @author lw
     *
     */
    public class FortsInforVO extends ValueObject
    {
		public static const FIELD_ID:String="id";
		
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
        public var protected_until:Number;

        public var protectedEndTime:Number;

        public function get protectedRemainTime():Number
        {
            return Math.max(0, protectedEndTime - DateFormatter.currentTime);
        }

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

        /**
         *星球类型
         */
        public var type:int;

        public var campID:int;

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
            var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
            if (userInfoVO.player_id == player_id)
                type = PlantioidTypeEnum.OWN;
            else if (fort_type > 10)
                type = PlantioidTypeEnum.NPC;
            else if (player_id == "0")
                type = PlantioidTypeEnum.NO_OWN;
            else if (campID == userInfoVO.camp)
                type = PlantioidTypeEnum.CAMP;
            else if (campID != userInfoVO.camp ||
                (!StringUtil.isEmpty(player_id) && userInfoVO.player_id != player_id))
                type = PlantioidTypeEnum.ENEMY;
        }
    }
}
