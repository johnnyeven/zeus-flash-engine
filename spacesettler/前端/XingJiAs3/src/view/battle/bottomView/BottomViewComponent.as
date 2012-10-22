package view.battle.bottomView
{
	import enum.battle.BattleBuildTypeEnum;
	
	import events.battle.BottomViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.plantioid.PlantioidProxy;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.battle.BattleBuildVO;
	
	/**
	 * 战场底部界面
	 * @author zn
	 * 
	 */	
	public class BottomViewComponent extends Component
	{
		public var viewItemSp1:Sprite;
		public var viewItemSp2:Sprite;
		public var viewItemSp3:Sprite;
		public var viewItemSp4:Sprite;
		public var exitBtn:Button;
		
		private var _plantioidProxy:PlantioidProxy;
		
		public function BottomViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			viewItemSp1=getSkin("item_0");
			viewItemSp2=getSkin("item_1");
			viewItemSp3=getSkin("item_2");
			viewItemSp4=getSkin("item_3");
			exitBtn=createUI(Button,"exitBtn");
			
			_plantioidProxy=ApplicationFacade.getProxy(PlantioidProxy);
			for each(var itemVO:BattleBuildVO in _plantioidProxy.buildConentVODic)
			{
				if(itemVO.type==BattleBuildTypeEnum.JIA_Xie)
				{
					var viewItem1:BottomViewItemComponent=new BottomViewItemComponent(itemVO);
					viewItemSp1.addChild(viewItem1);
				}
				if(itemVO.type==BattleBuildTypeEnum.JI_GUANG)
				{
					var viewItem2:BottomViewItemComponent=new BottomViewItemComponent(itemVO);
					viewItemSp2.addChild(viewItem2);
				}
				if(itemVO.type==BattleBuildTypeEnum.DIAN_CI)
				{
					var viewItem3:BottomViewItemComponent=new BottomViewItemComponent(itemVO);
					viewItemSp3.addChild(viewItem3);
				}
				if(itemVO.type==BattleBuildTypeEnum.AN_NENG)
				{
					var viewItem4:BottomViewItemComponent=new BottomViewItemComponent(itemVO);
					viewItemSp4.addChild(viewItem4);
				}
			}			
			
			exitBtn.addEventListener(MouseEvent.CLICK, exitBtn_clickHandler);
		}
		
		protected function exitBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new BottomViewEvent(BottomViewEvent.EXIT_EVENT));
		}
		
	}
}