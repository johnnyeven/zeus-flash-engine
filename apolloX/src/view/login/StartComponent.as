package view.login
{
	import com.greensock.TweenLite;
	
	import events.LoginEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class StartComponent extends Sprite
	{
		private var _topDoorMC: MovieClip;
		private var _bottomDoorMC: MovieClip;
		
		private var _buttonStart: MovieClip;
		private var _buttonLogin: MovieClip;
		private var _buttonRegister: MovieClip;
		
		private var _btnStartNormal: MovieClip;
		private var _btnStartOver: MovieClip;
		private var _btnStartPress: MovieClip;
		
		private var _btnLoginNormal: MovieClip;
		private var _btnLoginOver: MovieClip;
		private var _btnLoginPress: MovieClip;
		
		private var _btnRegisterNormal: MovieClip;
		private var _btnRegisterOver: MovieClip;
		private var _btnRegisterPress: MovieClip;
		
		public function StartComponent()
		{
			super();
			
			var _class: Class = getDefinitionByName("ui.login.StartWindowSkin") as Class;
			var _skin: MovieClip = new _class() as MovieClip;
			
			addChild(_skin);
			
			_topDoorMC = _skin.getChildByName("topDoorMC") as MovieClip;
			_bottomDoorMC = _skin.getChildByName("bottomDoorMC") as MovieClip;
			
			_buttonStart = _topDoorMC.getChildByName("btnStart") as MovieClip;
			_buttonLogin = _bottomDoorMC.getChildByName("btnLogin") as MovieClip;
			_buttonRegister = _bottomDoorMC.getChildByName("btnRegister") as MovieClip;
			
			_btnStartNormal = _buttonStart.getChildByName("buttonNormal") as MovieClip;
			_btnStartOver = _buttonStart.getChildByName("buttonOver") as MovieClip;
			_btnStartPress = _buttonStart.getChildByName("buttonPress") as MovieClip;
			
			_btnLoginNormal = _buttonLogin.getChildByName("buttonNormal") as MovieClip;
			_btnLoginOver = _buttonLogin.getChildByName("buttonOver") as MovieClip;
			_btnLoginPress = _buttonLogin.getChildByName("buttonPress") as MovieClip;
			
			_btnRegisterNormal = _buttonRegister.getChildByName("buttonNormal") as MovieClip;
			_btnRegisterOver = _buttonRegister.getChildByName("buttonOver") as MovieClip;
			_btnRegisterPress = _buttonRegister.getChildByName("buttonPress") as MovieClip;
			
			_btnStartNormal.visible = true;
			_btnStartOver.visible = false;
			_btnStartPress.visible = false;
			
			_btnLoginNormal.visible = true;
			_btnLoginOver.visible = false;
			_btnLoginPress.visible = false;
			
			_btnRegisterNormal.visible = true;
			_btnRegisterOver.visible = false;
			_btnRegisterPress.visible = false;
			
			_buttonStart.addEventListener(MouseEvent.ROLL_OVER, onButtonStartOver);
			_buttonStart.addEventListener(MouseEvent.ROLL_OUT, onButtonStartOut);
			_buttonStart.addEventListener(MouseEvent.MOUSE_DOWN, onButtonStartDown);
			_buttonStart.addEventListener(MouseEvent.MOUSE_UP, onButtonStartUp);
			
			_buttonLogin.addEventListener(MouseEvent.ROLL_OVER, onButtonLoginOver);
			_buttonLogin.addEventListener(MouseEvent.ROLL_OUT, onButtonLoginOut);
			_buttonLogin.addEventListener(MouseEvent.MOUSE_DOWN, onButtonLoginDown);
			_buttonLogin.addEventListener(MouseEvent.MOUSE_UP, onButtonLoginUp);
			
			_buttonRegister.addEventListener(MouseEvent.ROLL_OVER, onButtonRegisterOver);
			_buttonRegister.addEventListener(MouseEvent.ROLL_OUT, onButtonRegisterOut);
			_buttonRegister.addEventListener(MouseEvent.MOUSE_DOWN, onButtonRegisterDown);
			_buttonRegister.addEventListener(MouseEvent.MOUSE_UP, onButtonRegisterUp);
		}
		
		private function hideButtonStartStatus(): void
		{
			_btnStartNormal.visible = false;
			_btnStartOver.visible = false;
			_btnStartPress.visible = false;
		}
		
		private function hideButtonLoginStatus(): void
		{
			_btnLoginNormal.visible = false;
			_btnLoginOver.visible = false;
			_btnLoginPress.visible = false;
		}
		
		private function hideButtonRegisterStatus(): void
		{
			_btnRegisterNormal.visible = false;
			_btnRegisterOver.visible = false;
			_btnRegisterPress.visible = false;
		}
		
		private function onButtonStartOver(evt: MouseEvent): void
		{
			hideButtonStartStatus();
			_btnStartOver.visible = true;
		}
		
		private function onButtonStartOut(evt: MouseEvent): void
		{
			hideButtonStartStatus();
			_btnStartNormal.visible = true;
		}
		
		private function onButtonStartDown(evt: MouseEvent): void
		{
			hideButtonStartStatus();
			_btnStartPress.visible = true;
		}
		
		private function onButtonStartUp(evt: MouseEvent): void
		{
			hideButtonStartStatus();
			_btnStartNormal.visible = true;
			
			var _evt: LoginEvent = new LoginEvent(LoginEvent.START_EVENT);
			dispatchEvent(_evt);
		}
		
		private function onButtonLoginOver(evt: MouseEvent): void
		{
			hideButtonLoginStatus();
			_btnLoginOver.visible = true;
		}
		
		private function onButtonLoginOut(evt: MouseEvent): void
		{
			hideButtonLoginStatus();
			_btnLoginNormal.visible = true;
		}
		
		private function onButtonLoginDown(evt: MouseEvent): void
		{
			hideButtonLoginStatus();
			_btnLoginPress.visible = true;
		}
		
		private function onButtonLoginUp(evt: MouseEvent): void
		{
			hideButtonLoginStatus();
			_btnLoginNormal.visible = true;
			
			var _evt: LoginEvent = new LoginEvent(LoginEvent.ACCOUNT_EVENT);
			dispatchEvent(_evt);
		}
		
		private function onButtonRegisterOver(evt: MouseEvent): void
		{
			hideButtonRegisterStatus();
			_btnRegisterOver.visible = true;
		}
		
		private function onButtonRegisterOut(evt: MouseEvent): void
		{
			hideButtonRegisterStatus();
			_btnRegisterNormal.visible = true;
		}
		
		private function onButtonRegisterDown(evt: MouseEvent): void
		{
			hideButtonRegisterStatus();
			_btnRegisterPress.visible = true;
		}
		
		private function onButtonRegisterUp(evt: MouseEvent): void
		{
			hideButtonRegisterStatus();
			_btnRegisterNormal.visible = true;
			
			var _evt: LoginEvent = new LoginEvent(LoginEvent.ACCOUNT_EVENT);
			dispatchEvent(_evt);
		}
		
		public function closeDoor(callback: Function = null): void
		{
			TweenLite.to(_topDoorMC, .5, {
				y: 0
			});
			TweenLite.to(_bottomDoorMC, .5, {
				y: 291.6,
				onComplete: callback
			});
		}
		
		public function openDoor(callback: Function = null): void
		{
			TweenLite.to(_topDoorMC, .5, {
				y: -_topDoorMC.height
			});
			TweenLite.to(_bottomDoorMC, .5, {
				y: stage.stageHeight,
				onComplete: callback
			});
		}
		
		public function switchDoorStatus(opened: Boolean): void
		{
			if(opened)
			{
				_topDoorMC.y = -_topDoorMC.height;
				_bottomDoorMC.y = stage.stageHeight;
			}
			else
			{
				_topDoorMC.y = 0;
				_bottomDoorMC.y = 291.6;
			}
		}
	}
}