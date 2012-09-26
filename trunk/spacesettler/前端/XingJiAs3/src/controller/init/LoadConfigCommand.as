package controller.init
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.loading.XMLLoader;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.VersionUtils;

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.text.Font;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     * 加载配置文件
     * @author zn
     *
     */
    public class LoadConfigCommand extends SimpleCommand
    {

        public static const LOAD_CONFIG_NOTE:String = "LoadConfigCommand.loadConfigNote";

        private var xmlLoader:XMLLoader;

        public function LoadConfigCommand()
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
            facade.removeCommand(LOAD_CONFIG_NOTE);

            xmlLoader = new XMLLoader("config/" + MultilanguageManager.language + "/loaderConfig.xml");
            xmlLoader.version = VersionUtils.getVersion("loaderConfig");

            xmlLoader.addEventListener(Event.COMPLETE, loaderConfig_completeHandler);
            xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, loaderConfig_errorHandler);
            xmlLoader.addEventListener(ProgressEvent.PROGRESS, loaderConfig_progressHandler);

            //显示加载进度条，设置加载条标题
            sendNotification(ResLoader.SET_LOADER_BAR_TITLE_NOTE, MultilanguageManager.getString("loaderConfig"));
            sendNotification(ResLoader.SHOW_LOADER_BAR_NOTE);

            //加载
            xmlLoader.load();
        }

        private function removeListener():void
        {
            xmlLoader.removeEventListener(Event.COMPLETE, loaderConfig_completeHandler);
            xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loaderConfig_errorHandler);
            xmlLoader.removeEventListener(ProgressEvent.PROGRESS, loaderConfig_progressHandler);
        }

        /**
         * 加载配置文件 完成
         * @param event
         *
         */
        protected function loaderConfig_completeHandler(event:Event):void
        {
            //隐藏加载进度条
            sendNotification(ResLoader.HIDE_LOADER_BAR_NOTE);

            removeListener();
            loaderPre();

        }

        /**
         *加载	预加载文件
         *
         */
        private function loaderPre():void
        {
            ResLoader.load("preLoader", MultilanguageManager.getString("loaderPre"), function(value:*):void
            {
                //解析链接信息
                sendNotification(ParseConnectParmsCommand.PARSE_CONNECT_PARMS_NOTE);
            },true);
        }


        protected function loaderConfig_progressHandler(event:LoaderEvent):void
        {
            //设置加载进度条
            sendNotification(ResLoader.SET_LOADER_BAR_PROGRESS_NOTE, event);
        }

        protected function loaderConfig_errorHandler(event:LoaderEvent):void
        {
            removeListener();
            //隐藏加载进度条
            sendNotification(ResLoader.HIDE_LOADER_BAR_NOTE);
//			Log.debug("加载错误：" + event.text);
        }

    }
}
