package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
    public class FactoryItem_3Component extends Component
    {
		public var level_lable:Label;
		
		public var title_lable:Label;
		
		public var item_sp:LoaderImage;
		
		public var mc_3:Sprite;
		
		public var mc_2:Sprite;
		
		public var mc_1:Sprite;
		
		public var mask_mc:Sprite;

		
        public function FactoryItem_3Component()
        {
            super(ClassUtil.getObject("view.factory.FactoryItem_3"));
			
			level_lable=createUI(Label,"level_lable");
			title_lable=createUI(Label,"title_lable");
			item_sp=createUI(LoaderImage,"item_sp");
			
			mc_3=getSkin("mc_3");
			mc_2=getSkin("mc_2");
			mc_1=getSkin("mc_1");
			mask_mc=getSkin("mask_mc");
			
			sortChildIndex();

		}
		
		public function isNomal():void
		{
			mc_3.visible=false;
			mc_2.visible=false;
			mc_1.visible=false;
		}
		
		public function isTypeOne():void
		{
			mc_3.visible=false;
			mc_2.visible=false;
			mc_1.visible=true;
		}
		
		public function isTypeTwo():void
		{
			mc_3.visible=false;
			mc_2.visible=true;
			mc_1.visible=false;
		}
		
		public function isTypeThree():void
		{
			mc_3.visible=true;
			mc_2.visible=false;
			mc_1.visible=false;
		}
		
		public function canUse():void
		{
			mask_mc.visible=false;
			this.mouseEnabled=true;
		}
		
		public function canNotUse():void
		{
			mask_mc.visible=true;
			this.mouseEnabled=false;
		}
    }
}