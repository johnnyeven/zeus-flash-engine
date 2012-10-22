package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	import enum.item.SlotEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	
    public class FactoryArmsComponent extends Component
    {
		public var fanhui_btn:Button;
		
		public var item_sp:Sprite;
		
		public var vsBar:VScrollBar;
		
		public var tishi_mc_1:Sprite;
		public var tishi_mc_2:Sprite;

		private var _arr:Array=[];
		private var itemArr:Array=[];
		private var container:Container;
		private var currtentVo:BaseItemVO;
        public function FactoryArmsComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryArmsSkin"));
			
			fanhui_btn=createUI(Button,"fanhui_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			item_sp=getSkin("item_sp");
			tishi_mc_1=getSkin("tishi_mc_1");
			tishi_mc_2=getSkin("tishi_mc_2");
			
			sortChildIndex();
			
			currtentVo=new BaseItemVO();
			tishi_mc_1.visible=false;
			tishi_mc_2.visible=false;
			
			container = new Container(null);
			container.contentWidth = item_sp.width;
			container.contentHeight = item_sp.height;
			container.layout = new HTileLayout(container);
			container.layout.vGap = 2;
			container.layout.hGap = 2;
			container.x = 0;
			container.y = 0;
			
			fanhui_btn.addEventListener(MouseEvent.CLICK,closeHandler);
        }
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		
		public function changeContainerWuQi(array:Array):void
		{
			
			currtentVo.item_type=ItemEnum.Chariot;
			
			if(array.length==0)
			{
				tishi_mc_1.visible=true;
				return;
			}else
			{
				tishi_mc_1.visible=false;
			}
			
			_arr=array;
			itemArr.length=0;
			removeAllItem();
			
			for(var i:int=0;i<array.length;i++)
			{
				var zhancheVo:ZhanCheInfoVO=array[i] as ZhanCheInfoVO;
				var item:FactoryItem_3Component=new FactoryItem_3Component();
				
				item.title_lable.text=zhancheVo.name+"战车";
				item.level_lable.text=zhancheVo.level.toString()+"级";
				item.item_sp.source=ResEnum.senceEquipment+zhancheVo.item_type+"_"+zhancheVo.category+".png";
				item.isNomal();
				item.canUse();
				itemArr.push(item);
				container.add(item);
				
				item.addEventListener(MouseEvent.CLICK,zhanCheClickHandler);
			}
			
			container.layout.update();			
			item_sp.addChild(container);
			vsBar.viewport=container;
			
		}
		
		protected function zhanCheClickHandler(event:MouseEvent):void
		{
			var item:FactoryItem_3Component=event.currentTarget as FactoryItem_3Component;
			for(var i:int=0;i<itemArr.length;i++)
			{
				if(itemArr[i]==item)
				{
					if(currtentVo.item_type==ItemEnum.Chariot)
					{
						FactoryEnum.CURRENT_ZHANCHE_VO=_arr[i] as ZhanCheInfoVO;
						dispatchEvent(new FactoryEvent(FactoryEvent.LOAD_ZHANCHE_COMPLETE_EVENT));						
					}else
					{
						FactoryEnum.CURRENT_GUAJIAN_VO=_arr[i] as GuaJianInfoVO;
						dispatchEvent(new FactoryEvent(FactoryEvent.LOAD_GUAJIAN_COMPLETE_EVENT));
					}
				}
			}
				
		}
		
		public function changeContainerGuaJian(array:Array):void
		{
			currtentVo.item_type=ItemEnum.TankPart;
			
			if(array.length==0)
			{
				tishi_mc_2.visible=true;
				return;
			}else
			{
				tishi_mc_2.visible=false;
			}
			
			_arr=array;
			itemArr.length=0;
			removeAllItem();
			
			for(var i:int=0;i<array.length;i++)
			{
				var guajianVo:GuaJianInfoVO=array[i] as GuaJianInfoVO;
				if(guajianVo.is_mounted)
					return;
				
				var item:FactoryItem_3Component=new FactoryItem_3Component();
				
				item.title_lable.text=guajianVo.name;
				item.level_lable.text=guajianVo.level.toString();
				item.item_sp.source=ResEnum.senceEquipment+guajianVo.item_type+"_"+guajianVo.category+".png";
				if(guajianVo.slot_type==FactoryEnum.CURRENT_TYPE)
				{
					item.canUse();
				}else
				{
					item.canNotUse();
				}
				if(guajianVo.slot_type==SlotEnum.BIG)
					item.isTypeThree();
				if(guajianVo.slot_type==SlotEnum.MID)
					item.isTypeTwo();
				if(guajianVo.slot_type==SlotEnum.SMALL)
					item.isTypeOne();					
					
				itemArr.push(item);
				container.add(item);
				
				item.addEventListener(MouseEvent.CLICK,zhanCheClickHandler);
			}
			
			container.layout.update();
			item_sp.addChild(container);
			vsBar.viewport=container;
		}
		
		
		
    }
}