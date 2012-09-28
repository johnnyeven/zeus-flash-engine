package mediator.buildingView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.buildingView.CreateViewComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	/**
	 *科技建造
	 * @author zn
	 * 
	 */
	public class KeJiCreateComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="KeJiCreateComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function KeJiCreateComponentMediator()
		{
			super(NAME,new CreateViewComponent(ClassUtil.getObject(formatStr("build_keJi_view_{0}"))));
			comp.med=this;
			level=1;
			comp.buildType=BuildTypeEnum.KEJI;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT, closeHandler);
			comp.addEventListener(BuildEvent.BUILD_EVENT, buildHandler);
			comp.addEventListener(BuildEvent.SPEED_EVENT, speedHandler);
			comp.addEventListener(BuildEvent.INFO_EVENT, infoHandler);
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
		protected function get comp():CreateViewComponent
		{
			return viewComponent as CreateViewComponent;
		}
		
		protected function closeHandler(event:Event=null):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function buildHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			buildProxy.buildBuild(BuildTypeEnum.KEJI, function():void
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
	}
}