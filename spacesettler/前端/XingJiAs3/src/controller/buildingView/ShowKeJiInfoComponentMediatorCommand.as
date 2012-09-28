package controller.buildingView
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.ResEnum;
    
    import mediator.BaseMediator;
    import mediator.buildingView.KeJiInfoComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowKeJiInfoComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
        public function ShowKeJiInfoComponentMediatorCommand()
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
			
            var med:KeJiInfoComponentMediator = getMediator(KeJiInfoComponentMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("keJi_view", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:KeJiInfoComponentMediator = new KeJiInfoComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
            med.show();
			
			_isLoading=false;
        }
    }
}