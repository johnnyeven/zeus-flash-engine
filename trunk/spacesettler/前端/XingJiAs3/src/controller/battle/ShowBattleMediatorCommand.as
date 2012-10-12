package controller.battle
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.SenceTypeEnum;
    
    import mediator.BaseMediator;
    import mediator.battle.BattleMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import view.battle.BattleComponent;
    
    import vo.GlobalData;

    /**
     *显示界面命令
     * @author zn
     *
     */
    public class ShowBattleMediatorCommand extends SimpleCommand
    {
        private static var _isLoading:Boolean = false;

        public function ShowBattleMediatorCommand()
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
            if (_isLoading)
                return;

            var med:BattleMediator = getMediator(BattleMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF
                _isLoading = true;
                ResLoader.load("battleMap_1.swf", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:BattleMediator = new BattleMediator(new BattleComponent(ClassUtil.getObject("battle.battleMap_1")));

            //注册界面的中介
            facade.registerMediator(med);
            med.show();

			GlobalData.currentSence=SenceTypeEnum.BATTLE;
			
            _isLoading = false;
        }
    }
}
