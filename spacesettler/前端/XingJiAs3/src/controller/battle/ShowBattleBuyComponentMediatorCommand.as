package controller.battle
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.battle.BattleBuyComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *购买要塞
     * @author lw
     *
     */
    public class ShowBattleBuyComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
        public function ShowBattleBuyComponentMediatorCommand()
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
			
            var med:BattleBuyComponentMediator = getMediator(BattleBuyComponentMediator);
            if (med)
            {
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("battle.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:BattleBuyComponentMediator = new BattleBuyComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			
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