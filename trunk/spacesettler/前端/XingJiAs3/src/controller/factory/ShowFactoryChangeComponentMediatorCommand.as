package controller.factory
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.factory.FactoryChangeComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowFactoryChangeComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
        public function ShowFactoryChangeComponentMediatorCommand()
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
			
            var med:FactoryChangeComponentMediator = getMediator(FactoryChangeComponentMediator);
            if (med)
            {
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("ordnanceFactory.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:FactoryChangeComponentMediator = new FactoryChangeComponentMediator();

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