package mediator.login
{
	import events.LoginEvent;
	
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.LoginProxy;
	
	import view.login.LoginBGComponent;
	import view.login.StartComponent;
	
	public class StartMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoginMediator";
		
		public static const DESTROY_NOTE: String = "Destroy" + NAME;
		
		public function StartMediator(viewComponent:Object=null)
		{
			super(NAME, new StartComponent());
			
			component.addEventListener(LoginEvent.START_EVENT, onLoginStart);
			component.addEventListener(LoginEvent.ACCOUNT_EVENT, onLoginAccount);
		}
		
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case DESTROY_NOTE:
					destroy();
					break;
			}
		}
		
		public function addBg(): void
		{
			stage.addChild(LoginBGComponent.getInstance());
			LoginBGComponent.getInstance().show();
		}
		
		public function removeBg(): void
		{
			LoginBGComponent.getInstance().hide(function(): void
			{
				stage.removeChild(LoginBGComponent.getInstance());
			});
		}
		
		private function onLoginStart(evt: LoginEvent): void
		{
			component.switchDoorStatus(false);
			component.openDoor(startHandler);
		}
		
		private function onLoginAccount(evt: LoginEvent): void
		{
			component.switchDoorStatus(false);
			component.openDoor(accountHandler);
		}
		
		private function startHandler(): void
		{
			var _loginProxy: LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			_loginProxy.quickStart();
			destroy();
		}
		
		private function accountHandler(): void
		{
			
		}
		
		protected function get component(): StartComponent
		{
			return viewComponent as StartComponent;
		}
		
		private function get stage(): StageMediator
		{
			return facade.retrieveMediator(StageMediator.NAME) as StageMediator;
		}
		
		public function show(): void
		{
			stage.addChild(component);
			component.switchDoorStatus(true);
			component.closeDoor();
		}
		
		public function destroy(): void
		{
			stage.removeChild(component);
		}
	}
}