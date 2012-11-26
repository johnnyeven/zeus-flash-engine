package view.group
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.group.GroupProxy;
	import proxy.groupFight.GroupFightProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.group.GroupListVo;
	
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
		
		public var star1:Sprite;
		public var star2:Sprite;
		public var star3:Sprite;
		public var star4:Sprite;

		public var downMc:Sprite;
		public var upMc:Sprite;
		public var gapNum:int;
		public var groupVo:GroupListVo;
		
		private var _current_warship:int=1;
		
		private var userProxy:UserInfoProxy;
        public function GroupComponent()
        {
            super(ClassUtil.getObject("view.group.GroupSkin"));
			
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
			
			star1=getSkin("star1");
			star2=getSkin("star2");
			star3=getSkin("star3");
			star4=getSkin("star4");
			
			downMc=getSkin("down_mc");
			upMc=getSkin("up_mc");
			
			
			sortChildIndex();
			
			star1.visible=star2.visible=star3.visible=star4.visible=false;
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeClickHandler);
			chaKanTuanYuanBtn.addEventListener(MouseEvent.CLICK,lookMemberHandler);
			buChongZhanJiBtn.addEventListener(MouseEvent.CLICK,buChongZhanJiBtn_Handler);
			joinBattlefieldBtn.addEventListener(MouseEvent.CLICK,joinBattlefieldBtn_Handler);
        }
		
		protected function joinBattlefieldBtn_Handler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.SHOW_PLANE_EVENT));
		}
		
		protected function buChongZhanJiBtn_Handler(event:MouseEvent):void
		{
			dispatchEvent(new GroupEvent(GroupEvent.BUCHONG_EVENT));
		}
		
		public function upData(groupInfoVo:GroupListVo,bool1:Boolean,bool2:Boolean,bool3:Boolean,bool4:Boolean):void
		{
			if(bool1)
				star1.visible=true;
			if(bool2)
				star2.visible=true;
			if(bool3)
				star3.visible=true;
			if(bool4)
				star4.visible=true;
			groupVo=groupInfoVo;
			if(groupInfoVo.username==userProxy.userInfoVO.nickname)
			{
				isGroupLeader();
			}else
			{
				notGroupLeader();
			}
			
			moneyText.text=groupInfoVo.dark_crystal.toString();
			chengyuanNumText.text=groupInfoVo.peopleNum.toString();
			controlledNumText.text=groupInfoVo.max_warship.toString();
			jobText.text=groupInfoVo.job;
			current_warship=groupInfoVo.current_warship;
			junTuanZhangText.text=groupInfoVo.username;
			topText.text="top"+groupInfoVo.rank;
			groupNameText.text=groupInfoVo.groupname;
			timeText.text="["+DateFormatter.formatterTimeNYR(groupInfoVo.current_time*1000)+"]";
			if(groupInfoVo.desc!="")
			{
				gongGaoText.text=groupInfoVo.desc;
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

		/**
		 *玩家当前拥有的战舰数 
		 */
		public function get current_warship():int
		{
			return _current_warship;
		}

		/**
		 * @private
		 */
		public function set current_warship(value:int):void
		{
			if(_current_warship!=1)
			{
				gapNum=value-_current_warship;
			}
			
			_current_warship = value;
		}

    }
}