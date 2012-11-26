package mediator.login
{
	
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.StringUtil;
	
	import events.login.NameInforEvent;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.login.LoginProxy;
	
	import view.login.NameInforComponent;
	
	/**
	 * 昵称
	 * @author lw
	 *
	 */
	public class NameInforComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="NameInforComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function NameInforComponentMediator()
		{
			super(NAME, new NameInforComponent());
			height=600;
			popUpEffect=UP;
			comp.addEventListener(NameInforEvent.BACK_EVENT,backHandler);
			comp.addEventListener(NameInforEvent.NEXT_EVENT,nextHandler);
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
				case SHOW_NOTE:
				{
					var obj:Object = note.getBody();
					if(obj.errors == "")
					{
						comp.returnSprie.visible = true;
						comp.returnSprie.mouseChildren = comp.returnSprie.mouseEnabled = false;
					}
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():NameInforComponent
		{
			return viewComponent as NameInforComponent;
		}

		private function backHandler(event:NameInforEvent):void
		{
			destoryCallback = function():void
			{
				sendNotification(RegistComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
		
		private function strLength(str:String):int
		{
			var length:int=0;
			for (var i:int = 0; i < str.length; i++)
			{  
				if(str.charCodeAt(i)<10000)
					length+=1;
				else
					length+=2;
//				trace(str.charAt(i), "-", str.charCodeAt(i));
			}
			return length;
		}
		
		private function nextHandler(event:NameInforEvent):void
		{
			var emailReg:RegExp=new RegExp("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$","g");
			
			if (!StringUtil.isEmpty(event.email) && !emailReg.test(event.email))
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registEmailError"));
				return;
			}
			else if(StringUtil.isEmpty(event.name))
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registNameEmpty"));
				return;
			}
			else if(strLength(event.name)<6)
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("registNameError"));
				return;
			}
			
			var loginProxy:LoginProxy = getProxy(LoginProxy);
			loginProxy.name = event.name;
			loginProxy.email = event.email;

			destoryCallback = function():void
			{
				loginProxy.regist(function():void
				{
					sendNotification(DESTROY_NOTE);
				});
			};
			sendNotification(DESTROY_NOTE);
		}
	}
}