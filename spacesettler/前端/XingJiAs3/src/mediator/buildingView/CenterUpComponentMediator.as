package mediator.buildingView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	import enum.SenceTypeEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	import events.buildingView.ConditionEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	import mediator.scienceResearch.ScienceResearchComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	import proxy.allView.AllViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.managers.PopUpManager;
	
	import view.buildingView.CenterUpComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	/**
	 *基地中心升级
	 * @author zn
	 * 
	 */
	public class CenterUpComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="CenterUpComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public var CenterUpViewComp:CenterUpComponent;
		
		private var _keJiBuild:BuildInfoVo;
		public function CenterUpComponentMediator()
		{
			super(NAME, new CenterUpComponent(ClassUtil.getObject(formatStr("up_center_view_{0}"))));
			comp.med=this;
			level=1;			
			
			_keJiBuild=BuildProxy(ApplicationFacade.getProxy(BuildProxy)).getBuild(BuildTypeEnum.KEJI);
			
			comp.buildType=BuildTypeEnum.CENTER;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(BuildEvent.UP_EVENT, upHandler);
			comp.addEventListener(BuildEvent.SPEED_EVENT, speedHandler);
			comp.addEventListener(BuildEvent.INFO_EVENT, infoHandler);
			comp.addEventListener(AddViewEvent.ADDKEJICREATEVIEW_EVENT,enterKeJiViewHandler);
			comp.addEventListener(ConditionEvent.ADDCONDITIONVIEW_EVENT,addConditionViewHandler);
		}
		
		protected function closeHandler(event:AddViewEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		private function formatStr(str:String):String
		{		
			var userInfoVO:UserInfoVO= UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			return StringUtil.formatString(str, userInfoVO.camp);			
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
		protected function get comp():CenterUpComponent
		{
			return viewComponent as CenterUpComponent;
		}
		
		protected function upHandler(event:Event):void
		{
			
			if(_keJiBuild)
			{
				var buildProxy:BuildProxy = getProxy(BuildProxy);
				buildProxy.upBuild(BuildTypeEnum.CENTER, function():void
				{
					comp.buildType = BuildTypeEnum.CENTER;
				});
			}
			else
			{
				sendNotification(KeJiCreateComponentMediator.SHOW_NOTE);
			}
		}
		
		protected function speedHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			var buildVO:BuildInfoVo = buildProxy.getBuild(BuildTypeEnum.CENTER);
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			if(userInfoVO.level<4)
			{
				sendNotification(MoneyAlertComponentMediator.SHOW_NOTE, { info: MultilanguageManager.getString("speedTimeInfo"),
				count: buildVO.speedCount, okCallBack: function():void
				{
					buildProxy.speedUpBuild(BuildTypeEnum.CENTER);
				}});
			}
			
		}
		
		protected function infoHandler(event:Event):void
		{
//			destoryCallback = function():void
//			{
				sendNotification(CenterInfoComponentMediator.SHOW_NOTE);
//			};
//			sendNotification(DESTROY_NOTE);
		}
		
		protected function enterKeJiViewHandler(event:AddViewEvent):void
		{
			sendNotification(ScienceResearchComponentMediator.SHOW_NOTE);
		}
		
		protected function addConditionViewHandler(event:ConditionEvent):void
		{
//			if(_keJiBuild)
//			{
				sendNotification(ConditionViewCompMediator.SHOW_NOTE,event.conditionArr);
//			}
//			else
//			{
//				sendNotification(KeJiCreateComponentMediator.SHOW_NOTE);
//			}
		}
	}
}