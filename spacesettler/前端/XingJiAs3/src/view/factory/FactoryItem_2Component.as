package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
    public class FactoryItem_2Component extends Component
    {
		public var mask_mc:Sprite;
		
		/**
		 *load图标的SP 
		 */		
		public var item_sp:LoaderImage;
		
		/**
		 *等级 
		 */		
		public var level_tf:Label;
		
		/**
		 *名称 
		 */		
		public var title_tf:Label;

		
        public function FactoryItem_2Component()
        {
            super(ClassUtil.getObject("view.factory.FactoryItem_2"));
			
			level_tf=createUI(Label,"level_tf");
			title_tf=createUI(Label,"title_tf");
			item_sp=createUI(LoaderImage,"item_sp");
			
			mask_mc=getSkin("mask_mc");
			
			
			sortChildIndex();
        }
		
		public function isClick():void
		{
			mask_mc.visible=false;
		}
    }
}