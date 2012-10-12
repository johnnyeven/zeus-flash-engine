package controller.scienceResearch
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.scienceResearch.InforComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 *科技描述 
	 * @author lw
	 * 
	 */	
    public class ShowInforComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		private var obj:Object = null;
        public function ShowInforComponentMediatorCommand()
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
			obj = notification.getBody();
			if(_isLoading)
				return ;
			
            var med:InforComponentMediator = getMediator(InforComponentMediator);
			
            if (med)
            {
				med.setScienceType(obj.scienceType);
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("scienceResearch.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:InforComponentMediator = new InforComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.setScienceType(obj.scienceType);
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