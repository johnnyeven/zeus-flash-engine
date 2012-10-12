package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 *好友列表
	 * @author lw
	 *
	 */
    public class FriendListComponent extends Window
    {
		public var reNewBtn:MovieClip;
		
		public var playerBtn:Button;
		
		public var closeBtn:Button;
		
        public function FriendListComponent()
        {
            super(ClassUtil.getObject("view.friendList.FriendListSkin"));
			
			reNewBtn = getSkin("reNewBtn") as MovieClip;
			reNewBtn.buttonMode = true;
			playerBtn = createUI(Button,"playerBtn");

			closeBtn  = createUI(Button,"closeBtn");
			
			reNewBtn.mouseEnabled = reNewBtn.mouseChildren =  true;
			sortChildIndex();
			
			playerBtn.addEventListener(MouseEvent.CLICK,playerBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHand);
        }
		
		private function closeBtn_clickHand(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.CLOSE_FRIEND_LIST_EVENT));
		}
		private function playerBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_PLATER_EVENT));
		}
	}
}