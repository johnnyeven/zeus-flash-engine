package mediator
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.PromptComponent;
	
	public class PromptMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "PromptMediator";
		private var _loadingMovieClip: MovieClip;
		
		/**
		 * 消息定义
		 */
		public static const PROMPT_SHOW_NOTE: String = "prompt_show_note";
		public static const PROMPT_HIDE_NOTE: String = "prompt_hide_note";
		
		public function PromptMediator(viewComponent:Object=null)
		{
			viewComponent = viewComponent == null ? new PromptComponent() : viewComponent;
			super(NAME, viewComponent);
			
			var _class: Class = getDefinitionByName("ui.LoadingSkin") as Class;
			_loadingMovieClip = new _class() as MovieClip;
		}
		
		override public function listNotificationInterests(): Array
		{
			return [PROMPT_SHOW_NOTE, PROMPT_HIDE_NOTE];
		}
		
		override public function handleNotification(notification:INotification): void
		{
			switch(notification.getName())
			{
				case PROMPT_SHOW_NOTE:
					showPrompt(notification.getBody() as String);
					break;
				case PROMPT_HIDE_NOTE:
					hidePrompt();
					break;
			}
		}
		
		private function showPrompt(value: String): void
		{
			component.title = value;
			var _stageMediator: StageMediator = (facade.retrieveMediator(StageMediator.NAME)) as StageMediator;
			_stageMediator.addChild(component);
		}
		
		private function hidePrompt(): void
		{
			var _stageMediator: StageMediator = (facade.retrieveMediator(StageMediator.NAME)) as StageMediator;
			_stageMediator.removeChild(component);
		}
		
		private function get component(): PromptComponent
		{
			return viewComponent as PromptComponent;
		}
	}
}