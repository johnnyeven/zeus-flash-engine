package view.cangKu
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.ResEnum;
	
	import events.cangKu.ChaKanEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.packageView.PackageViewProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.layouts.VLayout;
	
	import vo.cangKu.GuaJianInfoVO;
	
	public class ChaKanGuaJianViewComponent extends Component
	{
		public var wpName:Label;
		public var wplevel:Label;
		public var wpScore:Label;
		public var wpType:Label;
		public var wpImage:LoaderImage;
		public var wpTypeImage:LoaderImage;
		public var backBtn:Button;
		public var desLabel:Label;
		
		public function ChaKanGuaJianViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			wpName=createUI(Label,"wpName_tf");
			wplevel=createUI(Label,"level_tf");
			wpScore=createUI(Label,"score_tf");
			wpType=createUI(Label,"type_tf");
			wpImage=createUI(LoaderImage,"wp_image");
			wpTypeImage=createUI(LoaderImage,"wpType_image");
			backBtn=createUI(Button,"back_btn");
			desLabel=createUI(Label,"desLabel");
			desLabel.vGap=4;
			desLabel.hGap=4;
			
			sortChildIndex();
			
			backBtn.addEventListener(MouseEvent.CLICK,backBtn_clickHandler);
			
			var packageProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
			setValue(packageProxy.chakanVO as GuaJianInfoVO);
		}
		
		public function setValue(info:GuaJianInfoVO):void
		{
			if(info==null)
				return;
			wpName.text=info.name;
			wplevel.text=info.level+"";
			wpScore.text=info.value+"";
			switch(info.slot_type)
			{
				case 1:
					wpType.text=MultilanguageManager.getString("GuaJianTypeBig");
					wpTypeImage.source=ResEnum.senceEquipment+"enhanceType1.png";
					break;
				case 2:
					wpType.text=MultilanguageManager.getString("GuaJianTypeMid");
					wpTypeImage.source=ResEnum.senceEquipment+"enhanceType2.png";
					break;
				case 3:
					wpType.text=MultilanguageManager.getString("GuaJianTypeSmall");
					wpTypeImage.source=ResEnum.senceEquipment+"enhanceType3.png";
					break;
			}
			
			wpImage.source=ResEnum.senceEquipment+info.item_type+"_"+info.category+".png";
			
			desLabel.text=info.propertyDes;
		}
		
		protected function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ChaKanEvent(ChaKanEvent.CLOSEVIEW_EVENT));
		}
		
	}
}