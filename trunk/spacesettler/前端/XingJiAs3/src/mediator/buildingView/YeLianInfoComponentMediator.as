package mediator.buildingView
{
    import com.zn.utils.ClassUtil;

    import enum.BuildTypeEnum;

    import events.buildingView.BuildEvent;

    import flash.events.Event;

    import mediator.BaseMediator;

    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;

    import proxy.BuildProxy;

    import view.buildingView.InfoViewComponent;

    import vo.BuildInfoVo;

    /**
     *冶炼厂信息
     * @author zn
     *
     */
    public class YeLianInfoComponentMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "YeLianInfoComponentMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public function YeLianInfoComponentMediator(viewComponent:Object = null)
        {
            super(NAME, new InfoViewComponent(ClassUtil.getObject("info_yeLianChang_view")));
            comp.addEventListener(BuildEvent.BACK_EVENT, backHandler);
        }

        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ DESTROY_NOTE ];
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
            }
        }

        /**
         *获取界面
         * @return
         *
         */
        protected function get comp():InfoViewComponent
        {
            return viewComponent as InfoViewComponent;
        }

        protected function backHandler(event:Event):void
        {
            destoryCallback = function():void
            {
                var buildVO:BuildInfoVo = BuildProxy(getProxy(BuildProxy)).getBuild(BuildTypeEnum.KUANGCHANG);
				trace(buildVO.level);
                if (buildVO && buildVO.level>0)
                    sendNotification(YeLianChangUpComponentMediator.SHOW_NOTE);
                else
                    sendNotification(YeLianCreateComponentMediator.SHOW_NOTE);
            };
            sendNotification(DESTROY_NOTE);
        }
    }
}
