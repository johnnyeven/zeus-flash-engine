package controller.init
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.loading.LoaderMax;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.LoaderItemUtil;
    import com.zn.utils.XMLUtil;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *加载登录以后的资源
     * @author zn
     *
     */
    public class LoaderResCommand extends SimpleCommand
    {
        public static const LOAD_RES_NOTE:String = "LoaderResCommand.loadResNote";

        public function LoaderResCommand()
        {
            super();
        }

        /**
         *执行
         * @param notification
         *
         */
        public override function execute(notification:INotification):void
        {
            facade.removeCommand(LOAD_RES_NOTE);

            ResLoader.load("configList.zip", MultilanguageManager.getString("loaderConfigList"), loaderXMLCompleteHandler,true);
        }

        private function loaderXMLCompleteHandler(event:LoaderEvent):void
        {
            XMLUtil.zipLoaderList.push(LoaderItemUtil.getLoader("configList.zip"));

            ResLoader.load("needRes", MultilanguageManager.getString("loaderNeedResRes"), loaderCompleteHandler,true);
        }

        private function loaderCompleteHandler(event:LoaderEvent):void
        {
            //加载其他资源
            ResLoader.load("otherRes");

            //初始
            sendNotification(InitCommand.INIT_NOTE);
        }
    }
}
