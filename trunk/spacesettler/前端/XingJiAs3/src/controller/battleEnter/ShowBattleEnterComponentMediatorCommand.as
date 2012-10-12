package controller.battleEnter
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;

    import mediator.BaseMediator;
    import mediator.battleEnter.BattleEnterComponentMediator;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    import proxy.battle.BattleProxy;

    /**
     *飞船入口
     * @author zn
     *
     */
    public class ShowBattleEnterComponentMediatorCommand extends SimpleCommand
    {
        private static var _isLoading:Boolean = false;

        public static var loadCompleteCallBack:Function;

        public function ShowBattleEnterComponentMediatorCommand()
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

            _isLoading = true;

            var battleProxy:BattleProxy = getProxy(BattleProxy);
            battleProxy.getAllZhanCheList(function():void
            {
                var med:BattleEnterComponentMediator = getMediator(BattleEnterComponentMediator);
                if (med)
                {
                    callShow(med);
                }
                else
                {
                    //加载界面SWF
                    ResLoader.load("battleEnter.swf", MultilanguageManager.getString(""), loaderComplete, true);
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
            var med:BattleEnterComponentMediator = new BattleEnterComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);

            _isLoading = false;

            callShow(med);
        }

        private function callShow(med:BaseMediator):void
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
