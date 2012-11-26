 package mediator.login
{
	
	import com.zn.utils.ClassUtil;
	import com.zn.utils.SoundUtil;
	
	import enum.RecordEnum;
	import enum.TaskEnum;
	
	import events.login.StartLoginEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.MainMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.login.LoginProxy;
	
	import ui.components.Window;
	
	import utils.GlobalUtil;
	
	import view.login.StartComponent;

	/**
	 *开始
	 * @author lw
	 *
	 */
	public class StartComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="StartComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static var bgSp:Sprite;
		
		private var loginProxy:LoginProxy;
		
		public function StartComponentMediator()
		{
			addBG();
			
			super(NAME, new StartComponent());
			
			loginProxy= getProxy(LoginProxy);
			//是否为弹出框
			_popUp=false;
			comp.addEventListener(StartLoginEvent.START_LIGIN_EVENT,startLoginHandler);
			comp.addEventListener(StartLoginEvent.ACCOUNT_EVENT,accountHandler);
			comp.addEventListener(StartLoginEvent.REGIST_EVENT,registHandler);
			
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
		protected function get comp():StartComponent
		{
			return viewComponent as StartComponent;
		}
		
		public static function addBG():void
		{
			if(bgSp==null)
				bgSp=ClassUtil.getObject("view.login.LoginBG");
			MainMediator(ApplicationFacade.getInstance().getMediator(MainMediator)).addChild(bgSp);
		}
		
		public static function removeBG():void
		{
			MainMediator(ApplicationFacade.getInstance().getMediator(MainMediator)).removeChild(bgSp);
		}
		
		private function startLoginHandler(event:StartLoginEvent):void
		{
			LoginProxy.lastSenceMedClass=StartComponentMediator;
			destoryCallback = function():void
			{
				sendNotification(PkComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
			TaskEnum.IS_SPEED_LOGIN=true;
			
			GlobalUtil.recordLog(RecordEnum.quick_start);
		}
		
		private function accountHandler(event:StartLoginEvent):void
		{
			destoryCallback = function():void
			{
				sendNotification(LoginMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
		
		private function registHandler(event:StartLoginEvent):void
		{
			loginProxy.userName = "";
			loginProxy.passWord = "";
			loginProxy.passAgainWord = "";
			loginProxy.name = "";
			loginProxy.email = "";
			destoryCallback = function():void
			{
				LoginProxy.lastSenceMedClass=null;
				sendNotification(PkComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
		
		override public function show():void
		{
			super.show();
			comp.guanMen();
		}
		
	}
}