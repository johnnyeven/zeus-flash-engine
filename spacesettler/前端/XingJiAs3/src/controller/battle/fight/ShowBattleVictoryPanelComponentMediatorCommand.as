package controller.battle.fight
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.SoundUtil;
    
    import enum.SoundEnum;
    
    import mediator.BaseMediator;
    import mediator.battle.BattleVictoryPanelComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import view.battle.fightView.BattleVictoryPanelComponent;
    
    import vo.battle.fight.FightVictoryRewardVO;

	/**
	 * 战斗胜利
	 * @author lw
	 */
    public class ShowBattleVictoryPanelComponentMediatorCommand extends SimpleCommand
    {
		private static var _isLoading:Boolean=false;
		
		public static var loadCompleteCallBack:Function;
		private var victoryVO:FightVictoryRewardVO;
        public function ShowBattleVictoryPanelComponentMediatorCommand()
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
			victoryVO = notification.getBody() as FightVictoryRewardVO;
            var med:BattleVictoryPanelComponentMediator = getMediator(BattleVictoryPanelComponentMediator);
            if (med)
            {
				med.setVictoryData(victoryVO);
				callShow(med);
            }
            else
            {
                //加载界面SWF
				_isLoading=true;
                ResLoader.load("battle.swf", MultilanguageManager.getString(""), loaderComplete, true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:BattleVictoryPanelComponentMediator = new BattleVictoryPanelComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.setVictoryData(victoryVO);
			_isLoading=false;
			callShow(med);
        }
		
		private function callShow(med:BattleVictoryPanelComponentMediator):void
		{
			SoundUtil.play(SoundEnum.pve_victory,false,false);
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