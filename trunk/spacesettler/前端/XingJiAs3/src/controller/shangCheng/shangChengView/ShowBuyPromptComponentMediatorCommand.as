package controller.shangCheng.shangChengView
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.shangCheng.BuyPromptComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowBuyPromptComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		private var _obj:Object;
		
        public function ShowBuyPromptComponentMediatorCommand()
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
			
			_obj=notification.getBody();
			
            var med:BuyPromptComponentMediator = getMediator(BuyPromptComponentMediator);
            if (med)
            {
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("ShangCheng.swf", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:BuyPromptComponentMediator = new BuyPromptComponentMediator();
			med.data=_obj;
            //注册界面的中介
            facade.registerMediator(med);
			
			_isLoading=false;
			callShow(med);
        }
		
		private function callShow(med:BuyPromptComponentMediator):void
		{
			med.data=_obj;
			med.comp.infoLabel.text="你确定要兑换" + _obj.resourceName +"吗？";
			
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