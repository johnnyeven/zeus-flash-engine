package view.factory
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	import enum.item.SlotEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import proxy.packageView.PackageViewProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	import ui.utils.DisposeUtil;
	
	import view.factory.FactoryClickSpComponent;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	
    public class FactoryChangeComponent extends Component
    {
		
		public var sprite:LoaderImage;
		public var qiangHua:Sprite;
		public var mc:MovieClip;
		
		public var naijiu_tf:Label;
		public var zhuanhuan_tf:Label;
		public var nengliang_tf:Label;
		public var gongji_tf:Label;
		public var tf_4:Label;
		public var tf_3:Label;
		public var tf_2:Label;
		public var tf_1:Label;
		
		public var pingfen_tf:Label;
		public var level_tf:Label;
		public var title_tf:Label;
		
		public var item_1_1:FactoryClickSpComponent;
		public var item_1_2:FactoryClickSpComponent;
		public var item_1_3:FactoryClickSpComponent;
		public var item_2_3:FactoryClickSpComponent;
		public var item_2_2:FactoryClickSpComponent;
		public var item_2_1:FactoryClickSpComponent;
		public var item_3_3:FactoryClickSpComponent;
		public var item_3_1:FactoryClickSpComponent;
		public var item_3_2:FactoryClickSpComponent;
		
		//弹出的菜单和线条
		public var mcUp:Component;
		public var menuLine:MovieClip;
		
		public var zhiYinSp:Sprite;
		//弹出点击按钮
		public var jiaZaiBtn:Button
		public var chaKanBtn:Button
		public var genHuanBtn:Button
		public var xieZaiBtn:Button
		
		
		public var xiezai_btn:Button;
		public var change_btn:Button;
		public var info_btn:Button;
		public var close_btn:Button;
		
		public var currtentBtn:Button;

		private var zhancheVo:ZhanCheInfoVO;
		private var menuMask:Sprite;
		private var _currtentItem:FactoryClickSpComponent;
		private var arr:Array=[];
		private var pageProxy:PackageViewProxy;
		private var isNumOne:Boolean=true;
        public function FactoryChangeComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryChangeSkin"));
			pageProxy=ApplicationFacade.getProxy(PackageViewProxy);
			title_tf=createUI(Label,"title_tf");
			level_tf=createUI(Label,"level_tf");
			pingfen_tf=createUI(Label,"pingfen_tf");
			naijiu_tf=createUI(Label,"naijiu_tf");
			zhuanhuan_tf=createUI(Label,"zhuanhuan_tf");
			nengliang_tf=createUI(Label,"nengliang_tf");
			gongji_tf=createUI(Label,"gongji_tf");
			
			tf_1=createUI(Label,"tf_1");
			tf_2=createUI(Label,"tf_2");
			tf_3=createUI(Label,"tf_3");
			tf_4=createUI(Label,"tf_4");
			
			xiezai_btn=createUI(Button,"xiezai_btn");
			change_btn=createUI(Button,"change_btn");
			info_btn=createUI(Button,"info_btn");
			close_btn=createUI(Button,"close_btn");
			
			sprite=createUI(LoaderImage,"sprite");
			
			qiangHua=getSkin("qianghua_mc");
			mc=getSkin("mc");
			zhiYinSp=getSkin("zhiYinSp");
			
			item_1_1=createUI(FactoryClickSpComponent,"item_1_1");
			item_1_2=createUI(FactoryClickSpComponent,"item_1_2");
			item_1_3=createUI(FactoryClickSpComponent,"item_1_3");
			item_2_1=createUI(FactoryClickSpComponent,"item_2_1");
			item_2_2=createUI(FactoryClickSpComponent,"item_2_2");
			item_2_3=createUI(FactoryClickSpComponent,"item_2_3");
			item_3_1=createUI(FactoryClickSpComponent,"item_3_1");
			item_3_2=createUI(FactoryClickSpComponent,"item_3_2");
			item_3_3=createUI(FactoryClickSpComponent,"item_3_3");
			
			sortChildIndex();
			
			qiangHua.mouseEnabled=true;
			
			addClick(item_1_1);
			addClick(item_1_2);
			addClick(item_1_3);
			addClick(item_2_1);
			addClick(item_2_2);
			addClick(item_2_3);
			addClick(item_3_1);
			addClick(item_3_2);
			addClick(item_3_3);
			
			item_1_1.visible=false;
			item_1_2.visible=false;
			item_1_3.visible=false;
			item_2_1.visible=false;
			item_2_2.visible=false;
			item_2_3.visible=false;
			item_3_1.visible=false;
			item_3_2.visible=false;
			item_3_3.visible=false;
			zhiYinSp.visible=false;
			
			arr[6]=item_1_1;
			arr[7]=item_1_2;
			arr[8]=item_1_3;
			arr[3]=item_2_1;
			arr[4]=item_2_2;
			arr[5]=item_2_3;
			arr[0]=item_3_1;
			arr[1]=item_3_2;
			arr[2]=item_3_3;
			
			zhancheVo=new ZhanCheInfoVO();
			
			this.addEventListener(Event.COMPLETE,playOverHandler);
			close_btn.addEventListener(MouseEvent.CLICK,closeHandler);
			qiangHua.addEventListener(MouseEvent.CLICK,qiangHuaClickHandler);
			info_btn.addEventListener(MouseEvent.CLICK,infoHandler);
			change_btn.addEventListener(MouseEvent.CLICK,changeHandler);
			xiezai_btn.addEventListener(MouseEvent.CLICK,xieZaiHandler);
			
			this.addEventListener(MouseEvent.CLICK,overMcPlayHandler);
        }					
		
		protected function overMcPlayHandler(event:MouseEvent):void
		{
			mc.gotoAndPlay(80);
			this.removeEventListener(MouseEvent.CLICK,overMcPlayHandler);
		}		
		
		public function upData(infoVo:ZhanCheInfoVO):void
		{
			zhancheVo=infoVo;
			sprite.source=ResEnum.senceEquipment+infoVo.item_type+"_"+infoVo.category+".png";
			
			title_tf.text=infoVo.name;
			level_tf.text=infoVo.level.toString();
			pingfen_tf.text=infoVo.value.toString();
			naijiu_tf.text=infoVo.naiLi;
			nengliang_tf.text=infoVo.energy_in_use .toString()+"/"+infoVo.total_energy.toString();
			
			
			if(infoVo.energy_in_use>infoVo.total_energy)
			{
				nengliang_tf.color=0xff0000;
				if(!isNumOne)
				{
					dispatchEvent(new FactoryEvent(FactoryEvent.NENGLIANG_MAX_EVENT));
				}
					
				
			}else
			{
				nengliang_tf.color=0x00ccff;
			}
			zhuanhuan_tf.text=infoVo.attackSpeed.toString();
			gongji_tf.text=infoVo.attack.toString();
			
			var str1:String=(infoVo.damageDescShiDan*100).toFixed(1);
			var str2:String=(infoVo.damageDescJiGuang*100).toFixed(1);
			var str3:String=(infoVo.damageDescDianCi*100).toFixed(1);
			var str4:String=(infoVo.damageDescAnNeng*100).toFixed(1);
			
			tf_1.text=str1+"%";
			tf_2.text=str2+"%";
			tf_3.text=str3+"%";
			tf_4.text=str4+"%";
			
		}
		
		private function addClick(item:FactoryClickSpComponent):void
		{
			item.addEventListener(MouseEvent.CLICK,itemClickHandler);
		}
		
		protected function itemClickHandler(event:MouseEvent):void
		{
			isNumOne=false;
			var item:FactoryClickSpComponent=event.currentTarget as FactoryClickSpComponent;
			var rect:Rectangle=item.getRect(item);
			
			var point:Point=new Point(rect.left+item.width*0.5,rect.top+item.height*0.5);
			point = item.localToGlobal(point);
			point = this.globalToLocal(point);
			item.isClick();
			
			DisposeUtil.dispose(mcUp);
			DisposeUtil.dispose(menuLine);
			
			menuMask = new Sprite();
			menuMask.graphics.beginFill(0, 0.5);
			menuMask.graphics.drawRect(0, 0, this.width, this.height);
			menuMask.graphics.endFill();
			addChild(menuMask);
			_currtentItem=item;
			
			if(item.isLoader)
			{
				newMcUpTwo();	
				FactoryEnum.CURRENT_GUAJIAN_VO=item.guajianVo;
			}else
			{
				newMcUpOne();
			}
			switch(item)
			{
				case item_1_1:
				{
					rightMenuLine();
					FactoryEnum.CURRENT_POSITION=6;
					FactoryEnum.CURRENT_TYPE=SlotEnum.SMALL;
					break;
				}
				case item_1_2:
				{
					rightMenuLine();
					FactoryEnum.CURRENT_POSITION=7;
					FactoryEnum.CURRENT_TYPE=SlotEnum.SMALL;
					break;
				}
				case item_1_3:
				{
					rightMenuLine();
					FactoryEnum.CURRENT_POSITION=8;
					FactoryEnum.CURRENT_TYPE=SlotEnum.SMALL;
					break;
				}
				case item_2_1:
				{
					leftMenuLine();
					FactoryEnum.CURRENT_POSITION=3;
					FactoryEnum.CURRENT_TYPE=SlotEnum.MID;
					break;
				}
				case item_2_2:
				{
					leftMenuLine();
					FactoryEnum.CURRENT_POSITION=4;
					FactoryEnum.CURRENT_TYPE=SlotEnum.MID;
					break;
				}
				case item_2_3:
				{
					leftMenuLine();
					FactoryEnum.CURRENT_POSITION=5;
					FactoryEnum.CURRENT_TYPE=SlotEnum.MID;
					break;
				}
				case item_3_1:
				{
					rightMenuLine();
					FactoryEnum.CURRENT_POSITION=0;
					FactoryEnum.CURRENT_TYPE=SlotEnum.BIG;
					break;
				}
				case item_3_2:
				{
					leftMenuLine();
					FactoryEnum.CURRENT_POSITION=1;
					FactoryEnum.CURRENT_TYPE=SlotEnum.BIG;
					break;
				}
				case item_3_3:
				{
					leftMenuLine();
					FactoryEnum.CURRENT_POSITION=2;
					FactoryEnum.CURRENT_TYPE=SlotEnum.BIG;
					break;
				}
			}
			
			menuLine.x = point.x;
			menuLine.y = point.y;
			mcUp.y = 50;
			menuMask.addChild(mcUp);
			menuMask.addChild(menuLine);
			move();
			
			menuMask.addEventListener(MouseEvent.CLICK, remove_clickHandler);
			if(jiaZaiBtn)
				jiaZaiBtn.addEventListener(MouseEvent.CLICK,jiaZaiBtn_clickHandler);
			if(chaKanBtn)
				chaKanBtn.addEventListener(MouseEvent.CLICK,chaKanBtn_clickHandler);
			if(genHuanBtn)
				genHuanBtn.addEventListener(MouseEvent.CLICK,genHuanBtn_clickHandler);
			if(xieZaiBtn)
				xieZaiBtn.addEventListener(MouseEvent.CLICK,xieZaiBtn_clickHandler);
			
		}
		
		protected function xieZaiBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.XIEZAI_EVENT));
		}
		
		protected function genHuanBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.GENHUAN_GUAJIAN_EVENT));
		}
		
		protected function chaKanBtn_clickHandler(event:MouseEvent):void	
		{
			
			pageProxy.chakanVO=FactoryEnum.CURRENT_GUAJIAN_VO;
			dispatchEvent(new FactoryEvent(FactoryEvent.CHAKAN_GUAJIAN_EVENT));
		}
		
		protected function jiaZaiBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.LOAD_GUAJIAN_EVENT));
		}
		
		private function newMcUpOne():void
		{
			mcUp = new Component(ClassUtil.getObject("up_menu_1"))//加载
			currtentBtn=jiaZaiBtn;
			jiaZaiBtn = mcUp.createUI(Button, "jiazai_btn");
			mcUp.sortChildIndex();
		}
		
		private function newMcUpTwo():void
		{
			mcUp = new Component(ClassUtil.getObject("up_menu_2"))//有物品时
			chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
			genHuanBtn = mcUp.createUI(Button, "change_btn");
			xieZaiBtn = mcUp.createUI(Button, "xiezai_btn");
			mcUp.sortChildIndex();
		}
		
		private function rightMenuLine():void
		{
			menuLine = ClassUtil.getObject("right_line_menu")
		}
		
		private function leftMenuLine():void
		{
			menuLine = ClassUtil.getObject("left_line_menu");
		}
		
		protected function remove_clickHandler(event:MouseEvent):void
		{
			this.removeChild(menuMask);
			menuMask = null;
			_currtentItem.isNotClick();
		}
		
		public function move():void
		{
			var rect:Rectangle=menuLine.getRect(menuLine);			
			TweenLite.to(mcUp, 0.5, { y: menuLine.y + rect.top -mcUp.height- 2 });			
		}
		
		protected function qiangHuaClickHandler(event:MouseEvent):void
		{
			isNumOne=true;
			dispatchEvent(new FactoryEvent(FactoryEvent.QIANGHUA_EVENT));
		}
		
		protected function playOverHandler(event:Event):void
		{
			changeItem(zhancheVo);
		}
		
		public function changeItem(info:ZhanCheInfoVO):void
		{
			for(var i:int=0;i<info.guaJianItemVOList.length;i++)
			{
				if(info.guaJianItemVOList[i].disable==false)
				{
					var vo:GuaJianInfoVO=info.guaJianItemVOList[i] as GuaJianInfoVO;
					var guajianVo:GuaJianInfoVO=pageProxy.createGuaJianVO(vo);
					var item:FactoryClickSpComponent=arr[i] as FactoryClickSpComponent;
					item.guajianVo=guajianVo;
					item.visible=true;
					if(i<=2)
						item.isThree();
					if(i>2&&i<=5)
						item.isTwo();
					if(i>5&&i<=8)
						item.isOne();
					
					if(guajianVo.is_mounted)
					{
						item.isNomal();
						item.item_sp.source=ResEnum.senceEquipmentSmall+ItemEnum.TankPart+"_"+guajianVo.category+".png";
						item.isLoader=true;
						item.item_sp.visible=true;
					}
					zhiYinSp.visible=item_3_1.visible;
				}				
			}
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}		
		
		
		protected function xieZaiHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.XIEZAI_ALL_EVENT));
		}
		public function changeLoader():void
		{
			_currtentItem.isLoader=false;
			_currtentItem.item_sp.visible=false;
		}
		
		public function changeAllLoader():void
		{
			for(var i:int;i<arr.length;i++)
			{
				(arr[i] as FactoryClickSpComponent).isLoader=false;
				(arr[i] as FactoryClickSpComponent).item_sp.visible=false;
			}
		}
		
		protected function changeHandler(event:MouseEvent):void
		{
			var pageProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
			pageProxy.chakanVO=FactoryEnum.CURRENT_GUAJIAN_VO as BaseItemVO;
			dispatchEvent(new FactoryEvent(FactoryEvent.CHANGE_ZHANCHE_EVENT));
		}
		
		protected function infoHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.SHOW_INFO_EVENT));
		}

		public function get currtentItem():FactoryClickSpComponent
		{
			return _currtentItem;
		}

		public function set currtentItem(value:FactoryClickSpComponent):void
		{
			_currtentItem = value;
		}

    }
}