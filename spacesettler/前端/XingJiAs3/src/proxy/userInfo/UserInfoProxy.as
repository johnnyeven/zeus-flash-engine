package proxy.userInfo
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    
    import enum.command.CommandEnum;
    
    import flash.net.URLRequestMethod;
    
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.BuildProxy;
    import proxy.login.LoginProxy;
    import proxy.timeMachine.TimeMachineProxy;
    
    import vo.allView.FriendInfoVo;
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
        }

		public function updateInfo():void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.updateInfo, updateInfoResult))
			    Protocol.registerProtocol(CommandEnum.updateInfo, updateInfoResult);
			var id:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.id;
			var obj:Object={id:id};
			ConnDebug.send(CommandEnum.updateInfo, obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		public function updateInfoResult(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.updateInfo, updateInfoResult);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return;
			}
			
			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.updateServerData(data);
		}
		
        public function getUserInfoResult(data:Object):void
        {
            if (!userInfoVO)
            {
                userInfoVO = new UserInfoVO();
            }
            userInfoVO.id = data.base.id;
            userInfoVO.player_id = data.base.player_id;
            userInfoVO.nickname = data.nickname;
			
			userInfoVO.crystal_volume=data.base.crystal_volume;
			userInfoVO.tritium_volume=data.base.tritium_volume;
			
			userInfoVO.crystal_output=data.base.crystal_output;
			userInfoVO.tritium_output=data.base.tritium_output;
			userInfoVO.broken_crystal_output=data.base.broken_crystal_output;
			
            userInfoVO.crystal = data.base.crystal;
            userInfoVO.broken_crysta = data.base.broken_crystal;
            userInfoVO.current_power_consume = data.base.current_power_consume;
            userInfoVO.current_power_supply = data.base.current_power_supply;
            userInfoVO.dark_crystal = data.dark_crystal;
            userInfoVO.level = data.age_level;
            userInfoVO.prestige = data.prestige;
            userInfoVO.tritium = data.base.tritium;
            userInfoVO.userName = data.base.name;
			
			userInfoVO.legion_id = data.legion_id;
			
			userInfoVO.server_camp=data.camp_id;
            userInfoVO.camp = userInfoVO.server_camp + 1;
//			userInfoVO.camp=2;
			
			userInfoVO.session_key=data.session_key;
			
			userInfoVO.start();

            if (_getUserInfoCallBack != null)
                _getUserInfoCallBack();
            _getUserInfoCallBack = null;

			Main.setMouseCursor( userInfoVO.camp);
        }

        /***********************************************************
         *
         * 功能方法
         *
         * ****************************************************/
        /**
         *更新服务器数据
         * @param data
         */
        public function updateServerData(data:* = null):void
        {
            var loginProxy:LoginProxy = getProxy(LoginProxy);
            if (data)
                loginProxy.serverData = data;

            getUserInfoResult(loginProxy.serverData);

            var buildProxy:BuildProxy = getProxy(BuildProxy);
            buildProxy.getBuildInfoResult(loginProxy.serverData);
			var timeMachineProxy:TimeMachineProxy = getProxy(TimeMachineProxy);
			timeMachineProxy.timeMachineInfor(loginProxy.serverData);

        }
    }
}
