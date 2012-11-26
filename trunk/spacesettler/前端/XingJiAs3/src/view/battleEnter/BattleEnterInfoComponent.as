package view.battleEnter
{
    import com.zn.utils.StringUtil;
    
    import enum.factory.FactoryEnum;
    
    import events.battle.BattleEnterEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import flashx.textLayout.formats.WhiteSpaceCollapse;
    
    import proxy.battle.BattleProxy;
    import proxy.plantioid.PlantioidProxy;
    
    import ui.components.Button;
    import ui.components.Container;
    import ui.components.HScrollBar;
    import ui.components.Label;
    import ui.core.Component;
    import ui.layouts.HLayout;
    import ui.utils.DisposeUtil;
    
    import vo.cangKu.ZhanCheInfoVO;

    /**
     *飞船选择框
     * @author zn
     *
     */
    public class BattleEnterInfoComponent extends Component
    {
        public var scrollBar:HScrollBar;

        public var pointLabel:Label;

        public var enterButton:Button;

        public var contain:Container;

        private var _selectedItemComp:BattleEnterItemComonent;
		
		private var itemArr:Array=[];
        public function BattleEnterInfoComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            scrollBar = createUI(HScrollBar, "scrollBar");
            pointLabel = createUI(Label, "pointLabel");
            enterButton = createUI(Button, "enterButton");
            contain = createUI(Container, "contain");

            sortChildIndex();

            contain.layout = new HLayout(contain);
            contain.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
            contain.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);

            scrollBar.viewport = contain;
            scrollBar.alpahaTweenlite(0);
            scrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
            scrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);

			enterButton.addEventListener(MouseEvent.CLICK,enterButton_clickHandler);
				
            var battleProxy:BattleProxy = ApplicationFacade.getProxy(BattleProxy);
            setZhanCheList(battleProxy.allZhanCheList);

            pointLabel.text = StringUtil.formatString("X:{0}-y:{1}-{2}", PlantioidProxy.selectedVO.x, PlantioidProxy.selectedVO.y, PlantioidProxy.selectedVO.z);
        }
		
        protected function mouseOutHandler(event:MouseEvent):void
        {
            scrollBar.alpahaTweenlite(0);
        }

        protected function mouseOverHandler(event:MouseEvent):void
        {
            scrollBar.alpahaTweenlite(1);
        }

        public function removeAllZhanChe():void
        {
            while (contain.num > 0)
                DisposeUtil.dispose(contain.removeAt(0));
        }

        public function setZhanCheList(value:Array):void
        {
            removeAllZhanChe();

            var zhanCheVO:ZhanCheInfoVO;
            var itemComp:BattleEnterItemComonent;
            for (var i:int = 0; i < value.length; i++)
            {
                zhanCheVO = value[i];
                itemComp = new BattleEnterItemComonent();
				itemComp.addEventListener(MouseEvent.CLICK,itemComp_clickHandler);
                itemComp.itemVO = zhanCheVO;
				itemArr[i]=itemComp;
                contain.add(itemComp);
            }
            contain.layout.update();
            scrollBar.update();
			if(selectedItemComp==null)
          		 selectedItemComp = contain.getAt(0) as BattleEnterItemComonent;//不用默认选中
			else
			{
				for(var j:int=0;j<itemArr.length;j++)
				{
					var item:BattleEnterItemComonent=itemArr[j] as BattleEnterItemComonent;
					if(selectedItemComp.itemVO.id==item.itemVO.id)
						selectedItemComp=item;
				}
			}
        }
		
		protected function itemComp_clickHandler(event:MouseEvent):void
		{
			selectedItemComp=event.currentTarget as BattleEnterItemComonent;			
		}
		
        public function get selectedItemComp():BattleEnterItemComonent
        {
            return _selectedItemComp;
        }

        public function set selectedItemComp(value:BattleEnterItemComonent):void
        {
            if (selectedItemComp)
                selectedItemComp.selected = false;

            _selectedItemComp = value;

			//将战车的数据保存下来
			FactoryEnum.CURRENT_ZHANCHE_VO=_selectedItemComp.itemVO;
            enterButton.enabled = false;
            if (selectedItemComp)
            {
                selectedItemComp.selected = true;
                enterButton.enabled = true;
            }
        }
		
		/**
		 *进入战场 
		 * @param event
		 * 
		 */
		protected function enterButton_clickHandler(event:MouseEvent):void
		{
			if(!selectedItemComp)
			{
				//提示选择战车
				dispatchEvent(new Event("selectedZhanCheTips",true));
				return;
			}
			dispatchEvent(new BattleEnterEvent(BattleEnterEvent.BATTLE_ENTER_EVENT,selectedItemComp.itemVO));
		}
    }
}
