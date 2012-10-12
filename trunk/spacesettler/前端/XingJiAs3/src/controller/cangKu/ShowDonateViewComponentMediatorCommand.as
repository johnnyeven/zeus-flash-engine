package controller.cangKu
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import events.cangKu.ChaKanEvent;
    import events.cangKu.DonateEvent;
    
    import mediator.BaseMediator;
    import mediator.cangKu.DonateViewComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import ui.managers.PopUpManager;
    
    import view.cangKu.DonateViewComponent;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowDonateViewComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		private var obj:Object;
        public function ShowDonateViewComponentMediatorCommand()
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
			obj=notification.getBody() as Object;
			
            var med:DonateViewComponentMediator = getMediator(DonateViewComponentMediator);
            if (med)
            {
				//PopUpManager.addPopUp((med.getViewComponent())as DonateViewComponent,false);
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
            var med:DonateViewComponentMediator = new DonateViewComponentMediator();
			med.upData(obj);
//			var comp:DonateViewComponent=med.getViewComponent() as DonateViewComponent;
//			comp.setValue(_event.tempInfo);

            //注册界面的中介
            facade.registerMediator(med);
            med.show();
			
			_isLoading=false;
        }
    }
}