package controller.group
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.group.GroupMemberComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowGroupMemberComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		//显示层级
		private var mediatorLevel:int = 2;
		//是否是从邮件中选择的军团成员列表
		private var isSendEmailGroup:Boolean = false;
        public function ShowGroupMemberComponentMediatorCommand()
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
				if(notification.getBody().mediatorLevel)
				{
					mediatorLevel = notification.getBody().mediatorLevel +1;
				}
				
				if(notification.getBody().isSendEmailGroup)
				{
					isSendEmailGroup = notification.getBody().isSendEmailGroup;
				}
			}
			
            var med:GroupMemberComponentMediator = getMediator(GroupMemberComponentMediator);
            if (med)
            {
				med.setMediatorLevel(mediatorLevel);
				med.setIsSendEmailGroup(isSendEmailGroup);
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("armyGroup.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:GroupMemberComponentMediator = new GroupMemberComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.setMediatorLevel(mediatorLevel);
			med.setIsSendEmailGroup(isSendEmailGroup);
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