package mediator.buildingView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	import events.buildingView.ConditionEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.buildingView.ChuanQingUpComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	/**
	 *氚氢厂升级
	 * @author zn
	 * 
	 */
	public class ChuanQinUpComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChuanQinUpComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function ChuanQinUpComponentMediator()
		{
			super(NAME, new ChuanQingUpComponent(ClassUtil.getObject(formatStr("up_chuanQingChang_view_{0}"))));
			comp.med=this;
			level=1;
			comp.buildType=BuildTypeEnum.CHUANQIN;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(BuildEvent.UP_EVENT, upHandler);
			comp.addEventListener(BuildEvent.SPEED_EVENT, speedHandler);
			comp.addEventListener(BuildEvent.INFO_EVENT, infoHandler);
			
			comp.addEventListener(ConditionEvent.ADDCONDITIONVIEW_EVENT,addConditionViewHandler);
		}
		
		private function formatStr(str:String):String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			return StringUtil.formatString(str, userInfoVO.camp);
		}
		
		protected function closeHandler(event:AddViewEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
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
		protected function get comp():ChuanQingUpComponent
		{
			return viewComponent as ChuanQingUpComponent;
		}
		
		protected function upHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			buildProxy.upBuild(BuildTypeEnum.CHUANQIN, function():void
			{
				comp.buildType = BuildTypeEnum.CHUANQIN;
			});
		}
		
		protected function speedHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			var buildVO:BuildInfoVo = buildProxy.getBuild(BuildTypeEnum.CHUANQIN);
			if(buildVO.level<40)
			{
				sendNotification(MoneyAlertComponentMediator.SHOW_NOTE, { info: MultilanguageManager.getString("speedTimeInfo"),
					count: buildVO.speedCount, okCallBack: function():void
					{
						buildProxy.speedUpBuild(BuildTypeEnum.CHUANQIN);
					}});
			}
		}
		
		protected function infoHandler(event:Event):void
		{
//			destoryCallback = function():void
//			{
				sendNotification(ChuanQinInfoComponentMediator.SHOW_NOTE);
//			};
//			sendNotification(DESTROY_NOTE);
		}
		
		protected function addConditionViewHandler(event:ConditionEvent):void
		{
			sendNotification(ConditionViewCompMediator.SHOW_NOTE,event.conditionArr);
		}
	}
}