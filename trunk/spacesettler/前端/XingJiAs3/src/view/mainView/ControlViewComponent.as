package view.mainView
{
	import events.allView.AllViewEvent;
	import events.buildingView.ZhuJiDiEvent;
	import events.talk.TalkEvent;
	
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
			
			systemBtn.addEventListener(MouseEvent.CLICK,rongYU_clickHandler);
			rankingBtn.addEventListener(MouseEvent.CLICK,zhongLan_clickHandler);
			
		}
		
		private function rongYU_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.RONGYU_EVENT,true,true));
		}
		
		private function zhongLan_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.ALLVIEW_EVENT,true,true));
		}
	}
}