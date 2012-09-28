package proxy.login
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    
    import controller.init.LoaderResCommand;
    
    import enum.ServerItemEnum;
    import enum.command.CommandEnum;
    import enum.command.CommandResultTypeEnum;
    
    import flash.events.Event;
    import flash.net.URLRequestMethod;
    
    import mediator.login.LoginMediator;
    import mediator.login.NameInforComponentMediator;
    import mediator.login.PkComponentMediator;
    import mediator.login.RegistComponentMediator;
    import mediator.login.StartComponentMediator;
    import mediator.prompt.PromptMediator;
    
    import net.chat.ChatSocket;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.BuildProxy;
    import proxy.content.ContentProxy;
    import proxy.userInfo.UserInfoProxy;
    
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

        public var serverData:Object;

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
        public var userName:String;

        public var passWord:String;

        public var passAgainWord:String;

        public var name:String;

        public var email:String;

        public var alliance:String;

        public var camp:int;

        private var _registCallBack:Function;

        private var _startLoingCallBack:Function;

        public function LoginProxy(data:Object = null)
        {
            super(NAME, data);
        }

        /**
         *快速登录
         *
         */
        public function startLogin(callBack:Function):void
        {
            _startLoingCallBack = callBack;

            if (!Protocol.hasProtocolFunction(CommandEnum.startLogin, startLoginResult))
                Protocol.registerProtocol(CommandEnum.startLogin, startLoginResult);
            ConnDebug.send(CommandEnum.startLogin, null, ConnDebug.HTTP, URLRequestMethod.GET);
        }
		
        /**
         *快速登录返回
         *
         */
        public function startLoginResult(data:*):void
        {
            if (_startLoingCallBack != null)
                _startLoingCallBack();
            _startLoingCallBack = null;

            serverData = data;
            enterGame();
        }

        /**
         *登录
         *
         */
        public function login(userName:String, password:String):void
        {
            this.userName = userName;
            this.passWord = password;
            if (!Protocol.hasProtocolFunction(CommandEnum.login, loginResult))
                Protocol.registerProtocol(CommandEnum.login, loginResult);

            var obj:Object = { username: userName, password: password };

            ConnDebug.send(CommandEnum.login, obj);
        }

        /**
         *登录返回
         *
         */
        private function loginResult(data:Object):void
        { 
			
			var loginMeditor:LoginMediator = getMediator(LoginMediator);
			
            serverData = data;
            if (data.errors == "")
            {
                sendNotification(LoginMediator.DESTROY_NOTE);
         
                loginMeditor.destoryCallback = function():void
                {
                    sendNotification(NameInforComponentMediator.SHOW_NOTE,data);
                };
                return;
            }
            else if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString(data.errors));
				loginMeditor.mouseEnabled=true;
                return;
            }

            enterGame();
        }

        private function enterGame():void
        {
            sendNotification(SUCCESS_NOTE);
            sendNotification(StartComponentMediator.DESTROY_NOTE);
            sendNotification(LoginMediator.DESTROY_NOTE);
            sendNotification(NameInforComponentMediator.DESTROY_NOTE);
            sendNotification(PkComponentMediator.DESTROY_NOTE);
            sendNotification(RegistComponentMediator.DESTROY_NOTE);
            StartComponentMediator.removeBG();

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
                        serverVO.server_message_ip = objList[i].server_message_ip.split(":")[0];
						serverVO.server_message_port=objList[i].server_message_ip.split(":")[1];
                        serverVO.server_game_id = objList[i].server_game_id;
                        serverVO.server_game_port = objList[i].server_game_port;

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
        public function regist(callBack:Function):void
        {
            if (!Protocol.hasProtocolFunction(CommandEnum.regist, registResult))
                Protocol.registerProtocol(CommandEnum.regist, registResult);

            _registCallBack = callBack;
            var obj:Object = { username: userName, password: passWord, nickname: name, email: email, camp_id: camp };
            ConnDebug.send(CommandEnum.regist, obj);
        }

        private function registResult(data:Object):void
        {
			var pkComponentMeditor:PkComponentMediator = getMediator(PkComponentMediator);
			
            serverData = data;
            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString(data.errors));
				pkComponentMeditor.mouseEnabled = true;
                return;
            }

            if (_registCallBack != null)
                _registCallBack();
            _registCallBack = null;

            enterGame();
        }

    /*****************************************
     * 功能方法
     * ****************************************/
    }
}
