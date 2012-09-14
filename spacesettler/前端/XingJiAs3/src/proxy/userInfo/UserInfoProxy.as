package proxy.userInfo
{
    import com.zn.net.Protocol;
    
    import enum.command.CommandEnum;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
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
			Protocol.registerProtocol(CommandEnum.USER_INFO_GET,getUserInfoResult);
        }

        public function getUserInfo(callBack:Function = null):void
        {
            _getUserInfoCallBack = callBack;
			
            ConnDebug.send(CommandEnum.USER_INFO_GET);
        }

        public function getUserInfoResult(data:Object):void
        {
			userInfoVO=new UserInfoVO();
			userInfoVO.objectToVO(data);
			
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
