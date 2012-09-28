package view.scene
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class SceneControlComponent extends Sprite
	{
		private var _topContainer: MovieClip;
		private var _promptContainer: MovieClip;
		private var _menuContainer: MovieClip;
		private var _messageContainer: MovieClip;
		
		public function SceneControlComponent()
		{
			super();
			
			var _class: Class = getDefinitionByName("ui.core.ControlPanelSkin") as Class;
			var _skin: MovieClip = new _class() as MovieClip;
			
			addChild(_skin);
			
			_topContainer = _skin.getChildByName("topContainer") as MovieClip;
			_promptContainer = _skin.getChildByName("promptContainer") as MovieClip;
			_menuContainer = _skin.getChildByName("menuContainer") as MovieClip;
			_messageContainer = _skin.getChildByName("messageContainer") as MovieClip;
		}
	}
}