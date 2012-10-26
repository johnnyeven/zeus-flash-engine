package controller.allView
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.allView.XingXingComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.allView.AllViewProxy;

    /**
     *行星要塞
     * @author lw
     *
     */
    public class ShowXingXingComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
        public function ShowXingXingComponentMediatorCommand()
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
			if(_isLoading)
				return ;
			var playerID:String = notification.getBody() as String;
			var allViewProxy:AllViewProxy = getProxy(AllViewProxy);
			allViewProxy.viewXingXing(playerID,function():void
			{
				 var med:XingXingComponentMediator = getMediator(XingXingComponentMediator);
	            if (med)
	            {
					callShow(med);
	            }
	            else
	            {
	                //加载界面SWF
					_isLoading=true;
	                ResLoader.load("allView.swf", MultilanguageManager.getString(""), loaderComplete,true);
	            }
			});
			
           
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:XingXingComponentMediator = new XingXingComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			
			_isLoading=false;
			
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