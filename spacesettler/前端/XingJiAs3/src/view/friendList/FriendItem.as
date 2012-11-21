package view.friendList
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.friendList.FriendListCardEnum;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class FriendItem extends Component
	{
		
		public var playerNameLabel:Label;
		public var ageLevelLabel:Label;
		public var lastLoginLabel:Label;
		
		private var _data:FriendInfoVo;
		
		public function FriendItem()
		{
			super(ClassUtil.getObject("view.friendList.friendItem"));
			
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
				ageLevelLabel.text = FriendListCardEnum.getKeJiShiDaiNameByKeJiShiDaiLevel(_data.age_level);
				var str:String = "<p><s>最后一次登录时间:</s><s>{0}</s></p>";
				str = StringUtil.formatString(str,DateFormatter.formatterTimeNYR(_data.last_login_time));
				lastLoginLabel.text = str;
			}
		}

	}
}