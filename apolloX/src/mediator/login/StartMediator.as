package mediator.login
{
	import events.LoginEvent;
	
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.LoginProxy;
	
	import view.login.StartComponent;
	
	public class StartMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoginMediator";
		
		public function StartMediator(viewComponent:Object=null)
		{
			super(NAME, new StartComponent());
			
			component.addEventListener(LoginEvent.START_EVENT, onLoginStart);
			component.addEventListener(LoginEvent.ACCOUNT_EVENT, onLoginAccount);
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
	}
}