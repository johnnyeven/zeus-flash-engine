package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import enum.BuffEnum;
	import enum.friendList.FriendListCardEnum;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.friendList.FriendProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
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
		
		public var vipImg:LoaderImage;
		
		public var vip1:Sprite;
		public var vip2:Sprite;
		public var vip3:Sprite;
		
		public var playerNameLabel:Label;
		public var scienceLevelLabel:Label;
		public var shiDaiLabel:Label;
		public var groupNameLabel:Label;
		public var ziWuLabel:Label;
		public var junXianLabel:Label;
		public var totalRankLabel:Label;
		public var vipDaysLabel:Label;
		
		private var friendProxy:FriendProxy;
		private var userInforProxy:UserInfoProxy;
		private var playerIDCardVO:FriendInfoVo;
        public function ViewIdCardComponent()
        {
            super(ClassUtil.getObject("view.friendList.ViewIdCardSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			vipImg = createUI(LoaderImage,"vipImg");
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
			vipDaysLabel = createUI(Label,"vipDays_tf");
			
			vip1=getSkin("vip1");
			vip2=getSkin("vip2");
			vip3=getSkin("vip3");
			
			vip1.visible=vip2.visible=vip3.visible=vipImg.visible=false;
			
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(dataChange,friendProxy,"playerIDCardVO"));
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHAndler);
			checkFortBtn.addEventListener(MouseEvent.CLICK,checkFortBtn_clickHandler);
			addFriendBtn.addEventListener(MouseEvent.CLICK,addFriendBtn_clickHandler);
			sendEmailBtn.addEventListener(MouseEvent.CLICK,sendEmailBtn_clickHandler);
        }
		
		private function vipShow(level:int):void
		{
			if(level==1)
			{
				vipImg.visible=true;
				vipImg.source=BuffEnum.SOURCE_VIP_1_1;
				vipImg.toolTipData=BuffEnum.VIP_1;
			}
			if(level==2)
			{
				vipImg.visible=true;
				vipImg.source=BuffEnum.SOURCE_VIP_2_1;
				vipImg.toolTipData=BuffEnum.VIP_2;
			}
			if(level==3)
			{
				vipImg.visible=true;
				vipImg.source=BuffEnum.SOURCE_VIP_3_1;
				vipImg.toolTipData=BuffEnum.VIP_3;
			}
		}
		
		private function myVipShow(level:int):void
		{
			if(level==1)
			{
				vip1.visible=true;
			}
			if(level==2)
			{
				vip2.visible=true;
			}
			if(level==3)
			{
				vip3.visible=true;
			}
		}
		
		private function dataChange(data:*):void
		{
			playerIDCardVO = data as FriendInfoVo;
			if(playerIDCardVO)
			{
				if(playerIDCardVO.vip_level!=0)
					vipShow(playerIDCardVO.vip_level);
				playerNameLabel.text = playerIDCardVO.nickname;
				scienceLevelLabel.text = playerIDCardVO.academy_level +"级"
				shiDaiLabel.text = playerIDCardVO.getKeJiShiDaiNameByKeJiShiDaiLevel(playerIDCardVO.age_level);
				if(playerIDCardVO.groupListVO.groupname&&playerIDCardVO.groupListVO.groupname!="")
					groupNameLabel.text = playerIDCardVO.groupListVO.groupname;
				else
					groupNameLabel.text="无";
				if(playerIDCardVO.groupListVO.level&&playerIDCardVO.groupListVO.level!=0)
					ziWuLabel.text = FriendListCardEnum.getZhiWuNameByZHiWULevel(playerIDCardVO.groupListVO.level);
				else
					ziWuLabel.text="无";
				junXianLabel.text= FriendListCardEnum.getJunXianNameByJunXianLevel(playerIDCardVO.military_rank);
				totalRankLabel.text = playerIDCardVO.total_prestige_rank +"名";
				if(playerIDCardVO.id == userInforProxy.userInfoVO.player_id)
				{
					addFriendBtn.visible = false;
					sendEmailBtn.visible = false;
					if(playerIDCardVO.vip_start_at==null)
						vipDaysLabel.visible=false;
					else
					{
						myVipShow(playerIDCardVO.vip_level);
						vipDaysLabel.visible=true;
						vipDaysLabel.text="有效期还有："+timeHandler(playerIDCardVO.vip_start_at,playerIDCardVO.vip_expired_at)+"天";
					}
				}
				else 
				{
					vipDaysLabel.visible=false;
					addFriendBtn.visible = true;
					if(playerIDCardVO.isMyFriend)
						sendEmailBtn.visible = true;
					else
						sendEmailBtn.visible = false;
						
					if(playerIDCardVO.isMyFriend == true)
					{
						addFriendBtn.visible = false;
					}
					else
					{
						addFriendBtn.visible = true;
					}
				}
				
			}
		}
		
		private function timeHandler(t1:String,t2:String):int
		{
			var start:int=int(t1);
			var end:int=int(t2);
			var totalDays:int;
			totalDays=(end-start)/60/60/24;
			
			return totalDays;
		}
		
		protected function closeBtnHAndler(event:MouseEvent):void
		{
			
			dispatchEvent(new Event("closeIDCardComponent"));
		}
		
		protected function checkFortBtn_clickHandler(event:MouseEvent):void
		{
			
			dispatchEvent(new FriendListEvent(FriendListEvent.CHECK_FORT_BY_ID_CARD_EVENT,playerIDCardVO.id));
		}
		
		protected function addFriendBtn_clickHandler(event:MouseEvent):void
		{
			
			dispatchEvent(new FriendListEvent(FriendListEvent.ADD_FRIEND_BY_ID_CARD_EVENT,playerIDCardVO.id));
		}
		
		protected function sendEmailBtn_clickHandler(event:MouseEvent):void
		{
			
			dispatchEvent(new FriendListEvent(FriendListEvent.SEND_EMAIL_BY_ID_CARD_EVENT,playerIDCardVO));
		}
	}
}