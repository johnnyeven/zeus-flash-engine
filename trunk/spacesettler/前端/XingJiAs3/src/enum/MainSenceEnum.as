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
    }
}
