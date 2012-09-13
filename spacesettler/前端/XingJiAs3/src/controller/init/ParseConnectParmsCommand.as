package controller.init
{
    import com.zn.net.http.HttpConn;
    import com.zn.utils.LoaderItemUtil;
    
    import controller.login.ShowLoginMediatorCommand;
    
    import flash.events.Event;
    
    import mediator.login.LoginMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import vo.GlobalData;

    /**
     *解析链接信息
     * @author zn
     *
     */
    public class ParseConnectParmsCommand extends SimpleCommand
    {
        public static const PARSE_CONNECT_PARMS_NOTE:String = "ParseConnectParmsCommand.parseConnectParms";

        public function ParseConnectParmsCommand()
        {
            super();
        }

        /**
         *当MVC事件发生的时候，它会去执行这里
         * @param notification
         *
         */
        override public function execute(notification:INotification):void
        {
            facade.removeCommand(PARSE_CONNECT_PARMS_NOTE);

			var configXML:XML = XML(LoaderItemUtil.getContent("connectionConfig.xml"));

            if (GlobalData.channel == 0)
                GlobalData.channel = int(configXML.channel);

            Main.sim = configXML.simulate == "true" ? true : false;
			
            var connectionXML:XML;

            /*********************************
             *
             * scoket连接方式
             *
             * ********************************/
//			connectionXML=configXML.socket.(@channel == GlobalData.channel)[0];
//			var ip:String=connectionXML.ip.toString();
//			var port:int=int(connectionXML.port);
//
//            ClientSocket.instance.addEventListener(Event.CONNECT, connectHandler);
//            ClientSocket.instance.connectServer(ip, port);

            /*********************************
             *
             * HTTP连接方式
             *
             * ********************************/
            connectionXML = configXML.http.(@channel == GlobalData.channel)[0];
            HttpConn.sendURL = connectionXML.sendURL;
            HttpConn.receiveURL = connectionXML.receiveURL;

            connectHandler(null);
        }

        /**
         *联接成功
         * @param event
         *
         */
        protected function connectHandler(event:Event):void
        {
//           载入登陆界面
            showLogin();
        }

        protected function showLogin():void
        {
            //注册登陆界面
            facade.registerCommand(LoginMediator.SHOW_NOTE, ShowLoginMediatorCommand);

            sendNotification(LoginMediator.SHOW_NOTE);
        }
    }
}

