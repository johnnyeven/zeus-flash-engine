package view.mainView
{
	import flash.display.DisplayObjectContainer;
	
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
		public var junTuanBtn:Button;
		
		/**
		 * 商城按钮
		 */		
		public var shangChengBtn:Button;
		
		/**
		 * 武器库按钮
		 */		
		public var wuQiKuBtn:Button;
		
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
			junTuanBtn=createUI(Button,"juntuan_btn");
			shangChengBtn=createUI(Button,"shangcheng_btn");
			wuQiKuBtn=createUI(Button,"wuqiku_btn");
			auctionBtn=createUI(Button,"paimai_btn");
			mailBtn=createUI(Button,"youjian_btn");
			rankingBtn=createUI(Button,"paiming_btn");
			systemBtn=createUI(Button,"xitong_btn");
			
			sortChildIndex();
			
		}
	}
}