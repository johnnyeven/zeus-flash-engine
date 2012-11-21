package mediator.cangKu
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.item.ItemEnum;
	
	import events.cangKu.DonateEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.packageView.PackageViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.cangKu.Donateview_1Component;

	public class Donateview_1ComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="Donateview_1ComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		
		private var packageProxy:PackageViewProxy;
		private var userProxy:UserInfoProxy;
		public function Donateview_1ComponentMediator()
		{
			super(NAME, new Donateview_1Component());
			
			packageProxy=getProxy(PackageViewProxy);
			userProxy=getProxy(UserInfoProxy);
			
			comp.med=this;
			popUpEffect=CENTER;
			level=2;
			
			comp.addEventListener(DonateEvent.CLOSE_EVENT,colseHandler);
			comp.addEventListener(DonateEvent.DONATE_EVENT,donateHandler);
		}
		
		protected function donateHandler(event:DonateEvent):void
		{
			packageProxy.groupDonate(userProxy.userInfoVO.legion_id,ItemEnum.BROKENCRYSTAL_TYPE,null,event.num,function():void
			{
				var obj1:Object={};
				obj1.infoLable=MultilanguageManager.getString("juanxian");
				obj1.showLable=MultilanguageManager.getString("juanxianchenggong");
				sendNotification(PromptSureMediator.SHOW_NOTE,obj1);
			});
		}
		
		protected function colseHandler(event:DonateEvent):void
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
		protected function get comp():Donateview_1Component
		{
			return viewComponent as Donateview_1Component;
		}

	}
}