package controller.init
{
    import com.zn.utils.LoaderItemUtil;
    
    import enum.command.CommandEnum;
    
    import mediator.login.StartComponentMediator;
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.login.LoginProxy;
    
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
			
			sendNotification(PromptMediator.SHOW_LOADWAITMC_NOTE);

			var configXML:XML = XML(LoaderItemUtil.getContent("connectionConfig.xml"));

            if (GlobalData.channel == 0)
                GlobalData.channel = int(configXML.channel);

            var connectionXML:XML= configXML.serverList.(@channel == GlobalData.channel)[0];
			CommandEnum.get_server_list=connectionXML.url;
			GlobalData.game_id=connectionXML.game_id;
			
			var loginProxy:LoginProxy=getProxy(LoginProxy);
//			loginProxy.getServerList(connectHandler);
			
			connectHandler();
			
        }

        /**
         *联接成功
         * @param event
         *
         */
        protected function connectHandler():void
        {
			sendNotification(PromptMediator.HIDE_LOADWAITMC_NOTE);
			
//           载入登陆界面
            showLogin();
        }

        protected function showLogin():void
        {
            sendNotification(StartComponentMediator.SHOW_NOTE);
        }
    }
}

