package controller.scienceResearch
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.scienceResearch.ScienceResearchComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.scienceResearch.ScienceResearchProxy;

    /**
     *科研
     * @author lw
     *
     */
    public class ShowScienceResearchComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
        public function ShowScienceResearchComponentMediatorCommand()
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
		
		    var scienceResearchProxy:ScienceResearchProxy = getProxy(ScienceResearchProxy);
			scienceResearchProxy.getScienceResearchInfor(function():void
			{
			    var med:ScienceResearchComponentMediator = getMediator(ScienceResearchComponentMediator);
	            if (med)
	            {
					callShow(med);
	            }
	            else
	            {
	                //加载界面SWF
					_isLoading=true;
	                ResLoader.load("scienceResearch.swf", MultilanguageManager.getString(""), loaderComplete,true);
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
            var med:ScienceResearchComponentMediator = new ScienceResearchComponentMediator();

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