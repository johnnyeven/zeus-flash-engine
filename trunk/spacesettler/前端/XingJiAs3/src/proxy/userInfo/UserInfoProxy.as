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
			getUserInfoResult(loginProxy.serverData);
        }

        public function getUserInfoResult(data:Object):void
        {
			userInfoVO=new UserInfoVO();
			userInfoVO.id=data.id;
			userInfoVO.player_id=data.player_id;
			userInfoVO.nickname=data.nickname;
			userInfoVO.current_power_consume=data.current_power_consume;
			userInfoVO.crystal=data.crystal;
			userInfoVO.broken_crysta=data.broken_crysta;
			userInfoVO.current_power_supply=data.current_power_supply;
			userInfoVO.dark_crystal=data.dark_crystal;
			userInfoVO.level=data.level;
			userInfoVO.prestige=data.prestige;
			userInfoVO.tritium=data.tritium;
			userInfoVO.userName=data.name;
			
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

    }
}
