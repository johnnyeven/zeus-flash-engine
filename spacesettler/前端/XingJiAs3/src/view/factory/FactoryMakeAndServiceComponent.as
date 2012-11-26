package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.factory.FactoryEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.battle.BattleProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.HScrollBar;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.layouts.VTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.cangKu.ZhanCheInfoVO;
	
    public class FactoryMakeAndServiceComponent extends Component
    {
		//初显示 分三种情况
		public var jiaZaiBtn:Button;
		public var back_mc:Sprite;
		public var closeBtn:Button;
		public var infoBtn:Button;
		public var weiXiuSp:Component;
		public var zhiZaoSp:Component;
		public var titleLable:Label;
		
		//制造按钮 分三个 武器 挂件 战车 的制造按钮  制造页面
		public var guaJianMakeBtn:Button;
		public var wuQiMakeBtn:Button;
		public var zhanCheMakeBtn:Button;

		//维修页面
		/**
		 *战车图片SP 
		 */		
		public var itemSp:LoaderImage;
		
		/**
		 *战车名 
		 */		
		public var titleTf:Label;
		
		/**
		 *战车level
		 */		
		public var levelTf:Label;
		
		/**
		 *评分
		 */		
		public var pingFenTf:Label;
		
		/**
		 *维修所需物资
		 */		
		public var wuZhiTf:Label;
		
		/**
		 *回收废料
		 */		
		public var feiLiaoTf:Label;
		
		//战车三种状态 完好 损坏 报废
		public var wanhao_mc:Sprite;
		public var sunhuai_mc:Sprite;
		public var baofei_mc:Sprite;
		
		//维修按钮 和 回收 按钮
		public var weiXiuBtn:Button;
		public var huiShouBtn:Button;
		
		public var hsBar:HScrollBar;
		public var sprite:Sprite;
		public var tishi_mc:Sprite;
		
		private var container:Container;
		private var battleProxy:BattleProxy;
		private var _currtentItem:FactoryItem_2Component=null;
		private var itemArr:Array=[];
		private var arr:Array=[];
        public function FactoryMakeAndServiceComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryMakeAndServiceSkin"));
			
			jiaZaiBtn=createUI(Button,"jiazai_btn");
			closeBtn=createUI(Button,"close_btn");
			infoBtn=createUI(Button,"info_btn");
			weiXiuSp=createUI(Component,"weixiu_sp");
			zhiZaoSp=createUI(Component,"zhizao_sp");
			titleLable=createUI(Label,"title_lable");
			tishi_mc=getSkin("tishi_mc");
			back_mc=getSkin("back_mc");
			
			wuQiMakeBtn=zhiZaoSp.createUI(Button,"btn_2");
			guaJianMakeBtn=zhiZaoSp.createUI(Button,"btn_3");
			zhanCheMakeBtn=zhiZaoSp.createUI(Button,"btn_1");
			
			itemSp=weiXiuSp.createUI(LoaderImage,"sprite")
			wanhao_mc=weiXiuSp.getSkin("wanhao_mc");
			sunhuai_mc=weiXiuSp.getSkin("sunhuai_mc");
			baofei_mc=weiXiuSp.getSkin("baofei_mc");
			titleTf=weiXiuSp.createUI(Label,"title_tf");
			levelTf=weiXiuSp.createUI(Label,"level_tf");
			pingFenTf=weiXiuSp.createUI(Label,"pingfen_tf");
			wuZhiTf=weiXiuSp.createUI(Label,"wuzhi_tf");
			feiLiaoTf=weiXiuSp.createUI(Label,"feiliao_tf");
			
			weiXiuBtn=weiXiuSp.createUI(Button,"weixiu_btn");
			huiShouBtn=weiXiuSp.createUI(Button,"huishou_btn");
			hsBar=weiXiuSp.createUI(HScrollBar,"hs_bar");
			sprite=weiXiuSp.getSkin("item_sp");
			
			zhiZaoSp.sortChildIndex();
			weiXiuSp.sortChildIndex();
			sortChildIndex();	
			
			weiXiuSp.visible=false;
			zhiZaoSp.visible=false;
			jiaZaiBtn.visible=false;
			back_mc.visible=false;
			
			container = new Container(null);
			container.contentWidth = sprite.width;
			container.contentHeight = sprite.height;
			container.layout = new VTileLayout(container);
			container.layout.hGap = 0;
			container.x = 0;
			container.y = 0;
			sprite.addChild(container);
			
			weiXiuBtn.mouseChildren=weiXiuBtn.mouseEnabled=false;
			huiShouBtn.mouseChildren=huiShouBtn.mouseEnabled=false;
			tishi_mc.visible=false;
			
			weiXiuBtn.addEventListener(MouseEvent.CLICK,weiXiuHandler);
			huiShouBtn.addEventListener(MouseEvent.CLICK,huiShouHandler);
			
			guaJianMakeBtn.addEventListener(MouseEvent.CLICK,makeGuaJianHandler);
			wuQiMakeBtn.addEventListener(MouseEvent.CLICK,makeWuQiHandler);
			zhanCheMakeBtn.addEventListener(MouseEvent.CLICK,makeZhanCheHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			infoBtn.addEventListener(MouseEvent.CLICK,infoHandler);
			jiaZaiBtn.addEventListener(MouseEvent.CLICK,jiaZaiHandler);
        }
				
		public function upData(info:ZhanCheInfoVO):void
		{
			itemSp.source=ResEnum.senceEquipment+info.item_type+"_"+info.category+".png";
			
			titleTf.text=info.name
			levelTf.text=info.level.toString();
			pingFenTf.text=info.value.toString();
			feiLiaoTf.text=info.recycle_price_broken_crystal.toString();
			wuZhiTf.text=info.repair_cost_broken_crystal.toString();
			
			if(info.current_endurance==0)
				isBaoFei();
			if(info.repair_cost_broken_crystal!=0)
				isSunHuai();
			if(info.repair_cost_broken_crystal==0)
				isWanHao();
		}
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function changeContainer(array:Array):void
		{
			if(array.length==0)
			{
				tishi_mc.visible=true;
				weiXiuSp.visible=false;
				return;
			}else
			{
				tishi_mc.visible=false;
				weiXiuSp.visible=true;
			}
			
			removeAllItem();
			itemArr.length=0;
			arr=array;			
			
			if(FactoryEnum.CURRENT_ZHANCHE_VO==null)
			{				
				FactoryEnum.CURRENT_ZHANCHE_VO=array[0] as ZhanCheInfoVO;
				currtentItem=itemArr[0] as FactoryItem_2Component;
			}			
			for(var i:int=0;i<array.length;i++)
			{
				var zhancheVo:ZhanCheInfoVO=array[i] as ZhanCheInfoVO;
				var item:FactoryItem_2Component=new FactoryItem_2Component();
				item.level_tf.text=zhancheVo.level.toString();
				item.title_tf.text=zhancheVo.name+"战车";
				item.item_sp.source=ResEnum.senceEquipment+zhancheVo.item_type+"_"+zhancheVo.category+".png";
				itemArr.push(item);
				container.add(item);
				
				if(FactoryEnum.CURRENT_ZHANCHE_VO.id==zhancheVo.id)
				{
					FactoryEnum.CURRENT_ZHANCHE_VO=zhancheVo;
					currtentItem=item;					
				}
				
				item.addEventListener(MouseEvent.CLICK,clickHandler);
			}
			upData(FactoryEnum.CURRENT_ZHANCHE_VO);
			container.layout.update();			
			hsBar.viewport=container;			
		}		
		
		protected function clickHandler(event:MouseEvent):void
		{
			var item:FactoryItem_2Component=event.currentTarget as FactoryItem_2Component;
			currtentItem=item;
			for(var i:int=0;i<itemArr.length;i++)
			{
				if(itemArr[i]==item)
				{
					FactoryEnum.CURRENT_ZHANCHE_VO=arr[i] as ZhanCheInfoVO;
					upData(FactoryEnum.CURRENT_ZHANCHE_VO);
				}
			}
		}
		
		protected function infoHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.SHOW_INFO_EVENT));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}
		
		protected function huiShouHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.HUISHOU_EVENT));
		}
		
		protected function weiXiuHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.WEIXIU_EVENT));
		}
		
		protected function makeZhanCheHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.MAKE_ZHANCHE_EVENT));
		}
		
		protected function makeWuQiHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.MAKE_WUQI_EVENT));
		}
		
		protected function makeGuaJianHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.MAKE_GUAJIAN_EVENT));
		}
				
		protected function jiaZaiHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.LOAD_ZHANCHE_EVENT));
		}
		
		public function isWeiXiu():void
		{
			jiaZaiBtn.visible=false;
			weiXiuSp.visible=true;
			zhiZaoSp.visible=false;
			titleLable.text="维修工厂";
			guaJianMakeBtn.mouseEnabled=false;
			wuQiMakeBtn.mouseEnabled=false;
			zhanCheMakeBtn.mouseEnabled=false;
			
		}
		
		public function isGaiZhuang():void
		{
			back_mc.visible=true;
			jiaZaiBtn.visible=true;
			weiXiuSp.visible=false;
			zhiZaoSp.visible=false;
			titleLable.text="改装工厂";
			guaJianMakeBtn.mouseEnabled=false;
			wuQiMakeBtn.mouseEnabled=false;
			zhanCheMakeBtn.mouseEnabled=false;
		}
		
		public function isZhiZao():void
		{
			jiaZaiBtn.visible=false;
			weiXiuSp.visible=false;
			zhiZaoSp.visible=true;
			titleLable.text="制造工厂";
			guaJianMakeBtn.mouseEnabled=true;
			wuQiMakeBtn.mouseEnabled=true;
			zhanCheMakeBtn.mouseEnabled=true;
		}
		
		public function isSunHuai():void
		{
			wanhao_mc.visible=false;
			sunhuai_mc.visible=true;
			baofei_mc.visible=false;
			weiXiuBtn.mouseEnabled=weiXiuBtn.mouseChildren=true;
			huiShouBtn.mouseEnabled=huiShouBtn.mouseChildren=true;
		}
		
		public function isBaoFei():void
		{
			wanhao_mc.visible=false;
			sunhuai_mc.visible=false;
			baofei_mc.visible=true;
			weiXiuBtn.mouseEnabled=weiXiuBtn.mouseChildren=true;
			huiShouBtn.mouseEnabled=huiShouBtn.mouseChildren=true;
		}
		
		public function isWanHao():void
		{
			wanhao_mc.visible=true;
			sunhuai_mc.visible=false;
			baofei_mc.visible=false;
			weiXiuBtn.mouseEnabled=weiXiuBtn.mouseChildren=false;
			huiShouBtn.mouseEnabled=huiShouBtn.mouseChildren=true;
			wuZhiTf.text="0";
		}
		
		public function get currtentItem():FactoryItem_2Component
		{
			return _currtentItem;
		}
		
		public function set currtentItem(value:FactoryItem_2Component):void
		{
			if(_currtentItem)
				_currtentItem.mask_mc.visible=true;
			
			_currtentItem = value;
			if(_currtentItem)
				_currtentItem.isClick();
		}
    }
}