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
	
	import view.buildingView.CangKuUpComponent;
	
	import vo.BuildInfoVo;
	
	/**
	 *物资仓库升级
	 * @author zn
	 * 
	 */
	public class CangKuUpComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="CangKuUpComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function CangKuUpComponentMediator()
		{
			super(NAME, new CangKuUpComponent(ClassUtil.getObject("up_cangKu_view")));
			comp.upType=BuildTypeEnum.CANGKU;
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
		protected function get comp():CangKuUpComponent
		{
			return viewComponent as CangKuUpComponent;
		}
		
		protected function upHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			buildProxy.upBuild(BuildTypeEnum.CANGKU, function():void
			{
				comp.upType = BuildTypeEnum.CANGKU;
			});
		}
		
		protected function speedHandler(event:Event):void
		{
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			var buildVO:BuildInfoVo = buildProxy.getBuild(BuildTypeEnum.KUANGCHANG);
			
			sendNotification(MoneyAlertComponentMediator.SHOW_NOTE, { info: MultilanguageManager.getString("speedTimeInfo"),
				count: buildVO.speedCount, okCallBack: function():void
				{
					buildProxy.speedUpBuild(BuildTypeEnum.CANGKU);
				}});
		}
		
		protected function infoHandler(event:Event):void
		{
			destoryCallback = function():void
			{
				sendNotification(CangKuInfoComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
	}
}