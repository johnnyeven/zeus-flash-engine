package view.group
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.group.GroupShowAndCloseEvent;
	import events.group.MemberManageEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import proxy.group.GroupProxy;
	
	import ui.components.Button;
	import ui.components.CheckBox;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.group.GroupMemberListVo;
	
	/**
	 *团员管理 
	 * @author Administrator
	 * 
	 */	
    public class GroupMemberManageComponent extends Component
    {
		public var vs_bar:VScrollBar;
		
		/**
		 *装成员ITEM的SP 
		 */		
		public var sprite:Sprite;
		
		/**
		 *提示MC 
		 */		
		public var mc_tishi:Sprite;
		public var fanHuiBtn:Button;
		
		/**
		 *装点击后操作界面的SP 
		 */		
		public var sprite_all:Component;
		
		//成员 名称 职务 和带兵的数量
		public var username_tf:Label;
		public var zhiwu_tf:Label;
		public var xianshi_tf:Label;
		
		public var back_click_mc:Button;
		/**
		 *设置职务选项的SP 
		 */		
		public var click_sp:GroupClickComponent;
		
		/**
		 *总的显示的BOX 
		 */		
		public var checkbox_0:CheckBox;
		
		//选线BOX  分别为 1K  5K  10K  50K  100K
		public var checkbox_1:CheckBox;
		public var checkbox_2:CheckBox;
		public var checkbox_3:CheckBox;
		public var checkbox_4:CheckBox;
		public var checkbox_5:CheckBox;
		
		/**
		 *从军团开除的BOX 
		 */		
		public var checkbox_6:CheckBox;
		
		public var sure_btn:Button;
		
		private var groupProxy:GroupProxy;
		private var container:Container;
		private var _currentItem:GroupItem_2Component;
		private var _currentVo:GroupMemberListVo;
		private var _memberLevel:int;
		private var _maxNum:int;
		private var _killNum:int;
		private var _isClick:Boolean;
        public function GroupMemberManageComponent()
        {
            super(ClassUtil.getObject("view.group.GroupMemberManageSkin"));
			fanHuiBtn=createUI(Button,"fanhui_btn");
			vs_bar=createUI(VScrollBar,"vs_bar");
			sprite_all=createUI(Component,"sprite_all");
			
			sprite=getSkin("sprite");
			mc_tishi=getSkin("mc_tishi");
			
			username_tf=sprite_all.createUI(Label,"username_tf");
			zhiwu_tf=sprite_all.createUI(Label,"zhiwu_tf");
			xianshi_tf=sprite_all.createUI(Label,"xianshi_tf");
			
			checkbox_0=sprite_all.createUI(CheckBox,"checkbox_0");
			checkbox_1=sprite_all.createUI(CheckBox,"checkbox_1");
			checkbox_2=sprite_all.createUI(CheckBox,"checkbox_2");
			checkbox_3=sprite_all.createUI(CheckBox,"checkbox_3");
			checkbox_4=sprite_all.createUI(CheckBox,"checkbox_4");
			checkbox_5=sprite_all.createUI(CheckBox,"checkbox_5");
			checkbox_6=sprite_all.createUI(CheckBox,"checkbox_6");
			back_click_mc=sprite_all.createUI(Button,"back_click_mc");
			
			sure_btn=sprite_all.createUI(Button,"sure_btn");
			
			click_sp=sprite_all.createUI(GroupClickComponent,"click_sp");
			
			sprite_all.sortChildIndex();
			sortChildIndex();			
			groupProxy=ApplicationFacade.getProxy(GroupProxy);
			
			container=new Container(null);
			container.contentWidth=sprite.width;
			container.contentHeight=sprite.height;			
			container.layout=new HTileLayout(container);
			container.x=0;
			container.y=0;
			sprite.addChild(container);
			upData(groupProxy.memberArr);
			
			isNomal();
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler)
			back_click_mc.addEventListener(MouseEvent.CLICK,backClickHandler);
			sure_btn.addEventListener(MouseEvent.CLICK,sureClickHandler);			
        }		
		
		
		protected function backClickHandler(event:MouseEvent):void
		{
			if(_isClick==false)
			{
				TweenLite.to(click_sp,0.5,{y:click_sp.y+click_sp.height});				
			}else
			{
				TweenLite.to(click_sp,0.5,{y:click_sp.y-click_sp.height});
			}
			click_sp.mc_1.addEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_2.addEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_3.addEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_4.addEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_5.addEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_6.addEventListener(MouseEvent.CLICK,changeJobHandler);
			_isClick=!_isClick;
		}
		
		protected function changeJobHandler(event:MouseEvent):void
		{
			_isClick=false;
			TweenLite.to(click_sp,0.5,{y:click_sp.y-click_sp.height});
			switch(event.currentTarget)
			{
				case click_sp.mc_1:
				{
					_memberLevel=1;
					zhiwu_tf.text="军团长";
					break;
				}				
				case click_sp.mc_2:
				{
					_memberLevel=2;
					zhiwu_tf.text="副团长";
					break;
				}				
				case click_sp.mc_3:
				{
					_memberLevel=3;
					zhiwu_tf.text="执政官";
					break;
				}				
				case click_sp.mc_4:
				{
					_memberLevel=4;
					zhiwu_tf.text="高级指挥官";
					break;
				}				
				case click_sp.mc_5:
				{
					_memberLevel=5;
					zhiwu_tf.text="指挥官";
					break;
				}				
				case click_sp.mc_6:
				{
					_memberLevel=6;
					zhiwu_tf.text="普通成员";
					break;
				}				
			}
			
			click_sp.mc_1.removeEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_2.removeEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_3.removeEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_4.removeEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_5.removeEventListener(MouseEvent.CLICK,changeJobHandler);
			click_sp.mc_6.removeEventListener(MouseEvent.CLICK,changeJobHandler);
		}
		
		protected function sureClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new MemberManageEvent(_currentVo.player_id,memberLevel,maxNum,killNum));
		}
		
		private function clearContainer():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function upData(ListArr:Array):void
		{
			clearContainer();
			isNomal();
			for(var i:int=0;i<ListArr.length;i++)
			{
				var memberVo:GroupMemberListVo=ListArr[i] as GroupMemberListVo;
				var item:GroupItem_2Component=new GroupItem_2Component();
				item.contribution.text=memberVo.donate_dark_matter.toString();
				item.controlledNum.text=memberVo.controlledNum.toString();
				item.job.text=memberVo.job;
				item.paiMing.text=memberVo.rank.toString();
				item.userName.text=memberVo.username;
				item.currtentVo=memberVo;
				if(memberVo.vipLevel>0)
				{
					item.vip.visible=true;
				}else
				{
					item.vip.visible=false;
					
				}
				
				container.add(item);
				item.addEventListener(MouseEvent.CLICK,doClickHandler);
			}
			
			container.layout.update();
			vs_bar.viewport=container;
		}
		
		private function clickUpData(listvo:GroupMemberListVo):void
		{
			username_tf.text=listvo.username;
			zhiwu_tf.text=listvo.job;
			xianshi_tf.text=listvo.controlledNum.toString();
			_memberLevel=listvo.level;
			if(listvo.controlledNum==0)
			{
				checkbox_0.selected=false;
				checkbox_1.selected=false;
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
			}else if(listvo.controlledNum==1000)
			{
				checkbox_0.selected=true;
				checkbox_1.selected=true;
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
			}else if(listvo.controlledNum==5000)
			{
				checkbox_0.selected=true;
				checkbox_2.selected=true;
				checkbox_1.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
			}else if(listvo.controlledNum==10000)
			{
				checkbox_0.selected=true;
				checkbox_3.selected=true;
				checkbox_2.selected=false;
				checkbox_1.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
			}else if(listvo.controlledNum==50000)
			{
				checkbox_0.selected=true;
				checkbox_4.selected=true;
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_1.selected=false;
				checkbox_5.selected=false;
			}else if(listvo.controlledNum==100000)
			{
				checkbox_0.selected=true;
				checkbox_5.selected=true;
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_1.selected=false;
			}
			
			checkbox_6.selected=false;
			
			checkbox_0.addEventListener(Event.CHANGE,changeBox0_Handler);
			checkbox_1.addEventListener(Event.CHANGE,changeBox1_Handler);
			checkbox_2.addEventListener(Event.CHANGE,changeBox2_Handler);
			checkbox_3.addEventListener(Event.CHANGE,changeBox3_Handler);
			checkbox_4.addEventListener(Event.CHANGE,changeBox4_Handler);
			checkbox_5.addEventListener(Event.CHANGE,changeBox5_Handler);
		}
		
		protected function changeBox5_Handler(event:Event):void
		{
			if(checkbox_5.selected==true)
			{
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_1.selected=false;
				_maxNum=100000;
				xianshi_tf.text=_maxNum.toString();
			}
			changeBoxHandler();
		}
		
		protected function changeBox4_Handler(event:Event):void
		{
			if(checkbox_4.selected==true)
			{
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_1.selected=false;
				checkbox_5.selected=false;
				_maxNum=50000;
				xianshi_tf.text=_maxNum.toString();
			}
			changeBoxHandler();
		}
		
		protected function changeBox3_Handler(event:Event):void
		{
			if(checkbox_3.selected==true)
			{
				checkbox_2.selected=false;
				checkbox_1.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
				_maxNum=10000;
				xianshi_tf.text=_maxNum.toString();
			}
			changeBoxHandler();
		}
		
		protected function changeBox2_Handler(event:Event):void
		{
			if(checkbox_2.selected==true)
			{
				checkbox_1.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
				_maxNum=5000;
				xianshi_tf.text=_maxNum.toString();
			}
			changeBoxHandler();
		}
		
		protected function changeBox1_Handler(event:Event):void
		{
			if(checkbox_1.selected==true)
			{
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
				_maxNum=1000;
				xianshi_tf.text=_maxNum.toString();
			}
			changeBoxHandler();
		}
		
		protected function changeBox0_Handler(event:Event):void
		{
			if(checkbox_0.selected==false)
			{
				checkbox_1.selected=false;
				checkbox_2.selected=false;
				checkbox_3.selected=false;
				checkbox_4.selected=false;
				checkbox_5.selected=false;
				_maxNum=0;
				xianshi_tf.text=_maxNum.toString();				
			}
			
		}
		
		protected function changeBoxHandler():void
		{
			if(checkbox_1.selected==false&&checkbox_2.selected==false&&checkbox_3.selected==false
				&&checkbox_4.selected==false&&checkbox_5.selected==false)
			{
				checkbox_0.selected=false;
				_maxNum=0;
				xianshi_tf.text=_maxNum.toString();
				
			}else
			{
				checkbox_0.selected=true;
			}
		}
		
		
		protected function doClickHandler(event:MouseEvent):void
		{
			currentItem=event.currentTarget as GroupItem_2Component;
			var item:GroupItem_2Component=event.currentTarget as GroupItem_2Component;
			_currentVo=item.currtentVo;
			isClick();
			clickUpData(_currentVo);
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.CLOSE));
			checkbox_0.removeEventListener(Event.CHANGE,changeBox0_Handler);
			checkbox_1.removeEventListener(Event.CHANGE,changeBox1_Handler);
			checkbox_2.removeEventListener(Event.CHANGE,changeBox2_Handler);
			checkbox_3.removeEventListener(Event.CHANGE,changeBox3_Handler);
			checkbox_4.removeEventListener(Event.CHANGE,changeBox4_Handler);
			checkbox_5.removeEventListener(Event.CHANGE,changeBox5_Handler);
		}		
		
		public function isNomal():void
		{
			sprite_all.visible=false;
			mc_tishi.visible=true;
		}
		
		public function isClick():void
		{
			sprite_all.visible=true;
			mc_tishi.visible=false;
		}
		
		public function get currentItem():GroupItem_2Component
		{
			return _currentItem;
		}
		
		public function set currentItem(value:GroupItem_2Component):void
		{
			if(_currentItem!=null)
				_currentItem.back.visible=false;
			
			_currentItem = value;
			_currentItem.back.visible=true
		}

		public function get memberLevel():int
		{
			return _memberLevel;
		}

		public function get maxNum():int
		{
			return _maxNum;
		}

		public function get killNum():int
		{
			if(checkbox_6.selected==true)
			{
				_killNum=1;
			}else
			{
				_killNum=0;
			}
			return _killNum;
		}


    }
}