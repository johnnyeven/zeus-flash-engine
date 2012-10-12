package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.TextInput;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 *搜索玩家
	 * @author lw
	 *
	 */
    public class SearchPlayerComponent extends Window
    {
		public var closeBtn:Button;
		
		public var searchBtn:Sprite;
		
		public var playerNameInput:TextInput;
		
        public function SearchPlayerComponent()
        {
            super(ClassUtil.getObject("view.friendList.SearchPlayerSkin"));
			
			closeBtn = createUI(Button,"closeBtn");
			searchBtn = getSkin("searchBtn");
			playerNameInput = createUI(TextInput,"playerNameInput");
			
			sortChildIndex();
			closeBtn.addEventListener(MouseEvent.CLICK,close_handler);
			
        }
		
		private function close_handler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.CLOSE_SEARCH_PLAYER_EVENT));
		}
    }
}