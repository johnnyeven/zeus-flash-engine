package view.giftBag
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.XMLUtil;
	
	import enum.ResEnum;
	import enum.giftBag.GiftBagTypeEnum;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.packageView.PackageViewProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.VLayout;
	import ui.utils.DisposeUtil;
	
	import vo.cangKu.BaseItemVO;
	
	public class GiftDetileInfoViewComponent extends Component
	{
		public var nameLabel:Label;
		public var closeBtn:Button;
		public var boxSp:Sprite;
		public var vScrollBar:VScrollBar;
		public var container:Container;
		
		private var _packageViewProxy:PackageViewProxy;
		public function GiftDetileInfoViewComponent()
		{
			super(ClassUtil.getObject("view.giftdetileInfoViewSkin"));
			_packageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
			
			nameLabel=createUI(Label,"nameLabel");
			closeBtn=createUI(Button,"closeBtn");
			boxSp=getSkin("boxSp");
			vScrollBar=createUI(VScrollBar,"vScrollBar");
			sortChildIndex();
			
			container=new Container(null);
			container.contentHeight=220;
			container.contentWidth=288;
			container.layout=new VLayout(container);
			boxSp.addChild(container);
			
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			addChild(vScrollBar);
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHandler);
		}
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function updateValue(type:int,arr:Array):void
		{
			removeAllItem();
			
			if(type==GiftBagTypeEnum.GiftBag_LoginEvery)
			{
				nameLabel.text="连续登陆奖励详情";
				var infoOfLoginEvery:GiftDetileInfoComponent=new GiftDetileInfoComponent();
				infoOfLoginEvery.text="活动期间，连续登陆游戏后即可获取此奖励。连续7天登陆即可获得丰厚大奖，当天未领取，奖励不累计。";
				container.add(infoOfLoginEvery);
				
				for(var i:int=0;i<arr.length;i++)
				{
					switch(arr[i].day)
					{
						case 1:
							var nameOfLoginEvery1:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery1.nameTxt="连续登陆第1天";
							container.add(nameOfLoginEvery1);
							addItem(arr[0]);
							break;
						case 2:
							var nameOfLoginEvery2:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery2.nameTxt="连续登陆第2天";
							container.add(nameOfLoginEvery2);
							addItem(arr[1]);
							break;
						case 3:
							var nameOfLoginEvery3:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery3.nameTxt="连续登陆第3天";
							container.add(nameOfLoginEvery3);
							addItem(arr[2]);
							break;
						case 4:
							var nameOfLoginEvery4:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery4.nameTxt="连续登陆第4天";
							container.add(nameOfLoginEvery4);
							addItem(arr[3]);
							break;
						case 5:
							var nameOfLoginEvery5:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery5.nameTxt="连续登陆第5天";
							container.add(nameOfLoginEvery5);
							addItem(arr[4]);
							break;
						case 6:
							var nameOfLoginEvery6:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery6.nameTxt="连续登陆第6天";
							container.add(nameOfLoginEvery6);
							addItem(arr[5]);
							break;
						case 7:
							var nameOfLoginEvery7:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfLoginEvery7.nameTxt="连续登陆第7天";
							container.add(nameOfLoginEvery7);
							addItem(arr[6]);
							break;
						default:
							break;
					}
				}
			}
			else if(type==GiftBagTypeEnum.GiftBag_Online)
			{
				nameLabel.text="在线礼包奖励详情";
				var infoOfOnline:GiftDetileInfoComponent=new GiftDetileInfoComponent();
				infoOfOnline.text="玩家每天登陆游戏后,在线礼包开始倒计时。倒计时完成后,玩家即可领取当前的在线礼包。";
				container.add(infoOfOnline);
				
				for(var j:int=0;j<arr.length;j++)
				{
					switch(arr[j].time)
					{
						case 1:
							var nameOfOnline1:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline1.nameTxt="在线1分钟";
							container.add(nameOfOnline1);
							addItem(arr[0]);
							break;
						case 5:
							var nameOfOnline2:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline2.nameTxt="在线5分钟";
							container.add(nameOfOnline2);
							addItem(arr[1]);
							break;
						case 10:
							var nameOfOnline3:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline3.nameTxt="在线10分钟";
							container.add(nameOfOnline3);
							addItem(arr[2]);
							break;
						case 15:
							var nameOfOnline4:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline4.nameTxt="在线15分钟";
							container.add(nameOfOnline4);
							addItem(arr[3]);
							break;
						case 20:
							var nameOfOnline5:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline5.nameTxt="在线20分钟";
							container.add(nameOfOnline5);
							addItem(arr[4]);
							break;
						case 25:
							var nameOfOnline6:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline6.nameTxt="在线25分钟";
							container.add(nameOfOnline6);
							addItem(arr[5]);
							break;
						case 30:
							var nameOfOnline7:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline7.nameTxt="在线30分钟";
							container.add(nameOfOnline7);
							addItem(arr[6]);
							break;
						case 60:
							var nameOfOnline8:GiftDetileInfoNameComponent=new GiftDetileInfoNameComponent();
							nameOfOnline8.nameTxt="在线60分钟";
							container.add(nameOfOnline8);
							addItem(arr[7]);
							break;
						default:
							break;
					}
				}
			}
			container.layout.update();
			vScrollBar.update();
		}
		
		private function addItem(obj:Object):void
		{
			if(obj.broken_crystal && obj.broken!=0)
			{
				var item1:GiftDetileItemComponent=new GiftDetileItemComponent();
				item1.imgSource=ResEnum.getConditionIconURL+"1.png";
				item1.infoTxt=MultilanguageManager.getString("broken_crysta")+obj.broken_crystal;
				container.add(item1);
			}
			if(obj.crystal && obj.crystal!=0)
			{
				var item2:GiftDetileItemComponent=new GiftDetileItemComponent();
				item2.imgSource=ResEnum.getConditionIconURL+"2.png";
				item2.infoTxt=MultilanguageManager.getString("crystal")+obj.crystal;
				container.add(item2);
			}
			if(obj.tritium && obj.tritium!=0)
			{
				var item4:GiftDetileItemComponent=new GiftDetileItemComponent();
				item4.imgSource=ResEnum.getConditionIconURL+"3.png";
				item4.infoTxt=MultilanguageManager.getString("tritium")+obj.tritium;
				container.add(item4);
			}
			if(obj.dark_crystal && obj.dark_crystal!=0)
			{
				var item3:GiftDetileItemComponent=new GiftDetileItemComponent();
				item3.imgSource=ResEnum.getConditionIconURL+"8.png";
				item3.infoTxt=MultilanguageManager.getString("dark_crystal")+obj.dark_crystal;
				container.add(item3);
			}
			if(obj.item && obj.item.length>0)
			{
				var itemList:Array=obj.item;
				for(var i:int=0;i<itemList.length;i++)
				{
					var item5:GiftDetileItemComponent=new GiftDetileItemComponent();
					
					var itemVO:BaseItemVO=new BaseItemVO;
					if(itemList[i].r_type==1)
						itemVO.item_type="Chairot";
					else
						itemVO.item_type="TankPart";
					itemVO.category=itemList[i].category;
					itemVO.enhanced=itemList[i].enhanced;
					itemVO.type=itemList[i].type;
					_packageViewProxy.setBaseItemName(itemVO,_packageViewProxy.packageXML);
					
					item5.imgSource=ResEnum.senceEquipment + itemVO.item_type + "_" + itemList[i].category + ".png";
					item5.infoTxt=itemVO.name;
					container.add(item5);
				}
				
			}
		}
		
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GiftBagEvent(GiftBagEvent.CLOSEVIEW_EVENT,0,false,true));
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
	}
}