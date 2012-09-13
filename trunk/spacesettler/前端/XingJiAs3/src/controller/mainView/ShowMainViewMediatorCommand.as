package controller.mainView
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.loading.LoaderItem;
    import com.zn.loading.SWFLoader;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.mainView.MainViewMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowMainViewMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean = false;
		
		public static var loadCompleteCallBack:Function;
        public function ShowMainViewMediatorCommand()
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
			if (_isLoading)
				return;
            var med:MainViewMediator = getMediator(MainViewMediator);
            if (med)
            {
				callShow(med);
            }
            else
            {
                //加载界面SWF
                ResLoader.load("mainView.swf", MultilanguageManager.getString(""), loaderComplete);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            //创建界面的外观
            var med:MainViewMediator = new MainViewMediator();
			
            //注册界面的中介
            facade.registerMediator(med);
			_isLoading = false;
			
			callShow(med);
        }
		
		private function callShow(med:BaseMediator):void
		{
			if (loadCompleteCallBack!=null)
			{
				loadCompleteCallBack(med);
				loadCompleteCallBack = null;
			}
			else
			{
            med.show();
        }
		}
    }
}