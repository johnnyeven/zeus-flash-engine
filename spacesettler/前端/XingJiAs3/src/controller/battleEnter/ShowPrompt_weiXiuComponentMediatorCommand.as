package controller.battleEnter
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.prompt.PromptWeiXiuMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *进入战场维修战车
     * @author zn
     *
     */
    public class ShowPrompt_weiXiuComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		private var obj:Object;
        public function ShowPrompt_weiXiuComponentMediatorCommand()
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
			if(notification.getBody())
			{
				obj = notification.getBody();
			}
            var med:PromptWeiXiuMediator = getMediator(PromptWeiXiuMediator);
            if (med)
            {
				if(obj)
				{
					med.setData(obj);
				}
				
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("battleEnter.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:PromptWeiXiuMediator = new PromptWeiXiuMediator();

            //注册界面的中介
            facade.registerMediator(med);
			if(obj)
			{
				med.setData(obj);
			}
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