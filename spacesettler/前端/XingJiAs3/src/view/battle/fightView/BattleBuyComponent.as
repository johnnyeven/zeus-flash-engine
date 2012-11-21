package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import events.battle.BattleBuyEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 *购买要塞
	 * @author lw
	 *
	 */
    public class BattleBuyComponent extends Component
    {
		public var moneyCountTF:TextField;
		public var giveUp_btn:Button;
		public var buy_btn:Button;
        public function BattleBuyComponent()
        {
            super(ClassUtil.getObject("battle.BattleBuySkin"));
			moneyCountTF = getSkin("moneyCountTF");
			giveUp_btn = createUI(Button,"giveUp_btn");
			buy_btn = createUI(Button,"buy_btn");
			sortChildIndex();
			
			moneyCountTF.addEventListener(MouseEvent.CLICK,moneyCountTF_clickHandler);
			giveUp_btn.addEventListener(MouseEvent.CLICK,giveUp_btn_clickHandler);
			buy_btn.addEventListener(MouseEvent.CLICK,buy_btn_clickHandler);
		}
		
		protected function buy_btn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new BattleBuyEvent(BattleBuyEvent.BATTLE_BUY_EVENT,int(moneyCountTF.text)));
		}
		
		protected function giveUp_btn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("giveUpBuy"));
		}
		
		protected function moneyCountTF_clickHandler(event:MouseEvent):void
		{
			moneyCountTF.text = "";
		}
    }
}