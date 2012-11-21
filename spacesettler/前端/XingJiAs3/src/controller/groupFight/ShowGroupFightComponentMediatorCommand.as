package controller.groupFight
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.SoundUtil;
    
    import enum.SenceTypeEnum;
    import enum.SoundEnum;
    
    import mediator.BaseMediator;
    import mediator.groupFight.GroupFightComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import vo.GlobalData;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowGroupFightComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		
        public function ShowGroupFightComponentMediatorCommand()
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
			
            var med:mediator.groupFight.GroupFightComponentMediator = getMediator(GroupFightComponentMediator);
            if (med)
            {
				SoundUtil.stopAll();
				SoundUtil.play(SoundEnum.group_bg_music,true);
				
				med.show();
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("groupFight.swf", MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:GroupFightComponentMediator = new GroupFightComponentMediator();

			SoundUtil.stopAll();
			SoundUtil.play(SoundEnum.group_bg_music,true);
            //注册界面的中介
            facade.registerMediator(med);
			med.show();
			
			GlobalData.currentSence=SenceTypeEnum.GROUP_FIGHT;
			
			_isLoading=false;
			
        }
		
		
    }
}