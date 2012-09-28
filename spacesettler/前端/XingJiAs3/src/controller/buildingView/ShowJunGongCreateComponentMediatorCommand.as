package controller.buildingView
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.ResEnum;
    
    import mediator.BaseMediator;
    import mediator.buildingView.JunGongCreateComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowJunGongCreateComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
        public function ShowJunGongCreateComponentMediatorCommand()
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
			
            var med:JunGongCreateComponentMediator = getMediator(JunGongCreateComponentMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("junGongChang_view", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:JunGongCreateComponentMediator = new JunGongCreateComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
            med.show();
			
			_isLoading=false;
        }
    }
}