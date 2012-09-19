package enum
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;
    
    import proxy.userInfo.UserInfoProxy;
    
    import vo.userInfo.UserInfoVO;

    public class MainSenceEnum
    {
        /**
         *获取阵营地图URL
         * @return
         *
         */
        public static function get campBGURL():String
		{
            var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
            var str:String =ResEnum.parentURL + "senceMap/mainSence_{0}.swf";
            return StringUtil.formatString(str, userInfoVO.camp);
        }
		
		/**
		 *星球特效 
		 * @return 
		 * 
		 */
		public static function get xingQiuURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapEffect/sence{0}_xingQiu.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *瀑布特效 
		 * @return 
		 * 
		 */
		public static function get puBuURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapEffect/sence{0}_puBu.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *灯光特效 
		 * @return 
		 * 
		 */
		public static function get dengGuangURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapEffect/sence{0}_dengguang.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *管道特效 
		 * @return 
		 * 
		 */
		public static function get guanDaoURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapEffect/sence{0}_guandao.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *1主基地
		 * @return 
		 * 
		 */
		public static function get centerBuildingURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_centerBuilding.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *2氚气提炼
		 * @return 
		 * 
		 */
		public static function get chuanQingCangURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_chuanQingCang.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *3暗能电厂
		 * @return 
		 */
		public static function get anNengDianChangURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_anNengDianChang.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *4仓库
		 * @return 
		 */
		public static function get cangKuURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_cangKu.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *6科技
		 * @return 
		 */
		public static function get keXueYuanURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_keXueYuan.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *5矿场
		 * @return 
		 */
		public static function get kuangChangURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_kuangChang.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *7军工厂
		 * @return 
		 */
		public static function get junGongCangURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_junGongCang.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *8时间机器
		 * @return 
		 */
		public static function get timeMachineURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_timeMachine.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		/**
		 *建筑升级特效
		 * @return 
		 */
		public static function get buildUpURL():String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var str:String =ResEnum.parentURL + "senceMapBuilding/sence{0}_building_up.swf";
			return StringUtil.formatString(str, userInfoVO.camp);
		}
    }
}
