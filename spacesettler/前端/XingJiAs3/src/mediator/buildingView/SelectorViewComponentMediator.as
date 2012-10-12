package mediator.buildingView
{
    import com.zn.utils.ClassUtil;
    
    import enum.BuildTypeEnum;
    
    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;
    import events.buildingView.UpLevelEvent;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.buildingView.YeLianChangUpComponentMediator;
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    import mediator.crystalSmelter.CrystalSmelterFunctionComponentMediator;
    import mediator.scienceResearch.ScienceResearchComponentMediator;
    import mediator.timeMachine.TimeMachineComponentMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.allView.AllViewProxy;
    import proxy.timeMachine.TimeMachineProxy;
    import proxy.userInfo.UserInfoProxy;
    
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
		
		private var _arr:Array=[];
		
		private var allViewProxy:AllViewProxy;
		
		private var userInforProxy:UserInfoProxy;

        public function SelectorViewComponentMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
			
			allViewProxy = getProxy(AllViewProxy);
			userInforProxy = getProxy(UserInfoProxy);
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
					_arr.push(viewComp);
					
                    viewComp.buildType = event.buildType;

                    viewComp.x = event.point.x;
                    viewComp.y = event.point.y;
					
                    viewComp.addEventListener(AddViewEvent.ADDUPVIEW_EVENT, addUpViewHandler);
                    viewComp.addEventListener(AddViewEvent.ADDINFOVIEW_EVENT, addInfoViewHandler);
					viewComp.addEventListener(AddViewEvent.ADDOTHERVIEW_EVENT,addOtherViewHandler);
					viewComp.addEventListener(AddViewEvent.LEFT_EVEMT,addLeftViewHAndler);

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
			for(var i:int;i<_arr.length;i++)
			{
				var comp:SelectorViewComponent=_arr[i];
				comp.closeTweenLiteCompleteCallBack=function():void
				{
					comp.dispose();
					comp=null
				}
				comp.endClose();
			}
			_arr.length=0;
			
			/*if (viewComp != null)
			{
				viewComp.closeTweenLiteCompleteCallBack=function():void
				{					
					viewComp.dispose();
					viewComp=null;
				}
				viewComp.endClose();
			}*/
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
				case BuildTypeEnum.SHIJINMAC:
				{
					sendNotification(TimeMachineComponentMediator.SHOW_NOTE);
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
                    sendNotification(YeLianInfoComponentMediator.SHOW_NOTE);
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
		
		protected function addOtherViewHandler(event:AddViewEvent):void
		{
			switch(event.buildType)
			{
				case BuildTypeEnum.CANGKU:
				{
					sendNotification(CangkuPackageViewComponentMediator.SHOW_NOTE);
					break;
				}
			    case BuildTypeEnum.CENTER:
				{
					sendNotification(RongYuComponentMediator.SHOW_NOTE);
					break;
				}
				case BuildTypeEnum.KUANGCHANG:
				{
					sendNotification(CrystalSmelterFunctionComponentMediator.SHOW_NOTE);
					break;
				}
				case BuildTypeEnum.KEJI:
				{
					sendNotification(ScienceResearchComponentMediator.SHOW_NOTE);
					break;
				}
			}
		}
		
		private function addLeftViewHAndler(event:AddViewEvent):void
		{
			switch(event.buildType)
			{
				case BuildTypeEnum.CENTER:
				{
					sendNotification(AllViewComponentMediator.SHOW_NOTE);
					break;
				}
			}
		}
    }
}
