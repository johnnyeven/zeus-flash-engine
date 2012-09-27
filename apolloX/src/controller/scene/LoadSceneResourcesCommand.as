package controller.scene
{
	import controller.init.LoadServerListCommand;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mediator.loader.ProgressBarMediator;
	import mediator.login.StartMediator;
	import mediator.scene.Scene1BackgroundMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.language.LanguageManager;
	
	public class LoadSceneResourcesCommand extends SimpleCommand
	{
		public static const LOAD_RESOURCES_NOTE: String = "LoadSceneResourcesCommand";
		
		public function LoadSceneResourcesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LOAD_RESOURCES_NOTE);
			
			var _loader: Loader = new Loader();
			var _urlRequest: URLRequest = new URLRequest("resources/ui/scene/scene1_base_ui.swf");
			var _loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			_loader.load(_urlRequest, _loaderContext);
			
			sendNotification(ProgressBarMediator.SHOW_RANDOM_BG);
			sendNotification(ProgressBarMediator.SHOW_PROGRESSBAR_NOTE);
			sendNotification(ProgressBarMediator.SET_PROGRESSBAR_TITLE_NOTE, LanguageManager.getInstance().lang("load_scene_ui"));
		}
		
		private function onLoadComplete(evt: Event): void
		{
			var _startMediator: StartMediator = facade.retrieveMediator(StartMediator.NAME) as StartMediator;
			_startMediator.removeBg();
			
			facade.registerMediator(new Scene1BackgroundMediator());
			
			loadControlPanel();
		}
		
		private function loadControlPanel(): void
		{
			var _loader: Loader = new Loader();
			var _urlRequest: URLRequest = new URLRequest("resources/ui/scene/scene_control_ui.swf");
			var _loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onControlPanelLoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			_loader.load(_urlRequest, _loaderContext);
			
			sendNotification(ProgressBarMediator.SET_PROGRESSBAR_TITLE_NOTE, LanguageManager.getInstance().lang("load_control_panel_ui"));
		}
		
		private function onControlPanelLoaded(evt: Event): void
		{
			sendNotification(ProgressBarMediator.HIDE_RANDOM_BG);
			sendNotification(ProgressBarMediator.HIDE_PROGRESSBAR_NOTE);
			
			var _backgroundMediator: Scene1BackgroundMediator = facade.retrieveMediator(Scene1BackgroundMediator.NAME) as Scene1BackgroundMediator;
			_backgroundMediator.show();
		}
		
		private function onLoadProgress(evt: ProgressEvent): void
		{
			sendNotification(ProgressBarMediator.SET_PROGRESSBAR_PERCENT_NOTE, evt.bytesLoaded / evt.bytesTotal);
		}
		
		private function onLoadIOError(evt: IOErrorEvent): void
		{
			
		}
	}
}