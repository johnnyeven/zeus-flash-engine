package controller.friendList
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.friendList.FriendListComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.friendList.FriendProxy;

    /**
     *好友列表
     * @author lw
     *
     */
    public class ShowFriendListComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		//显示层级
		private var mediatorLevel:int;
		//是否是从邮件中选择的好友列表
		private var isSendEmail:Boolean = false;
        public function ShowFriendListComponentMediatorCommand()
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
			var playerID:String = notification.getBody().playerID;
			if(notification.getBody().isSendEmail)
			{
				isSendEmail = notification.getBody().isSendEmail;
			}
			if(notification.getBody().mediatorLevel)
			{
				mediatorLevel = notification.getBody().mediatorLevel +1;
			}
			
			var friendProxy:FriendProxy = getProxy(FriendProxy);
			friendProxy.getFriendList(playerID,function():void
			{
				 var med:FriendListComponentMediator = getMediator(FriendListComponentMediator);
	            if (med)
	            {
					med.setMediatorLevel(mediatorLevel);
					med.setIsSendEmail(isSendEmail);
					callShow(med);
	            }
	            else
	            {
	                //加载界面SWF
					_isLoading=true;
	                ResLoader.load("friendList.swf", MultilanguageManager.getString(""), loaderComplete,true);
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
            var med:FriendListComponentMediator = new FriendListComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.setMediatorLevel(mediatorLevel);
			med.setIsSendEmail(isSendEmail);
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