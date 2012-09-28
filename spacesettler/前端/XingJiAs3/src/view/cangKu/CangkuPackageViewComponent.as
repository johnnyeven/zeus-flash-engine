package view.cangKu
{
	import com.greensock.TweenLite;
	
	import events.buildingView.AddViewEvent;
	import events.cangKu.MenuEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import proxy.BuildProxy;
	import proxy.content.ContentProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.layouts.VTileLayout;
	
	import vo.BuildInfoVo;
	import vo.viewInfo.ViewInfoVO;
	
	/**
	 * 查看物资仓库界面
	 * 
	 */
	public class CangkuPackageViewComponent extends Component
	{
		public var shuiJinRL:Label;//水晶容量
		public var anWuZhiRL:Label;//暗物质容量
		public var chuanQiRL:Label;//氚气容量
		public var anNengShuiJinRL:Label;//暗能水晶容量
		public var anNengShuiJinXH:Label;//暗能水晶消耗
		public var boxNumRL:Label;//背包格子占用/背包格子总数 初始 0/20
		
		public var vScrollBar:VScrollBar;//拖动条
		public var buyBtn:Button;//购买仓位按钮
		public var closeBtn:Button;//关闭按钮
		
		public var gridComp:CangKuGridComponent;//格子
		public var container:Container;
		
		private var gridArr:Array=new Array();
		public var total:int=20;
		public var curNum:int=0;
		
		private var _buildVO:BuildInfoVo;
		
		public function CangkuPackageViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			trace("+++++++++++++++++++++++++++");
			var userInfoProxy:UserInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			
			shuiJinRL=createUI(Label,"shuiJinRL_tf");
			anWuZhiRL=createUI(Label,"anWuZhiRL_tf");
			chuanQiRL=createUI(Label,"chuanQiRL_tf");
			anNengShuiJinRL=createUI(Label,"anNengShuiJinRL_tf");
			anNengShuiJinXH=createUI(Label,"anNengShuiJinXH_tf");
			boxNumRL=createUI(Label,"boxNum_tf");
			
			buyBtn=createUI(Button,"buy_button");
			closeBtn=createUI(Button,"close_button");
			
			shuiJinRL.text=userInfoProxy.userInfoVO.crystal+"";
			anWuZhiRL.text=userInfoProxy.userInfoVO.broken_crysta+"";
			chuanQiRL.text=userInfoProxy.userInfoVO.tritium+"";
			anNengShuiJinRL.text=userInfoProxy.userInfoVO.dark_crystal+"";
			anNengShuiJinXH.text="";
			boxNumRL.text=curNum+"/"+total;
			
			container=new Container(null);
			container.contentWidth=325;
			container.contentHeight=325;
			container.layout=new HTileLayout(container);
			container.x=12.5;
			container.y=137.5;
			addChild(container);
			
			container.addEventListener(MouseEvent.ROLL_OVER,mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
			//getPackage(total);
			
			for(var i:int=0;i<total;i++)
			{
				gridComp=new CangKuGridComponent();
				gridComp.imgSource="";
				
				gridComp.addEventListener(MouseEvent.CLICK,grid_clickHandler);
				
				gridArr.push(gridComp);
				container.add(gridComp);
			}
			
			container.layout.update();
			
			vScrollBar=createUI(VScrollBar,"vScrollBar");
			vScrollBar.viewport=container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER,mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			
			sortChildIndex();
			
			addChild(vScrollBar);
			
			buyBtn.addEventListener(MouseEvent.CLICK,buyBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHandler);
			
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
		
		//购买仓位 消耗暗能水晶
		protected function buyBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			total++;
		}
		
		//关闭窗口
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
		}
		
		//点击物品 弹出选项菜单
		protected function grid_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new MenuEvent(MenuEvent.ADDMENU_EVENT));
		}
		
		public function getPackage(value:int):void
		{
			for(var i:int=0;i<value;i++)
			{
				gridComp=new CangKuGridComponent();
				gridComp.imgSource="";
				
				gridComp.addEventListener(MouseEvent.CLICK,grid_clickHandler);
				
				gridArr.push(gridComp);
				container.add(gridComp);
			}
			
			container.layout.update();
			
			vScrollBar=createUI(VScrollBar,"vScrollBar");
			vScrollBar.viewport=container;
		}
	}
}