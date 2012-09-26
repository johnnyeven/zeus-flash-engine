package controller.cangKu
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.ResEnum;
    
    import mediator.BaseMediator;
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowCangkuPackageViewComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
        public function ShowCangkuPackageViewComponentMediatorCommand()
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
			
            var med:CangkuPackageViewComponentMediator = getMediator(CangkuPackageViewComponentMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF ResEnum.parentURL+senceBuildingView/
				_isLoading=true;
                ResLoader.load("cangKuPackageView.swf", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:CangkuPackageViewComponentMediator = new CangkuPackageViewComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
            med.show();
			
			_isLoading=false;
        }
    }
}