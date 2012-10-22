package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.factory.FactoryEnum;
	
	import events.factory.FactoryEvent;
	import events.factory.FactoryItemEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import proxy.packageView.PackageViewProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.factory.DrawListVo;
	
    public class FactoryMakeComponent extends Component
    {
		public var fanHuiBtn:Button;
		
		public var sprite:Sprite;
		
		public var vsBar:VScrollBar;
		
		public var tishi_mc:Sprite;

		private var container:Container;
		
		private var _packageProxy:PackageViewProxy;
		
		
		private var _arr:Array=[];
		private var list:Array=[];
		private var _drawList:Array=[];
        public function FactoryMakeComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryMakeSkin"));
			
			_packageProxy=ApplicationFacade.getProxy(PackageViewProxy);
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			sprite=getSkin("sprite");
			tishi_mc=getSkin("tishi_mc");
			
			sortChildIndex();
			
			container = new Container(null);
			container.contentWidth = sprite.width;
			container.contentHeight = sprite.height;
			container.layout = new HTileLayout(container);
			container.x = 0;
			container.y = 0;
			
			tishi_mc.visible=false;
			fanHuiBtn.addEventListener(MouseEvent.CLICK,closeHandler);
        }
				
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}
		
		public function addContainerGuaJian(arr:Array):void
		{
			if(arr.length==0)
			{
				tishi_mc.visible=true;
				return;
			}else
			{
				tishi_mc.visible=false;
			}
				
			
			list.length=0;
			_arr.length=0;
			for(var i:int=0;i<arr.length;i++)
			{
				var drawVo:DrawListVo=arr[i] as DrawListVo;
				var item:FactoryItem_1Component=new FactoryItem_1Component;				
				var guajianVo:GuaJianInfoVO=_packageProxy.createGuaJianVO(drawVo);
				item.drawVo=drawVo;
				if(drawVo.eventID!=null)
				{
					item.isMake();
					var num:Number;
					num=1-(drawVo.remainTime/(drawVo.finish_time-drawVo.start_time));
					item.setTweenLine(drawVo.remainTime,null,num);
					
				}else
				{
					item.isNotMake();
				}
				
				item.anwuzhi_tf.text=guajianVo.broken_crystal.toString();
				item.chuanqi_tf.text=guajianVo.tritium .toString();
				if(guajianVo.dark_crystal!=0)
				{
					item.shuijin_tf .text=guajianVo.dark_crystal .toString();
					item.shuijin_mc.visible=true;
				}else
				{
					item.shuijin_mc.visible=false;
					item.shuijin_tf.visible=false;
				}
				item.title_tf.text=guajianVo.name;
				item.level_tf.text="等级:"+guajianVo.level.toString();
				item.pingfen_tf.text=guajianVo.value.toString();
				item.time_tf1.text=guajianVo.time.toString();		
				item.item_sp.source=ResEnum.senceEquipment+guajianVo.item_type+"_"+guajianVo.category+".png";
				
				_arr.push(item);
				addClickHandler(item);
				list.push(guajianVo);
				_drawList.push(drawVo);
				
				container.add(item);
				container.layout.update();
			}
			sprite.addChild(container);
			vsBar.viewport=container;
		}
		
		private function addClickHandler(item:FactoryItem_1Component):void
		{
			item.zhizao_btn.addEventListener(MouseEvent.CLICK,doZhiZaoHandler);
			item.jiasu_btn.addEventListener(MouseEvent.CLICK,doSpeedUpHandler);
			item.info_btn.addEventListener(MouseEvent.CLICK,infoHandler);
		}
		
		public function addContainerZhanChe(arr:Array):void
		{
			if(arr.length==0)
			{
				tishi_mc.visible=true;
				return;
			}else
			{
				tishi_mc.visible=false;
			}
			
			list.length=0;
			_arr.length=0;
			
			for(var i:int=0;i<arr.length;i++)
			{
				var drawVo:DrawListVo=arr[i] as DrawListVo;
				var item:FactoryItem_1Component=new FactoryItem_1Component;
				item.drawVo=drawVo;
				if(drawVo.eventID!=null)
				{
					item.isMake();
					var num:Number;
					num=1-(drawVo.remainTime/((drawVo.finish_time-drawVo.start_time)*1000));
					item.setTweenLine(drawVo.remainTime,null,num);
					
				}else
				{
					item.isNotMake();
				}
				
				var zhancheVo:ZhanCheInfoVO=_packageProxy.createZhanCheVO(drawVo);
				item.anwuzhi_tf.text=zhancheVo.broken_crystal.toString();
				item.chuanqi_tf.text=zhancheVo.tritium .toString();
				if(zhancheVo.dark_crystal!=0)
				{
					item.shuijin_tf .text=zhancheVo.dark_crystal .toString();
					item.shuijin_mc.visible=true;
				}else
				{
					item.shuijin_mc.visible=false;
					item.shuijin_tf.visible=false;
				}
				item.title_tf.text=zhancheVo.name;
				item.level_tf.text="等级:"+zhancheVo.level.toString();
				item.pingfen_tf.text=zhancheVo.value.toString();
				item.time_tf1.text=zhancheVo.time.toString();
				item.item_sp.source=ResEnum.senceEquipment+zhancheVo.item_type+"_"+zhancheVo.category+".png";
				
				_arr.push(item);
				addClickHandler(item);
				list.push(zhancheVo);
				_drawList.push(drawVo);
				
				container.add(item);
				container.layout.update();
				
			}
			sprite.addChild(container);
			vsBar.viewport=container;
		}
		
		protected function infoHandler(event:MouseEvent):void
		{
			var item:FactoryItem_1Component=event.target.parent as FactoryItem_1Component;
			for(var i:int;i<_arr.length;i++)
			{
				if(item==_arr[i])
				{
					var packageProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
					FactoryEnum.CURRENT_VO=list[i] as BaseItemVO;
					dispatchEvent(new FactoryEvent(FactoryEvent.SHOW_INFO_EVENT));
				}
			}
		}
		
		protected function doSpeedUpHandler(event:MouseEvent):void
		{
			var item:FactoryItem_1Component=event.target.parent as FactoryItem_1Component;
			for(var i:int;i<_arr.length;i++)
			{
				if(item==_arr[i])
				{
					FactoryEnum.CURRENT_VO=list[i] as BaseItemVO;
//					FactoryEnum.CURRENT_DRAWVO=_drawList[i] as DrawListVo;
					dispatchEvent(new FactoryEvent(FactoryEvent.SPEEDUP_EVENT,item));
				}
			}
		}
		
		protected function doZhiZaoHandler(event:MouseEvent):void
		{
			var item:FactoryItem_1Component=event.target.parent as FactoryItem_1Component;
			for(var i:int;i<_arr.length;i++)
			{
				if(item==_arr[i])
				{
					var packageProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
					FactoryEnum.CURRENT_VO=packageProxy.chakanVO=list[i] as BaseItemVO;
					dispatchEvent(new FactoryEvent(FactoryEvent.MAKE_EVENT,item));
				}
			}
		}	
		
    }
}