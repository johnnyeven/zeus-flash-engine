package controller.task
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.task.TaskViewComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import vo.task.TaskInfoVO;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowtaskViewComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
		private var _taskVo:TaskInfoVO;
        public function ShowtaskViewComponentMediatorCommand()
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
			_taskVo=notification.getBody() as TaskInfoVO;
            var med:TaskViewComponentMediator = getMediator(TaskViewComponentMediator);
            if (med)
            {
				callShow(med);
            }
            else
            {
				loaderComplete(null);
//                //加载界面SWF
//				_isLoading=true;
//                ResLoader.load("zh_CN/res.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:TaskViewComponentMediator = new TaskViewComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.upData(_taskVo);
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