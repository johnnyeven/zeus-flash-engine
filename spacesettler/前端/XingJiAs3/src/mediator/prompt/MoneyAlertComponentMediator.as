package mediator.prompt
{
    import enum.BuildTypeEnum;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.BuildProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.managers.PopUpManager;
    
    import view.prompt.MoneyAlertComponent;

    /**
     *RMB提示框
     * @author zn
     *
     */
    public class MoneyAlertComponentMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "MoneyAlertComponentMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public var okCallBack:Function;
		private var userProxy:UserInfoProxy;
        public function MoneyAlertComponentMediator()
        {
            super(NAME, new MoneyAlertComponent());
			userProxy=getProxy(UserInfoProxy);
			
            _popUp = true;
            mode = true;
			popUpEffect=CENTER;

			comp.med=this;
			level=3;
			
            comp.addEventListener(MoneyAlertComponent.OK_EVENT, okHandler);
            comp.addEventListener(MoneyAlertComponent.NO_EVENT, noHandler);
        }

        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ SHOW_NOTE, DESTROY_NOTE ];
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
                case DESTROY_NOTE:
                {
                    //销毁对象
                    destroy();
                    break;
                }
                case SHOW_NOTE:
                {
                    var obj:Object = note.getBody();
					if(obj.title)
						comp.titleLabel.text=obj.title;
                    comp.infoTF.text = obj.info;
                    comp.countTF.text = "x" + obj.count;
                    okCallBack = obj.okCallBack;
					if(userProxy.userInfoVO.vip_speed>0)
					{
						comp.numLable.text=String(userProxy.userInfoVO.vip_speed);
						comp.countTF.text = "x0";
						comp.vipMc.visible=true;
						comp.numLable.visible=true;
					}else
					{
						comp.vipMc.visible=false;
						comp.numLable.visible=false;
					}
                    show();
                    break;
                }
            }
        }

        /**
         *获取界面
         * @return
         *
         */
        public function get comp():MoneyAlertComponent
        {
            return viewComponent as MoneyAlertComponent;
        }
		
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}

        protected function noHandler(event:Event):void
        {
            sendNotification(DESTROY_NOTE);
        }

        protected function okHandler(event:Event):void
        {
            if (okCallBack != null)
                okCallBack();
            okCallBack = null;

            sendNotification(DESTROY_NOTE);
        }
    }
}
