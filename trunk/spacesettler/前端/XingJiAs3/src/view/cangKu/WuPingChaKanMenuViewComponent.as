package view.cangKu
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import ui.core.Component;
	import view.buildingView.SelectorButtonComponent;
	
	public class WuPingChaKanMenuViewComponent extends Component
	{
		public var spUp:Sprite;
		public var spDown:Sprite;
		public var menuUpLine:MovieClip;
		public var menuDownLine:MovieClip;
		public var menuLine:MovieClip;
		public var menuZhuangPeiBtn:SelectorButtonComponent;//装配按钮
		public var menuQiangHuaBtn:SelectorButtonComponent;//强化按钮
		public var menuWeiXiuBtn:SelectorButtonComponent;//维修按钮
		public var menuChaKanBtn:SelectorButtonComponent;//查看按钮
		public var menuXiaoHuiBtn:SelectorButtonComponent;//销毁按钮
		public var menuDonateBtn:SelectorButtonComponent;//捐献按钮
		
		
		public function WuPingChaKanMenuViewComponent(type:String,legion:int)
		{
			super(null);
			spUp=new Sprite();
			spDown=new Sprite();
			addChild(spUp);
			addChild(spDown);
			
			menuUpLine=getSkin("");
			menuDownLine=getSkin("");
			menuLine=getSkin("");
			
			if(legion==1)
			{
				if(type=="")
				{
					menuZhuangPeiBtn=new SelectorButtonComponent();
					menuZhuangPeiBtn.text="装配";
					
					menuQiangHuaBtn=new SelectorButtonComponent();
					menuQiangHuaBtn.text="强化";
					
					menuWeiXiuBtn=new SelectorButtonComponent();
					menuWeiXiuBtn.text="维修";
					
					spUp.addChild(menuZhuangPeiBtn);
					spUp.addChild(menuQiangHuaBtn);
					spUp.addChild(menuWeiXiuBtn);
					
					menuChaKanBtn=new SelectorButtonComponent();
					menuChaKanBtn.text="查看";
					
					menuDonateBtn=new SelectorButtonComponent();
					menuDonateBtn.text="捐给军团";
					
					spDown.addChild(menuChaKanBtn);
					spDown.addChild(menuDonateBtn);
				}
				else
				{
					menuChaKanBtn=new SelectorButtonComponent();
					menuChaKanBtn.text="查看";
					
					menuXiaoHuiBtn=new SelectorButtonComponent();
					menuXiaoHuiBtn.text="销毁";
					
					spUp.addChild(menuChaKanBtn);
					spUp.addChild(menuXiaoHuiBtn);
					
					menuDonateBtn=new SelectorButtonComponent();
					menuDonateBtn.text="捐给军团";
					
					spDown.addChild(menuDonateBtn);
				}
			}
			else
			{
				if(type=="")
				{
					menuZhuangPeiBtn=new SelectorButtonComponent();
					menuZhuangPeiBtn.text="装配";
					
					menuQiangHuaBtn=new SelectorButtonComponent();
					menuQiangHuaBtn.text="强化";
					
					menuWeiXiuBtn=new SelectorButtonComponent();
					menuWeiXiuBtn.text="维修";
					
					spUp.addChild(menuZhuangPeiBtn);
					spUp.addChild(menuQiangHuaBtn);
					spUp.addChild(menuWeiXiuBtn);
					
					menuChaKanBtn=new SelectorButtonComponent();
					menuChaKanBtn.text="查看";
					
					spDown.addChild(menuChaKanBtn);
				}
				else
				{
					menuChaKanBtn=new SelectorButtonComponent();
					menuChaKanBtn.text="查看";
					
					menuXiaoHuiBtn=new SelectorButtonComponent();
					menuXiaoHuiBtn.text="销毁";
					
					spUp.addChild(menuChaKanBtn);
					spUp.addChild(menuXiaoHuiBtn);
				}
			}
		}
		public function move():void
		{
			TweenLite.to(spUp,0.5,{y:menuLine.y-spUp.height});
			TweenLite.to(spDown,0.5,{y:-(menuLine.y-spDown.height)});
		}
	}
}