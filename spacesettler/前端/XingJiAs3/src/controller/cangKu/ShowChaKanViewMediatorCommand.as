package controller.cangKu
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import events.cangKu.ChaKanEvent;
    
    import mediator.BaseMediator;
    import mediator.cangKu.ChaKanZhanCheViewComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import view.cangKu.ChaKanZhanCheViewComponent;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowChaKanViewMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		private var _event:ChaKanEvent;
		
        public function ShowChaKanViewMediatorCommand()
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
			_event=notification.getBody() as ChaKanEvent;
			
            var med:ChaKanZhanCheViewComponentMediator = getMediator(ChaKanZhanCheViewComponentMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF
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
            var med:ChaKanZhanCheViewComponentMediator = new ChaKanZhanCheViewComponentMediator();
			var comp:ChaKanZhanCheViewComponent=med.getViewComponent() as ChaKanZhanCheViewComponent;
			comp.showValue(_event.tempInfo);
			
            //注册界面的中介
            facade.registerMediator(med);
            med.show();
			
			_isLoading=false;
        }
    }
}