package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Label;
	import ui.core.Component;
	
    public class BattleCountDownComponent extends Component
    {
		public var lable:Label;

		
        public function BattleCountDownComponent()
        {
            super(ClassUtil.getObject("view.BattleCountDownSkin"));
			
			lable=createUI(Label,"lable");
        }
		
		public function set timeNum(time:int):void
		{
			lable.text="距离轰炸还有："+String(time)+"秒";
		}
    }
}