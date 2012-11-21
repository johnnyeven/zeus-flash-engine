package mediator.prompt
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.FontEnum;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import mediator.MainMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    import proxy.errorProxy.ErrorProxy;
    
    import ui.components.Alert;
    import ui.components.Label;
    import ui.core.Component;
    import ui.managers.PopUpManager;
    import ui.managers.SystemManager;
    import ui.utils.UIUtil;
    
    import view.prompt.PromptInfoComponent;
    import view.prompt.PromptSureComponent;

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

        public static const SHOW_LOADWAITMC_NOTE:String = "SHOW_LOADWAITMC_NOTE"; // by rl

        public static const HIDE_LOADWAITMC_NOTE:String = "HIDE_LOADWAITMC_NOTE"; // by rl

        public static const SHOW_INFO_NOTE:String = "SHOW_INFO_NOTE";

        public static const HIDE_INFO_NOTE:String = "HIDE_INFO_NOTE";

        public static const SHOW_LOGIN_INFO_NOTE:String = "SHOW_LOGIN_INFO_NOTE";

        public static const HIDE_LOGIN_INFO_NOTE:String = "HIDE_LOGIN_INFO_NOTE";

        private var _infoComp:PromptInfoComponent;
		
		private var _sureInfoComp:PromptSureComponent;

        private var _loadWaitMC:MovieClip; // by rl

        private var _loginInfoLabel:Label;

        private var _loginInfoComp:Component;

        public function PromptMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
            _infoComp = new PromptInfoComponent();
			_infoComp.addEventListener(Event.CLOSE,hideInfo);
			
			_sureInfoComp=new PromptSureComponent(ClassUtil.getObject("res.Prompt_2_InfoSkin"));
			_sureInfoComp.okButton.addEventListener(MouseEvent.CLICK,clickHandler);
			_sureInfoComp.noButton.addEventListener(MouseEvent.CLICK,clickHandler);
			
            _loadWaitMC = ClassUtil.getObject("res.loaderServerData"); // by rl

            _loginInfoComp = new Component(ClassUtil.getObject("res.LoginInfoSkin"));
            _loginInfoLabel = _loginInfoComp.createUI(Label, "label");
            var centerP:Point = UIUtil.stageCenterPoint(_loginInfoComp);
			_loginInfoComp.x = centerP.x;
			_loginInfoComp.y = 470;
        }

        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ SHOW_ALERT_NOTE, SCROLL_ALERT_NOTE, SHOW_ERROR_NOTE, SHOW_LOADWAITMC_NOTE, HIDE_LOADWAITMC_NOTE,
                     SHOW_INFO_NOTE, HIDE_INFO_NOTE,
                     SHOW_LOGIN_INFO_NOTE, HIDE_LOGIN_INFO_NOTE ]; // by rl
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
                case SHOW_LOADWAITMC_NOTE: // by rl
                {
                    showLoadWaitMc();
                    break;
                }
                case HIDE_LOADWAITMC_NOTE: // by rl
                {
                    hideLoadWaitMc();
                    break;
                }
                case SHOW_INFO_NOTE:
                {
                    showInfo(String(note.getBody()));
                    break;
                }
                case HIDE_INFO_NOTE:
                {
                    hideInfo();
                    break;
                }
                case SHOW_LOGIN_INFO_NOTE:
                {
                    _loginInfoLabel.text = String(note.getBody());
                    MainMediator(getMediator(MainMediator)).component.addInfo(_loginInfoComp);
                    break;
                }
                case HIDE_LOGIN_INFO_NOTE:
                {
                    MainMediator(getMediator(MainMediator)).component.removeInfo(_loginInfoComp);
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
			label.color=0xffcc33;
			label.fontName=FontEnum.WEI_RUAN_YA_HEI;
			label.size=30;

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

        /**
         *显示信息
         * @param param0
         *
         */
        private function showInfo(infoFiled:String):void
        {
//            var str:String = infoFiled;
//            _infoComp.text = str;
			var content:String=infoFiled;
			_sureInfoComp.tital="提示";
			_sureInfoComp.content=content;

//			PopUpManager.addPopUp(_infoComp,true);
//            UIUtil.centerUI(_infoComp);
			PopUpManager.addPopUp(_sureInfoComp,true);
            UIUtil.centerUI(_sureInfoComp);
        }

        private function hideInfo(event:*=null):void
        {
//			PopUpManager.removePopUp(_infoComp);
			PopUpManager.removePopUp(_sureInfoComp);
        }
		
		private function clickHandler(event:MouseEvent):void
		{
			hideInfo();
		}
    }
}
