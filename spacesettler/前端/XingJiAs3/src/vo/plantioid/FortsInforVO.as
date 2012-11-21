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

		public var current_time:Number;
		
        /**
         *攻击保护时间
         */
        public var protected_until:Number;

        public var protectedEndTime:Number;

        public function get protectedRemainTime():Number
        {
            return Math.max(0, protectedEndTime - DateFormatter.currentTime);
        }

		public function initProtectedUntil():void
		{
			protectedEndTime = DateFormatter.currentTime + (protected_until - current_time) * 1000;
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
		 *玩家进入该小行星加载的地图类型  用的1-8表示  # 阵营地图:1,2,3,4为蓝色阵营, 5,6,7,8为黄色阵营
         # 地图类型:1,5=>上下(上), 2,6=>上下(下), 3,7=>左右(左), 4,8=>左右(右)
			1、2=蓝色纵
			3、4=蓝色横
			5、6=黄色纵
			7、8=黄色横
		 */
		public var map_type:int;
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
            else if (campID == userInfoVO.server_camp)
                type = PlantioidTypeEnum.CAMP;
            else if (campID != userInfoVO.server_camp &&
                (!StringUtil.isEmpty(player_id) && userInfoVO.player_id != player_id))
                type = PlantioidTypeEnum.ENEMY;
			
			if(type==PlantioidTypeEnum.OWN)
				isEdit=true;
			else
				isEdit=false;
        }
		
		/**
		 *行星已有建筑
		 * BattleBuildVO 
		 */		
		public var buildVOList:Array=[];
		
		/**
		 *是否可编辑 
		 */		
		public var isEdit:Boolean=false;
		
		public var mapID:int=1;
    }
}
