package view.friendList
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.friendList.FriendListCardEnum;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class EnemyItem extends Component
	{
		public var playerNameLabel:Label;
		public var pointLabel:Label;
		public var ageLevelLabel:Label;
		public var attackTimeLabel:Label;
		
		private var _data:FriendInfoVo;
		public function EnemyItem()
		{
			super(ClassUtil.getObject("view.friendList.enemyItem"));
			playerNameLabel = createUI(Label,"playerNameLabel");
			pointLabel = createUI(Label,"pointLabel");
			ageLevelLabel = createUI(Label,"ageLevelLabel");
			attackTimeLabel = createUI(Label,"attackTimeLabel");
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
				var str:String = "<p><s>攻打时间：</s><s>{0}</s></p>";
				str = StringUtil.formatString(str,DateFormatter.formatterTimeNYR(_data.attack_time));
				attackTimeLabel.text = str;
				var str1:String = "<p><s>被攻要塞坐标：</s><s>{0}</s><s>:</s><s>{1}</s><s>:</s><s>{2}</s></p>";
				str = StringUtil.formatString(str,_data.x,_data.y,_data.z);
				pointLabel.text = str;
			}
		}
	}
}