package mediator.prompt
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import flash.display.MovieClip;
    import flash.system.System;
    
    import mediator.MainMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    import proxy.errorProxy.ErrorProxy;
    
    import ui.components.Alert;
    import ui.components.Label;
    import ui.managers.PopUpManager;
    import ui.managers.SystemManager;
    import ui.utils.UIUtil;
    
    import view.prompt.PromptInfoComponent;

    /**
     *提示
     * @author zn
     *
     */
    public class PromptMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "PromptMediator";

        public static const SHOW_ALERT_NOTE:String = "showAlertNote";

        public static const SCROLL_ALERT_NOTE:String = "scrollAlertNote";

        public static const SHOW_ERROR_NOTE:String = "showErrorNote";

		public static const SHOW_LOADWAITMC_NOTE:String="SHOW_LOADWAITMC_NOTE";// by rl
		
		public static const HIDE_LOADWAITMC_NOTE:String="HIDE_LOADWAITMC_NOTE";// by rl
		
		private var _loadWaitMC:MovieClip;// by rl

        public function PromptMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
			_loadWaitMC=ClassUtil.getObject("res.loaderServerData");// by rl
			
        }

        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ SHOW_ALERT_NOTE, SCROLL_ALERT_NOTE, SHOW_ERROR_NOTE, SHOW_LOADWAITMC_NOTE, HIDE_LOADWAITMC_NOTE ];// by rl
        }

        /**
         *消息处理
         * @param note
         *
         */
        override public function handleNotification(note:INotification):void
        {
            switch (note.getName())
            {
                case SHOW_ALERT_NOTE:
                {
                    showAlert(String(note.getBody()));
                    break;
                }
                case SCROLL_ALERT_NOTE:
                {
                    scrollAlert(String(note.getBody()));
                    break;
                }
                case SHOW_ERROR_NOTE:
                {
                    showErrorInfo(int(note.getBody()));
                    break;
                }
				case SHOW_LOADWAITMC_NOTE:// by rl
				{
					showLoadWaitMc();
					break;
				}
				case HIDE_LOADWAITMC_NOTE:// by rl
				{
					hideLoadWaitMc();
					break;
				}
            }
        }

        private function showAlert(note:String):void
        {
            Alert.show(note, MultilanguageManager.getString("tips"), null, true, Alert.OK_BUTTON);
        }

        private function scrollAlert(note:String):void
        {
            var label:Label = new Label();
            label.autoSize = true;
            label.text = note;

            label.x = SystemManager.rootStage.stageWidth * 0.5 - label.width * 0.5;
            label.y = 200;

            SystemManager.instance.addInfo(label);
            TweenLite.to(label, 1.5, { y: 70, alpha: 0.5, ease: Linear.easeNone, onComplete: function():void
            {
                label.dispose();
            }});
        }

        /**
         *显示错误消息
         * @param param0
         *
         */
        private function showErrorInfo(errorID:int):void
        {
            var errorProxy:ErrorProxy = getProxy(ErrorProxy);
            scrollAlert(errorProxy.getErrorInfoByID(errorID));
        }

        /**
         *显示信息
         * @param param0
         *
         */		
		private function showLoadWaitMc():void
		{
			MainMediator(getMediator(MainMediator)).component.addInfo(_loadWaitMC);
			UIUtil.centerUI(_loadWaitMC);
		}
		
		private function hideLoadWaitMc():void
		{
			MainMediator(getMediator(MainMediator)).component.removeInfo(_loadWaitMC);
		}
    }
}
