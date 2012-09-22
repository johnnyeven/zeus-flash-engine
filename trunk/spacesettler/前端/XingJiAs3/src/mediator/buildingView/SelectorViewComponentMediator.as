package mediator.buildingView
{
    import com.zn.utils.ClassUtil;

    import enum.BuildTypeEnum;

    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;
    import events.buildingView.UpLevelEvent;

    import flash.events.Event;

    import mediator.BaseMediator;
    import mediator.buildingView.YeLianChangUpComponentMediator;

    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;

    import ui.managers.PopUpManager;

    import view.buildingView.SelectorViewComponent;

    /**
     *建筑功能选择
     * @author zn
     *
     */
    public class SelectorViewComponentMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "SelectorViewComponentMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public var viewComp:SelectorViewComponent;

        public function SelectorViewComponentMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
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
                case SHOW_NOTE:
                {
//					destroy();

                    var event:AddSelectorViewEvent = note.getBody() as AddSelectorViewEvent;

                    viewComp = new SelectorViewComponent(event);
                    viewComp.buildType = event.buildType;

                    viewComp.x = event.point.x;
                    viewComp.y = event.point.y;
					
                    viewComp.addEventListener(AddViewEvent.ADDUPVIEW_EVENT, addUpViewHandler);
                    viewComp.addEventListener(AddViewEvent.ADDINFOVIEW_EVENT, addInfoViewHandler);

                    PopUpManager.addPopUp(viewComp);

                    viewComp.start();
                    break;
                }
                case DESTROY_NOTE:
                {
                    //销毁对象
                    destroy();
                    break;
                }
            }
        }

		public override function destroy():void
		{
			if (viewComp != null)
			{
				viewComp.dispose();
				viewComp = null;
			}
		}
        protected function addUpViewHandler(event:AddViewEvent):void
        {
            switch (event.buildType)
            {
                case BuildTypeEnum.CENTER:
                {
                    sendNotification(CenterUpComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.DIANCHANG:
                {
                    sendNotification(DianChangUpComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.CHUANQIN:
                {
                    sendNotification(ChuanQinUpComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.KEJI:
                {
                    sendNotification(KeJiUpComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.CANGKU:
                {
                    sendNotification(CangKuUpComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.KUANGCHANG:
                {
                    sendNotification(YeLianChangUpComponentMediator.SHOW_NOTE);
                    break;
                }
            }
			sendNotification(DESTROY_NOTE);
        }

        protected function addInfoViewHandler(event:AddViewEvent):void
        {
            switch (event.buildType)
            {
                case BuildTypeEnum.CENTER:
                {
                    sendNotification(CenterInfoComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.DIANCHANG:
                {
                    sendNotification(DianChangInfoComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.CHUANQIN:
                {
                    sendNotification(ChuanQinInfoComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.KEJI:
                {
                    sendNotification(KeJiInfoComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.CANGKU:
                {
                    sendNotification(CangKuInfoComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.KUANGCHANG:
                {
                    sendNotification(YeLianChangUpComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.JUNGONGCHANG:
                {
                    sendNotification(JunGongInfoComponentMediator.SHOW_NOTE);
                    break;
                }
                case BuildTypeEnum.SHIJINMAC:
                {
                    sendNotification(ShiJianInfoComponentMediator.SHOW_NOTE);
                    break;
                }
            }
			sendNotification(DESTROY_NOTE);
        }
    }
}
