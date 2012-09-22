package mediator.login
{
	
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.StringUtil;
	
	import events.login.RegistEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.login.LoginProxy;
	
	import view.login.RegistComponent;

	/**
	 * 注册
	 * @author lw
	 *
	 */
	public class RegistComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="RegistComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function RegistComponentMediator()
		{
			StartComponentMediator.addBG();
			super(NAME, new RegistComponent());
			
			comp.addEventListener(RegistEvent.BACK_EVENT,backHandler);
			comp.addEventListener(RegistEvent.NEXT_EVENT,nextHandler);
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
					sendNotification(PromptMediator.HIDE_LOGIN_INFO_NOTE);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():RegistComponent
		{
			return viewComponent as RegistComponent;
		}

		protected function backHandler(event:RegistEvent):void
		{
			destoryCallback = function():void
			{
				sendNotification(StartComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
		
		private function nextHandler(event:RegistEvent):void
		{
			if (StringUtil.isEmpty(event.userName))
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registInfoEmpty"));
				return;
			}
			else if(event.userName.length <6)
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registInforError"));
				return;
			}
			else if(StringUtil.isEmpty(event.passWord))
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registPasswordEmpty"));
				return;
			}
			else if(event.passWord.length <6)
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registPasswordError"));
				return;
			}
			else if(event.passWord != event.passAgainWord)
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registAgainEmpty"));
				return;
			}
			// ok
			var loginProxy:LoginProxy = getProxy(LoginProxy);
			loginProxy.userName = event.userName;
			loginProxy.passWord = event.passWord;
			loginProxy.passAgainWord = event.passAgainWord;
			
			destoryCallback = function():void
			{
				sendNotification(NameInforComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
	}
}