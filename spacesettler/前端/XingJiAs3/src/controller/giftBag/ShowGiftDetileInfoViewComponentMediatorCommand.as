package controller.giftBag
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.giftBag.GiftDetileInfoViewComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.taskGift.GiftBagProxy;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowGiftDetileInfoViewComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		private var _giftProxy:GiftBagProxy;
        public function ShowGiftDetileInfoViewComponentMediatorCommand()
        {
            super();
			_giftProxy=getProxy(GiftBagProxy);
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
			var itemType:int=notification.getBody() as int;
			
			_giftProxy.checkOnlineReward(itemType,function ():void
			{
	            var med:GiftDetileInfoViewComponentMediator = getMediator(GiftDetileInfoViewComponentMediator);
	            if (med)
	            {
					callShow(med);
	            }
	            else
	            {
	                //加载界面SWF
					_isLoading=true;
	                ResLoader.load("giftBag.swf", MultilanguageManager.getString(""), loaderComplete, true);
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
            var med:GiftDetileInfoViewComponentMediator = new GiftDetileInfoViewComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			
			_isLoading=false;
			callShow(med);
        }
		
		private function callShow(med:GiftDetileInfoViewComponentMediator):void
		{
			med.comp.updateValue(_giftProxy.giftObj.type,_giftProxy.giftObj.rewards);
			
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