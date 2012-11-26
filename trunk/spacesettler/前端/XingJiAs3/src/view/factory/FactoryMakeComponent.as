package view.factory
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import events.buildingView.ConditionEvent;
	import events.factory.FactoryEvent;
	import events.factory.FactoryItemEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	
	import proxy.packageView.PackageViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.factory.DrawListVo;
	import vo.userInfo.UserInfoVO;
	
    public class FactoryMakeComponent extends Component
    {
		public var fanHuiBtn:Button;
		
		public var sprite:Sprite;
		
		public var vsBar:VScrollBar;
		
		public var tishi_mc:Sprite;

		private var container:Container;
		
		private var _packageProxy:PackageViewProxy;
		
		public var conditionArr:Array;
		public var userInfoVO:UserInfoVO;
		
		private var _arr:Array=[];
		private var list:Array=[];
		private var _drawList:Array=[];
		private var itemArr:Array=[];
		
        public function FactoryMakeComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryMakeSkin"));
			
			_packageProxy=ApplicationFacade.getProxy(PackageViewProxy);
			userInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			
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
		
		private function clearCantainer():void
		{
			while(container.num>0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function addContainerGuaJian(arr:Array):void
		{
			if(arr.length==0)
			{
				tishi_mc.visible=true;
				vsBar.visible=false;
				return;
			}else
			{
				if(arr.length<=3)
					vsBar.visible=false;
				tishi_mc.visible=false;
				container.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				vsBar.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				container.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
				vsBar.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			}
				
			list.length=0;
			_arr.length=0;
			for(var i:int=0;i<arr.length;i++)
			{
				var drawVo:DrawListVo=arr[i] as DrawListVo;
				var item:FactoryItem_1Component=new FactoryItem_1Component;				
				var guajianVo:GuaJianInfoVO=_packageProxy.createGuaJianVO(drawVo);
				item.drawVo=drawVo;
				item.guajianVo=guajianVo;
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
		
		public function changeContainer(arr:Array):void
		{
			for(var i:int=0;i<arr.length;i++)
			{
				var dwVo:DrawListVo=arr[i] as DrawListVo;
				for(var j:int=0;j<_arr.length;j++)
				{
					var item:FactoryItem_1Component=_arr[j] as FactoryItem_1Component;
					if(item.drawVo.id==dwVo.id)
					{
						item.drawVo=dwVo;
					}
				}
			}
		}
		
		public function addContainerZhanChe(arr:Array):void
		{
			if(arr.length==0)
			{
				tishi_mc.visible=true;
				vsBar.visible=false;
				return;
			}else
			{
				if(arr.length<=3)
					vsBar.visible=false;
				tishi_mc.visible=false;
				container.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				vsBar.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				container.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
				vsBar.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
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
				item.chuanqi_tf.text=zhancheVo.tritium.toString();
				
				item.zhancheVo=zhancheVo;
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
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vsBar.visible=false;
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			if(_arr.length>=3)
				vsBar.visible=true;
		}
		
		protected function doSpeedUpHandler(event:MouseEvent):void
		{
			var item:FactoryItem_1Component=event.target.parent as FactoryItem_1Component;
			dispatchEvent(new FactoryEvent(FactoryEvent.SPEEDUP_EVENT,item));
			/*for(var i:int;i<_arr.length;i++)
			{
				if(item==_arr[i])
				{
					FactoryEnum.CURRENT_VO=list[i] as BaseItemVO;
				}
			}*/
		}
		
		protected function doZhiZaoHandler(event:MouseEvent):void
		{
			var item:FactoryItem_1Component=event.target.parent as FactoryItem_1Component;
			var zhancheVo:ZhanCheInfoVO=_packageProxy.createZhanCheVO(item.drawVo);
			var guajianVo:GuaJianInfoVO=_packageProxy.createGuaJianVO(item.drawVo);
			//不足的条件
			conditionArr=[];
			if(item.zhancheVo)
			{
				if(zhancheVo.broken_crystal>userInfoVO.broken_crysta)
				{
					var obj1:Object=new Object();
					obj1.imgSource=ResEnum.getConditionIconURL+"1.png";
					obj1.content=MultilanguageManager.getString("broken_crysta")+int(userInfoVO.broken_crysta)+"/"+zhancheVo.broken_crystal;
					obj1.btnLabel=MultilanguageManager.getString("buy_click");
					conditionArr.push(obj1);
				}
				if(zhancheVo.tritium>userInfoVO.tritium)
				{
					var obj2:Object=new Object();
					obj2.imgSource=ResEnum.getConditionIconURL+"3.png";
					obj2.content=MultilanguageManager.getString("tritium")+int(userInfoVO.tritium)+"/"+zhancheVo.tritium;
					obj2.btnLabel=MultilanguageManager.getString("buy_click");
					conditionArr.push(obj2);
				}
			}
			else
			{
				if(guajianVo.broken_crystal>userInfoVO.broken_crysta)
				{
					var obj3:Object=new Object();
					obj3.imgSource=ResEnum.getConditionIconURL+"1.png";
					obj3.content=MultilanguageManager.getString("broken_crysta")+int(userInfoVO.broken_crysta)+"/"+guajianVo.broken_crystal;
					obj3.btnLabel=MultilanguageManager.getString("buy_click");
					conditionArr.push(obj3);
				}
				if(guajianVo.tritium>userInfoVO.tritium)
				{
					var obj4:Object=new Object();
					obj4.imgSource=ResEnum.getConditionIconURL+"3.png";
					obj4.content=MultilanguageManager.getString("tritium")+int(userInfoVO.tritium)+"/"+guajianVo.tritium;
					obj4.btnLabel=MultilanguageManager.getString("buy_click");
					conditionArr.push(obj4);
				}
			}
			
			if(conditionArr.length==0)
				dispatchEvent(new FactoryEvent(FactoryEvent.MAKE_EVENT,item,null));
			else
				dispatchEvent(new ConditionEvent(ConditionEvent.ADDCONDITIONVIEW_EVENT,conditionArr));
		}
		
		
		public function searchContainer(str:String,callBack:Function):void
		{
			var invertID:int=interval(function():void
			{
				for(var i:int=0;i<container.num;i++)
				{
					var item:FactoryItem_1Component=container.getAt(i) as FactoryItem_1Component;
					if(item.zhancheVo!=null)
					{
						if(item.zhancheVo.name==str)
						{
							if(callBack!=null)
							{
								clearInterval(invertID);
								callBack(item);
							}
							break;
						}					
					}else if(item.guajianVo!=null)
					{
						if(item.guajianVo.name==str)
						{
							if(callBack!=null)
							{
								clearInterval(invertID);
								callBack(item);
							}
							break;
						}	
					}
				}
			},1000);
			
			
		}
		
    }
}