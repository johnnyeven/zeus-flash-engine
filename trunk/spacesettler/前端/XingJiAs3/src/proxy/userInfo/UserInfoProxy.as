package proxy.userInfo
{
    import com.zn.net.Protocol;
    
    import enum.command.CommandEnum;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.login.LoginProxy;
    
    import vo.userInfo.UserInfoVO;

    /**
     *用户信息
     * @author zn
     *
     */
    public class UserInfoProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "UserInfoProxy";

        private var _getUserInfoCallBack:Function;

        [Bindable]
        public var userInfoVO:UserInfoVO;

        public function UserInfoProxy(data:Object = null)
        {
            super(NAME, data);
			var loginProxy:LoginProxy=getProxy(LoginProxy);
			updateServerData(loginProxy.serverData);
        }

        public function getUserInfoResult(data:Object):void
        {
			if(!userInfoVO)
			{
				userInfoVO=new UserInfoVO();
			}			
			userInfoVO.id=data.base.id;
			userInfoVO.player_id=data.base.player_id;
			userInfoVO.nickname=data.nickname;
			userInfoVO.crystal=data.base.crystal;
			userInfoVO.broken_crysta=data.base.broken_crystal;
			userInfoVO.current_power_consume=data.base.current_power_consume;
			userInfoVO.current_power_supply=data.base.current_power_supply;
			userInfoVO.dark_crystal=data.dark_crystal;
			userInfoVO.level=data.base.level;
			userInfoVO.prestige=data.prestige;
			userInfoVO.tritium=data.base.tritium;
			userInfoVO.userName=data.base.name;
			userInfoVO.camp=data.camp_id+1;
			
            if (_getUserInfoCallBack != null)
                _getUserInfoCallBack();
            _getUserInfoCallBack = null;
        }

    /***********************************************************
     *
     * 功能方法
     *
     * ****************************************************/
		public function updateServerData(data:*):void
		{
			var loginProxy:LoginProxy=getProxy(LoginProxy);
			loginProxy.serverData=data;
			
			getUserInfoResult(loginProxy.serverData);
			
		}
    }
}
