package mediator.buildingView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	
	import ui.managers.PopUpManager;
	
	import view.buildingView.CenterUpComponent;
	
	import vo.BuildInfoVo;
	
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
		
		public function CenterUpComponentMediator()
		{
			super(NAME, new CenterUpComponent(ClassUtil.getObject("up_center_view")));
			comp.upType=BuildTypeEnum.CENTER;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(BuildEvent.UP_EVENT, upHandler);
			comp.addEventListener(BuildEvent.SPEED_EVENT, speedHandler);
			comp.addEventListener(BuildEvent.INFO_EVENT, infoHandler);
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
		protected function get comp():CenterUpComponent
		{
			return viewComponent as CenterUpComponent;
		}
		
		protected function upHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			buildProxy.upBuild(BuildTypeEnum.CENTER, function():void
			{
				comp.upType = BuildTypeEnum.CENTER;
			});
		}
		
		protected function speedHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			var buildVO:BuildInfoVo = buildProxy.getBuild(BuildTypeEnum.CENTER);
			
			sendNotification(MoneyAlertComponentMediator.SHOW_NOTE, { info: MultilanguageManager.getString("speedTimeInfo"),
				count: buildVO.speedCount, okCallBack: function():void
				{
					buildProxy.speedUpBuild(BuildTypeEnum.CENTER);
				}});
		}
		
		protected function infoHandler(event:Event):void
		{
			destoryCallback = function():void
			{
				sendNotification(CenterInfoComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
	}
}