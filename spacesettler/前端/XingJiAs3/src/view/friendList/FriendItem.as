package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class FriendItem extends Component
	{
		public var topSprite:Sprite;
		public var buttonSprite:Sprite;
		
		public var playerNameLabel:Label;
		public var ageLevelLabel:Label;
		public var lastLoginLabel:Label;
		
		private var _data:FriendInfoVo;
		
		public function FriendItem()
		{
			super(ClassUtil.getObject("view.friendList.friendItem"));
			
			topSprite = getSkin("topSprite");
			buttonSprite = getSkin("buttonSprite");
			playerNameLabel = createUI(Label,"playerNameLabel");
			ageLevelLabel = createUI(Label,"ageLevelLabel");
			lastLoginLabel = createUI(Label,"lastLoginLabel");
			
			sortChildIndex();
		}
		
		public function get data():FriendInfoVo
		{
			return _data;
		}

		public function set data(value:FriendInfoVo):void
		{
			_data = value;
			if(_data)
			{
				playerNameLabel.text = _data.nickname;
				ageLevelLabel.text = _data.age_level +"";
				lastLoginLabel.text = _data.last_login_time +"";
			}
		}

	}
}