package controller.cangKu
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import events.cangKu.ChaKanEvent;
    
    import mediator.BaseMediator;
    import mediator.cangKu.ChaKanGuaJianViewComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import view.cangKu.ChaKanGuaJianViewComponent;
    
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.GuaJianInfoVO;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowChaKanGuaJianViewComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		private var obj:BaseItemVO;
		
        public function ShowChaKanGuaJianViewComponentMediatorCommand()
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
            var med:ChaKanGuaJianViewComponentMediator = getMediator(ChaKanGuaJianViewComponentMediator);
			
            if (med)
            {
				callShow(med);
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
            var med:ChaKanGuaJianViewComponentMediator = new ChaKanGuaJianViewComponentMediator();
            //注册界面的中介
            facade.registerMediator(med);
			callShow(med);
			_isLoading=false;
        }
		
		private function callShow(med:BaseMediator):void
		{
			if (loadCompleteCallBack != null)
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