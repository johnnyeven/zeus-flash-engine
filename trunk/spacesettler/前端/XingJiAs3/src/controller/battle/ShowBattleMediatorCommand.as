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

		private var mapID:int;
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

			mapID = int(notification.getBody());
			//TODU LW:自己设置数据（恢复）
			if(mapID == 0)
			{
				mapID = 1;
			}
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
				loaderMax.addChildLoad(LoaderItemUtil.getLoader("battleZhanChe"));
				loaderMax.addChildLoad(LoaderItemUtil.getLoader("battleMap_"+ mapID+ ".swf"));
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
            var med:BattleFightMediator = new BattleFightMediator(new BattleFightComponent(ClassUtil.getObject("battle.battleMap_"+mapID)));

            //注册界面的中介s
            facade.registerMediator(med);
            med.show();

			GlobalData.currentSence=SenceTypeEnum.FIGHT_BATTLE;
			
            _isLoading = false;
        }
    }
}
