package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	
    public class FactoryChaKanComponent extends Component
    {
		//战车功能显示
		public var tf_2:Label;
		//详细信息显示
		public var tf_1:Label;
		
		public var mc_3:Sprite;
		
		public var title_tf:Label;
		
		public var item_sp:LoaderImage;
		
		public var fanhui_btn:Button;

		
        public function FactoryChaKanComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryChaKanSkin"));
			title_tf=createUI(Label,"title_tf");
			
			tf_1=createUI(Label,"tf_1");
			tf_2=createUI(Label,"tf_2");
			
			item_sp=createUI(LoaderImage,"item_sp");
			fanhui_btn=createUI(Button,"fanhui_btn");
			
			mc_3=getSkin("mc_3");
			
			sortChildIndex();
			
			fanhui_btn.addEventListener(MouseEvent.CLICK,closeHandler);
        }
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}
		
		public function upDataGuaJian(itemVo:GuaJianInfoVO):void
		{
			isGuaJian();
			item_sp.source=ResEnum.senceEquipment+itemVo.item_type+"_"+itemVo.category+".png";
			
			title_tf.text=itemVo.name;
			tf_1.text=itemVo.description;
			tf_2.text=itemVo.propertyDes;			
		}
		
		public function upDataZhanChe(itemVo:ZhanCheInfoVO):void
		{
			isZhanChe();
			item_sp.source=ResEnum.senceEquipment+itemVo.item_type+"_"+itemVo.category+".png";
			
			title_tf.text=itemVo.name;
			tf_1.text=itemVo.description;
			tf_2.text=itemVo.propertyDes;			
		}
		
		private function isZhanChe():void
		{
			mc_3.visible=false;
		}
		
		private function isGuaJian():void
		{
			mc_3.visible=true;
		}
		
	}
}