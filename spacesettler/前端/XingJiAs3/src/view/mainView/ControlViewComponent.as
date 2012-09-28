package view.mainView
{
	import events.allView.AllViewEvent;
	import events.buildingView.ZhuJiDiEvent;
	import events.talk.TalkEvent;
	import events.timeMachine.TimeMachineEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	public class ControlViewComponent extends Component
	{	
		/**
		 * 基地按钮
		 */		
		public var baseBtn:Button;
		
		/**
		 * 行星按钮
		 */		
		public var planetBtn:Button;
		
		/**
		 * 军团按钮
		 */		
		public var armyGroupBtn:Button;
		
		/**
		 * 商城按钮
		 */		
		public var shopBtn:Button;
		
		/**
		 * 武器库按钮
		 */		
		public var arsenalBtn:Button;
		
		/**
		 * 拍卖按钮
		 */		
		public var auctionBtn:Button;
		
		/**
		 * 邮件按钮
		 */		
		public var mailBtn:Button;
		
		/**
		 * 排名按钮
		 */		
		public var rankingBtn:Button;

		/**
		 * 系统按钮
		 */		
		public var systemBtn:Button;
		
		private var _currentSelcetedBtn:Button;
		public function ControlViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			baseBtn=createUI(Button,"jidi_btn");
			planetBtn=createUI(Button,"xingxingdai_btn");
			armyGroupBtn=createUI(Button,"juntuan_btn");
			shopBtn=createUI(Button,"shangcheng_btn");
			arsenalBtn=createUI(Button,"wuqiku_btn");
			auctionBtn=createUI(Button,"paimai_btn");
			mailBtn=createUI(Button,"youjian_btn");
			rankingBtn=createUI(Button,"paiming_btn");
			systemBtn=createUI(Button,"xitong_btn");
			
			sortChildIndex();
			
			baseBtn.toggle=true;
			planetBtn.toggle=true;
			armyGroupBtn.toggle=true;
			shopBtn.toggle=true;
			arsenalBtn.toggle=true;
			auctionBtn.toggle=true;
			mailBtn.toggle=true;
			rankingBtn.toggle=true;
			systemBtn.toggle=true;
			currentSelcetedBtn=baseBtn;
			
			baseBtn.addEventListener(MouseEvent.CLICK,base_clickHandler);
			auctionBtn.addEventListener(MouseEvent.CLICK,auction_clickHandler);
			armyGroupBtn.addEventListener(MouseEvent.CLICK,armyGroup_clickHandler);
			mailBtn.addEventListener(MouseEvent.CLICK,mail_clickHandler);
//			systemBtn.addEventListener(MouseEvent.CLICK,rongYU_clickHandler);
//			rankingBtn.addEventListener(MouseEvent.CLICK,zhongLan_clickHandler);
//			mailBtn.addEventListener(MouseEvent.CLICK,timeMachine_clickHandler);
			systemBtn.addEventListener(MouseEvent.CLICK,system_clickHandler);
			rankingBtn.addEventListener(MouseEvent.CLICK,zhongLan_clickHandler);
			mailBtn.addEventListener(MouseEvent.CLICK,timeMachine_clickHandler);
			
			arsenalBtn.addEventListener(MouseEvent.CLICK,cangKu_clickHandler);
			shopBtn.addEventListener(MouseEvent.CLICK,shop_clickHandler);
			planetBtn.addEventListener(MouseEvent.CLICK,planetBtn_clickHandler);
		}
		
		protected function base_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.MAIN_SENCE_EVENT,true,true));
			currentSelcetedBtn=baseBtn;
		}
		
		protected function auction_clickHandler(event:MouseEvent):void
		{
			currentSelcetedBtn=auctionBtn;
		}
		
		protected function armyGroup_clickHandler(event:MouseEvent):void
		{
			currentSelcetedBtn=armyGroupBtn;	
		}
		
		protected function mail_clickHandler(event:MouseEvent):void
		{
			currentSelcetedBtn=mailBtn;
		}
		
		protected function shop_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.SHOP_EVENT,true,true));
			currentSelcetedBtn=shopBtn;
		}
		
		private function system_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.SYSTEM_EVENT,true,true));
			currentSelcetedBtn=systemBtn;
		}
		
		private function zhongLan_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.ALLVIEW_EVENT,true,true));
			currentSelcetedBtn=rankingBtn;
		}
		private function timeMachine_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SHOW_COMPONENT_EVENT,0,0,true,true));
		}
		
		private function cangKu_clickHandler(Event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.CANGKU_EVENT,true,true));
			currentSelcetedBtn=arsenalBtn;
		}
		protected function planetBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.PLANET_EVENT,true,true));
			currentSelcetedBtn=planetBtn;
		}

		public function get currentSelcetedBtn():Button
		{
			return _currentSelcetedBtn;
		}

		public function set currentSelcetedBtn(value:Button):void
		{			
			if(_currentSelcetedBtn)
			{
				_currentSelcetedBtn.selected=false;
				_currentSelcetedBtn=null;
			}
			_currentSelcetedBtn = value;
			
			_currentSelcetedBtn.selected=true;
		}

	}
}