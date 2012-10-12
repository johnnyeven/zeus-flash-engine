package view.group
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
    public class GroupComponent extends Component
    {
		public var buChongZhanJiBtn:Button;
		public var chaKanTuanYuanBtn:Button;
		public var chengYuanGuanLiBtn:Button;
		public var junTuanGuanLiBtn:Button;
		public var closeBtn:Button;
		
		/**
		 *进入星际战场的BTN 
		 */		
		public var joinBattlefieldBtn:Button;
		
		/**
		 * 战利品
		 */		
		public var moneyText:Label;
		
		/**
		 * 成员人数
		 */		
		public var chengyuanNumText:Label;
		
		/**
		 * 可控战舰数
		 */		
		public var controlledNumText:Label;
		
		/**
		 * 职务
		 */		
		public var jobText:Label;
		
		/**
		 * 军团长名称
		 */		
		public var junTuanZhangText:Label;
		
		/**
		 * 军团名次
		 */		
		public var topText:Label;
		
		/**
		 * 军团名
		 */		
		public var groupNameText:Label;
		
		/**
		 * 时间
		 */		
		public var timeText:Label;
		
		/**
		 * 公告
		 */		
		public var gongGaoText:Label;

		public var downMc:Sprite;
		public var upMc:Sprite;
		
		
		private var groupProxy:GroupProxy;
		private var userProxy:UserInfoProxy;
        public function GroupComponent()
        {
            super(ClassUtil.getObject("view.group.GroupSkin"));
			
			groupProxy=ApplicationFacade.getProxy(GroupProxy);
			userProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			buChongZhanJiBtn=createUI(Button,"buchongzhanji_btn");
			chaKanTuanYuanBtn=createUI(Button,"chakantuanyuan_btn");
			chengYuanGuanLiBtn=createUI(Button,"chengyuanguanli_btn");
			junTuanGuanLiBtn=createUI(Button,"juntuanguanli_btn");
			closeBtn=createUI(Button,"close_btn");
			joinBattlefieldBtn=createUI(Button,"join_battlefield_btn");
			
			moneyText=createUI(Label,"money_tf");
			chengyuanNumText=createUI(Label,"chengyuan_tf");
			controlledNumText=createUI(Label,"num_tf");
			jobText=createUI(Label,"zhiwei_tf");
			junTuanZhangText=createUI(Label,"juntuanzhang_tf");
			topText=createUI(Label,"top_tf");
			groupNameText=createUI(Label,"group_name_tf");
			timeText=createUI(Label,"time_tf");
			gongGaoText=createUI(Label,"gonggao_tf");
			
			downMc=getSkin("down_mc");
			upMc=getSkin("up_mc");
			
			
			sortChildIndex();
			upData();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeClickHandler);
			chaKanTuanYuanBtn.addEventListener(MouseEvent.CLICK,lookMemberHandler);
        }
		
		private function upData():void
		{
			if(groupProxy.groupInfoVo.username==userProxy.userInfoVO.nickname)
			{
				isGroupLeader();
			}else
			{
				notGroupLeader();
			}
			
			moneyText.text=groupProxy.groupInfoVo.dark_crystal.toString();
			chengyuanNumText.text=groupProxy.groupInfoVo.peopleNum.toString();
			controlledNumText.text=groupProxy.groupInfoVo.max_warship.toString();
			jobText.text=groupProxy.groupInfoVo.job;
			junTuanZhangText.text=groupProxy.groupInfoVo.username;
			topText.text="top"+groupProxy.groupInfoVo.rank;
			groupNameText.text=groupProxy.groupInfoVo.groupname;
			timeText.text="["+DateFormatter.formatterTimeNYR(groupProxy.groupInfoVo.current_time)+"]";
			if(groupProxy.groupInfoVo.desc!="")
			{
				gongGaoText.text=groupProxy.groupInfoVo.desc;
			}else
			{
				gongGaoText.text=MultilanguageManager.getString("gonggao");
			}
				
		}
		
		protected function lookMemberHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.SHOW_LOOKMEMBER));
		}
		
		protected function closeClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.CLOSE));
		}
		
		public function isGroupLeader():void
		{
			chengYuanGuanLiBtn.visible=true;
			junTuanGuanLiBtn.visible=true;
			chengYuanGuanLiBtn.mouseEnabled=true;
			junTuanGuanLiBtn.mouseEnabled=true;
			chengYuanGuanLiBtn.addEventListener(MouseEvent.CLICK,memberManageHandler);
			junTuanGuanLiBtn.addEventListener(MouseEvent.CLICK,groupManageHandler);
		}
		
		protected function groupManageHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.SHOW_GROUPMANAGE));
		}
		
		protected function memberManageHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.SHOW_MEMBERMANAGE));
		}
		public function notGroupLeader():void
		{
			chengYuanGuanLiBtn.visible=false;
			junTuanGuanLiBtn.visible=false;
			chengYuanGuanLiBtn.mouseEnabled=false;
			junTuanGuanLiBtn.mouseEnabled=false;
		}
    }
}