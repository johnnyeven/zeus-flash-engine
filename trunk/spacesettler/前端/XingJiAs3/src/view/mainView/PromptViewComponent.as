package view.mainView
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import ui.core.Component;
	
	public class PromptViewComponent extends Component
	{
		/**
		 * 任务提示
		 */		
		public var job:MovieClip;
		
		/**
		 *邮件提示 
		 */		
		public var mail:MovieClip;
		
		public function PromptViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			job=getSkin("renwu_mc");
			mail=getSkin("youjian_mc");
			
			mail.visible=false;
			sortChildIndex();
		}
		
		
	}
}