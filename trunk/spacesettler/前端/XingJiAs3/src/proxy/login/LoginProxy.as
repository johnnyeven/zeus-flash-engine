package proxy.login
{
    import com.zn.net.Protocol;
    
    import controller.init.LoaderResCommand;
    
    import enum.ServerItemEnum;
    import enum.command.CommandEnum;
    import enum.command.CommandResultTypeEnum;
    
    import flash.net.URLRequestMethod;
    
    import mediator.login.LoginMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import vo.GlobalData;
    import vo.ServerItemVO;
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

        /**
         *用户数据
         */
        [Bindable]
        public static var userInfoVO:UserInfoVO;

        /**
         *服务器列表
         */
        [Bindable]
        public var serverVOList:Array = [];

        private var _getServerListCallBack:Function;

        /**
         *选择服务器
         */
        [Bindable]
        public static var selectedServerVO:ServerItemVO;

		//注册的变量值
		private var _severName:String;
		private var _userName:String;
		private var _passWord:String;
		private var _passAgainWord:String;
		
        public function LoginProxy(data:Object = null)
        {
            super(NAME, data);
        }

		/**
		 *快速登录
		 *
		 */
		public function startLogin():void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.startLogin,startLoginResult))
				Protocol.registerProtocol(CommandEnum.startLogin,startLoginResult);
			ConnDebug.send(CommandEnum.startLogin,null,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		/**
		 *快速登录返回
		 *
		 */
		public function startLoginResult():void
		{
			
		}
		
        /**
         *登录
         *
         */
        public function login(userName:String, password:String):void
        {
            if (!Protocol.hasProtocolFunction(CommandEnum.login, loginResult))
                Protocol.registerProtocol(CommandEnum.login, loginResult);

            var obj:Object = { username: userName, password: password };

            ConnDebug.send(CommandEnum.login, obj);
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

        /**
         *获取服务器列表
         *
         */
        public function getServerList(callBack:Function):void
        {
            Protocol.registerProtocol(CommandEnum.get_server_list, getServerListResult);

            _getServerListCallBack = callBack;
            var obj:Object = { game_id: GlobalData.game_id };
            ConnDebug.send(CommandEnum.get_server_list, obj);
        }

        private function getServerListResult(data:*):void
        {
            var message:String = data.message;

            switch (message)
            {
                case CommandResultTypeEnum.SERVER_LIST_SUCCESS:
                {
                    var list:Array = [];
                    var objList:Array = data.server;

                    var serverVO:ServerItemVO;
                    for (var i:int = 0; i < objList.length; i++)
                    {
                        serverVO = new ServerItemVO();
                        serverVO.account_server_id = objList[i].account_server_id;
                        serverVO.server_name = objList[i].server_name;
                        serverVO.server_ip = objList[i].server_ip;
                        serverVO.server_max_player = objList[i].server_max_player;
                        serverVO.account_count = objList[i].account_count;
                        serverVO.server_language = objList[i].server_language;
                        serverVO.server_recommend = objList[i].server_recommend;
                        serverVO.server_message_ip = objList[i].server_message_ip;
                        list.push(serverVO);

                        if (serverVO.server_recommend == ServerItemEnum.recommend)
                            selectedServerVO = serverVO;
                    }

                    serverVOList = list;

                    if (_getServerListCallBack != null)
                        _getServerListCallBack();

                    break;
                }
            }

            _getServerListCallBack = null;
        }
		
		/**
		 *注册
		 *
		 */
		public function regist(name:String,email:String):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.regist,registResult))
				Protocol.registerProtocol(CommandEnum.regist,registResult);
			
			var obj:Object = {username:_userName,password:_passWord,nickname:name,email:email};
			ConnDebug.send(CommandEnum.regist,obj);
		}
		
		private function registResult(data:*):void
		{
			
		}
		
		/*****************************************
		 * 功能方法
		 * ****************************************/
		public function infor(severName:String,userName:String,passWord:String,passAgainWord:String):void
		{
			_severName=severName;
			_userName=userName;
			_passWord=passWord;
			_passAgainWord=passAgainWord;
		}
    }
}
