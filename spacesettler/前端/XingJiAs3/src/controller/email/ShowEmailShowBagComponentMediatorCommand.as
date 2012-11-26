package controller.email
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.email.EmailShowBagComponentMediator;
    import mediator.showBag.ShowBagComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.packageView.PackageViewProxy;

    /**
     *展示武器界面
     * @author lw
     *
     */
    public class ShowEmailShowBagComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		private var isEmail:Boolean = false;
        public function ShowEmailShowBagComponentMediatorCommand()
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
			if(notification.getBody())
			     isEmail = notification.getBody().isEmail as Boolean;
			var packageProxy:PackageViewProxy=getProxy(PackageViewProxy);
			packageProxy.packageViewView(function():void
			{
				 var med:EmailShowBagComponentMediator = getMediator(EmailShowBagComponentMediator);
	            if (med)
	            {
					med.isEmail(isEmail);
					callShow(med);
	            }
	            else
	            {
	                //加载界面SWF
					_isLoading=true;
	                ResLoader.load("showBag.swf", MultilanguageManager.getString(""), loaderComplete,true);
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
            var med:EmailShowBagComponentMediator = new EmailShowBagComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.isEmail(isEmail);
			_isLoading=false;
			
			callShow(med);
        }
		
		private function callShow(med:EmailShowBagComponentMediator):void
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