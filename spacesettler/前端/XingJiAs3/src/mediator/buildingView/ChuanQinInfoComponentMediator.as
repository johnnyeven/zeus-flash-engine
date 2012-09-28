package mediator.buildingView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.BuildEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.buildingView.InfoViewComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	/**
	 *氚氢厂信息 
	 * @author zn
	 * 
	 */
	public class ChuanQinInfoComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChuanQinInfoComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function ChuanQinInfoComponentMediator()
		{
			super(NAME, new InfoViewComponent(ClassUtil.getObject(formatStr("info_chuanQingChang_view_{0}"))));
			comp.med=this;
			level=2;
			comp.addEventListener(BuildEvent.BACK_EVENT, backHandler);
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
		protected function get comp():InfoViewComponent
		{
			return viewComponent as InfoViewComponent;
		}
		
		protected function backHandler(event:Event):void
		{
			/*destoryCallback = function():void
			{
				var buildVO:BuildInfoVo = BuildProxy(getProxy(BuildProxy)).getBuild(BuildTypeEnum.CHUANQIN);
				if (buildVO && buildVO.level>0)
					sendNotification(ChuanQinUpComponentMediator.SHOW_NOTE);
				else
					sendNotification(ChuanQinCreateComponentMediator.SHOW_NOTE);
			};*/
			sendNotification(DESTROY_NOTE);
		}
	}
}