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
	import mediator.prompt.PromptSureMediator;
	import mediator.scienceResearch.ScienceResearchComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.buildingView.KeJiUpComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	/**
	 *科技中心升级
	 * @author zn
	 * 
	 */
	public class KeJiUpComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="KeJiUpComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function KeJiUpComponentMediator()
		{
			super(NAME, new KeJiUpComponent(ClassUtil.getObject(formatStr("up_keJi_view_{0}"))));
			comp.med=this;
			level=1;
			comp.buildType = BuildTypeEnum.KEJI;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT, closeHandler);
			comp.addEventListener(BuildEvent.UP_EVENT, upHandler);
			comp.addEventListener(BuildEvent.SPEED_EVENT, speedHandler);
			comp.addEventListener(BuildEvent.INFO_EVENT, infoHandler);
			
			comp.addEventListener(ConditionEvent.ADDCONDITIONVIEW_EVENT,addConditionViewHandler);
			comp.addEventListener(ConditionEvent.POWERPROMT_EVENT,powerPromtHandler);
			comp.addEventListener("keYanButton",keYanButtonHandler);
		}
		
		private function formatStr(str:String):String
		{
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
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
		protected function get comp():KeJiUpComponent
		{
			return viewComponent as KeJiUpComponent;
		}
		
		protected function closeHandler(event:AddViewEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function upHandler(event:Event=null):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			buildProxy.upBuild(BuildTypeEnum.KEJI, function():void
			{
				comp.buildType = BuildTypeEnum.KEJI;
			});
		}
		
		protected function speedHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			var buildVO:BuildInfoVo = buildProxy.getBuild(BuildTypeEnum.KEJI);
			if(buildVO.level<40)
			{
				sendNotification(MoneyAlertComponentMediator.SHOW_NOTE, { info: MultilanguageManager.getString("speedTimeInfo"),
					count: buildVO.speedCount, okCallBack: function():void
					{
						buildProxy.speedUpBuild(BuildTypeEnum.KEJI);
					}});
			}
		}
		
		protected function infoHandler(event:Event):void
		{
//			destoryCallback = function():void
//			{
				sendNotification(KeJiInfoComponentMediator.SHOW_NOTE);
//			};
//			sendNotification(DESTROY_NOTE);
		}
		
		private function keYanButtonHandler(event:Event):void
		{
			sendNotification(ScienceResearchComponentMediator.SHOW_NOTE);
		}
		
		protected function addConditionViewHandler(event:ConditionEvent):void
		{
			sendNotification(ConditionViewCompMediator.SHOW_NOTE,event.conditionArr);
		}
		
		protected function powerPromtHandler(event:Event):void
		{
			var obj:Object={};
			obj.infoLable=MultilanguageManager.getString("NOT_ENOUGH_POWER");
			obj.showLable=MultilanguageManager.getString("notEnoughInfo");
			obj.okCallBack=function ():void
			{
				upHandler();
			}
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
	}
}