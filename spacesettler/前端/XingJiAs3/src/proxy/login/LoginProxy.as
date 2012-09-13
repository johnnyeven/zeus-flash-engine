package proxy.login
{
    import com.zn.net.Protocol;
    
    import controller.init.LoaderResCommand;
    import enum.CommandEnum;
    
    import mediator.login.LoginMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;

    import other.ConnDebug;
    
    import vo.userInfo.UserInfoVO;
    /**
     *登录
     * @author zn
     *
     */
    public class LoginProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "LoginProxy";

		/**
		 * 成功
		 */
        public static const SUCCESS_NOTE:String = "LoginProxy.Success";

		/**
		 *失败 
		 */        
        public static const FAILURE_NOTE:String = "LoginProxy.failure";
		
        public static var userInfoVO:UserInfoVO;

        public function LoginProxy(data:Object = null)
        {
            super(NAME, data);
            Protocol.registerProtocol(CommandEnum.LOGIN, loginResult);
        }

        /**
         *登录
         *
         */
        public function login(userName:String, password:String):void
        {
            var obj:Object = { userName: userName, password: password };

            ConnDebug.send(CommandEnum.LOGIN, obj);
        }

        /**
         *登录返回
         *
         */
        private function loginResult(data:*):void
        {
            sendNotification(SUCCESS_NOTE);
            sendNotification(LoginMediator.DESTROY_NOTE);

            //加载进入游戏的资源
            sendNotification(LoaderResCommand.LOAD_RES_NOTE);
        }
    }
}