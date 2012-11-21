package other
{
    import com.zn.net.http.HttpConn;
    
    import flash.net.URLRequestMethod;
    
    import mediator.prompt.PromptMediator;
    
    import net.NetHttpConn;
    
    import proxy.login.LoginProxy;
    import proxy.userInfo.UserInfoProxy;

    public class ConnDebug
    {
		public static const HTTP:int=1;
		
		public static var userInfoProxy:UserInfoProxy;
		
        public static function send(commandID:String, obj:Object=null,type:int=HTTP,method:String=URLRequestMethod.POST):void
        {
			if(!userInfoProxy)
				userInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			if(obj&&userInfoProxy)
				obj.HTTP_SESSION_KEY= userInfoProxy.userInfoVO.session_key;
			if(type==HTTP)
                NetHttpConn.send(commandID, obj,method);
        }
    }
}
