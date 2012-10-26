package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.cangKu.GuaJianInfoVO;
	
    public class FactoryClickSpComponent extends Component
    {
		public var mc_3:Sprite;
		public var mc_2:Sprite;
		public var mc_1:Sprite;
		public var click_mc:Sprite;
		
		/**
		 *加载图片 
		 */		
		public var item_sp:LoaderImage;

		public var isLoader:Boolean;
		public var sp:Sprite;
		private var _guajianVo:GuaJianInfoVO;
        public function FactoryClickSpComponent(skin:DisplayObjectContainer)
        {
            super(null);
			_guajianVo=new GuaJianInfoVO();
			sp=skin as Sprite;
			item_sp=new LoaderImage(sp.getChildByName("item_sp") as Sprite);
			
			mc_3=sp.getChildByName("mc_3") as Sprite;
			mc_2=sp.getChildByName("mc_2") as Sprite;
			mc_1=sp.getChildByName("mc_1") as Sprite;
			click_mc=sp.getChildByName("click_mc") as Sprite;
			
			x=sp.x;
			y=sp.y;
			
			sp.x=sp.y=0;
			item_sp.x=-22;
			item_sp.y=-22;
			
			isLoader=false;
			
			addChild(sp);
			addChild(item_sp);
			isNotClick();
        }
		
		public function isClick():void
		{
			click_mc.visible=true;
		}
		
		public function isNotClick():void
		{
			click_mc.visible=false;
		}
		
		public function isOne():void
		{
			mc_1.visible=true;
			mc_2.visible=false;
			mc_3.visible=false;			
		}
		
		public function isTwo():void
		{
			mc_1.visible=false;
			mc_2.visible=true;
			mc_3.visible=false;
		}
		
		public function isThree():void
		{
			mc_1.visible=false;
			mc_2.visible=false;
			mc_3.visible=true;
		}
		
		public function isNomal():void
		{
			mc_1.visible=false;
			mc_2.visible=false;
			mc_3.visible=false;
		}

		public function get guajianVo():GuaJianInfoVO
		{
			return _guajianVo;
		}

		public function set guajianVo(value:GuaJianInfoVO):void
		{
			_guajianVo = value;
		}
		
		
    }
}