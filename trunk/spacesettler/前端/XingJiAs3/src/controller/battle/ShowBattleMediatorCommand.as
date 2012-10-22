package controller.battle
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.loading.LoaderMax;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.LoaderItemUtil;
    
    import enum.SenceTypeEnum;
    
    import mediator.BaseMediator;
    import mediator.battle.BattleFightMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import view.battle.fight.BattleFightComponent;
    
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

            var med:BattleFightMediator = getMediator(BattleFightMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF
                _isLoading = true;
				var loaderMax:LoaderMax=new LoaderMax("fightBattle");
				loaderMax.addChildLoad(LoaderItemUtil.getLoader("battle"));
				loaderMax.addChildLoad(LoaderItemUtil.getLoader("zhanChe_1.swf"));
                ResLoader.load("fightBattle", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:BattleFightMediator = new BattleFightMediator(new BattleFightComponent(ClassUtil.getObject("battle.battleMap_1")));

            //注册界面的中介
            facade.registerMediator(med);
            med.show();

			GlobalData.currentSence=SenceTypeEnum.FIGHT_BATTLE;
			
            _isLoading = false;
        }
    }
}
