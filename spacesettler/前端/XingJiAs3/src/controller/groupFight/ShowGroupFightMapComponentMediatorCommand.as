package controller.groupFight
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.groupFight.GroupFightMapComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowGroupFightMapComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
        public function ShowGroupFightMapComponentMediatorCommand()
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
			
            var med:GroupFightMapComponentMediator = getMediator(GroupFightMapComponentMediator);
            if (med)
            {
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("groupFight.swf", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:GroupFightMapComponentMediator = new GroupFightMapComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			
			_isLoading=false;
			callShow(med);
        }
		
		private function callShow(med:GroupFightMapComponentMediator):void
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