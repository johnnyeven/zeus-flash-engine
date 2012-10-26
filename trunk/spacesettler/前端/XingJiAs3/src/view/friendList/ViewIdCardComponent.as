package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import enum.friendList.FriendListCardEnum;
	
	import events.friendList.FriendListEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.friendList.FriendProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.Window;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	/**
	 *查看军官证
	 * @author lw
	 *
	 */
    public class ViewIdCardComponent extends Window
    {
		public var closeBtn:Button;
		public var checkFortBtn:Button;
		public var addFriendBtn:Button;
		public var sendEmailBtn:Button;
		
		public var playerNameLabel:Label;
		public var scienceLevelLabel:Label;
		public var shiDaiLabel:Label;
		public var groupNameLabel:Label;
		public var ziWuLabel:Label;
		public var junXianLabel:Label;
		public var totalRankLabel:Label;
		
		private var friendProxy:FriendProxy;
		private var playerIDCardVO:FriendInfoVo;
        public function ViewIdCardComponent()
        {
            super(ClassUtil.getObject("view.friendList.ViewIdCardSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			
			closeBtn = createUI(Button,"closeBtn");
			checkFortBtn = createUI(Button,"checkFortBtn");
			addFriendBtn = createUI(Button,"addFriendBtn");
			sendEmailBtn = createUI(Button,"sendEmailBtn");
			
			playerNameLabel = createUI(Label,"playerNameLabel");
			scienceLevelLabel = createUI(Label,"scienceLevelLabel");
			shiDaiLabel = createUI(Label,"shiDaiLabel");
			groupNameLabel = createUI(Label,"groupNameLabel");
			ziWuLabel = createUI(Label,"ziWuLabel");
			junXianLabel = createUI(Label,"junXianLabel");
			totalRankLabel = createUI(Label,"totalRankLabel");
			
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(dataChange,friendProxy,"playerIDCardVO"));
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHAndler);
			checkFortBtn.addEventListener(MouseEvent.CLICK,checkFortBtn_clickHandler);
			addFriendBtn.addEventListener(MouseEvent.CLICK,addFriendBtn_clickHandler);
			sendEmailBtn.addEventListener(MouseEvent.CLICK,sendEmailBtn_clickHandler);
        }
		
		
		private function dataChange(data:*):void
		{
			playerIDCardVO = data as FriendInfoVo;
			if(playerIDCardVO)
			{
				playerNameLabel.text = playerIDCardVO.nickname;
				scienceLevelLabel.text = playerIDCardVO.academy_level +"级"
				shiDaiLabel.text = playerIDCardVO.getKeJiShiDaiNameByKeJiShiDaiLevel(playerIDCardVO.age_level);
				groupNameLabel.text = playerIDCardVO.groupName;
				ziWuLabel.text = FriendListCardEnum.getZhiWuNameByZHiWULevel(playerIDCardVO.groupListVO.level);
				junXianLabel.text= FriendListCardEnum.getJunXianNameByJunXianLevel(playerIDCardVO.military_rank);
				totalRankLabel.text = playerIDCardVO.total_prestige_rank +"名";
			}
		}
		
		protected function closeBtnHAndler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new Event("closeIDCardComponent"));
		}
		
		protected function checkFortBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new FriendListEvent(FriendListEvent.CHECK_FORT_BY_ID_CARD_EVENT,playerIDCardVO.id));
		}
		
		protected function addFriendBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new FriendListEvent(FriendListEvent.ADD_FRIEND_BY_ID_CARD_EVENT,playerIDCardVO.id));
		}
		
		protected function sendEmailBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new FriendListEvent(FriendListEvent.SEND_EMAIL_BY_ID_CARD_EVENT,playerIDCardVO));
		}
	}
}