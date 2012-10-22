package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import events.factory.FactoryEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
    public class FactoryInfoComponent extends Component
    {
		public var gaiZhuangSp:Sprite;
		public var zhiZaoSp:Sprite;
		public var weiXiuSp:Sprite;
		
		public var titleText:Label;
		public var backBtn:Button;

		
        public function FactoryInfoComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryInfoSkin"));
			
			titleText=createUI(Label,"title_lable");
			backBtn=createUI(Button,"back_button");
			
			gaiZhuangSp=getSkin("gaizhuang_sp");
			zhiZaoSp=getSkin("zhizao_sp");
			weiXiuSp=getSkin("weixiu_sp");
			
			sortChildIndex();
			
			backBtn.addEventListener(MouseEvent.CLICK,closeHandler);
        }
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}
		
		public function isWeiXiu():void
		{
			titleText.text="维修工厂";
			gaiZhuangSp.visible=false;
			zhiZaoSp.visible=false;
			weiXiuSp.visible=true;
		}
		
		public function isGaiZhuang():void
		{
			titleText.text="改装工厂";
			gaiZhuangSp.visible=true;
			zhiZaoSp.visible=false;
			weiXiuSp.visible=false;
		}
		
		public function isZhiZao():void
		{
			titleText.text="制造工厂";
			gaiZhuangSp.visible=false;
			zhiZaoSp.visible=true;
			weiXiuSp.visible=false;
		}
	}
}