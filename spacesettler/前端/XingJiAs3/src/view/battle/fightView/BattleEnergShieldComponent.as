package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import ui.core.Component;
	
	/**
	 * 战车能量护盾值显示
	 * @author gx
	 * 
	 */	
    public class BattleEnergShieldComponent extends Component
    {
		public static const MAXNUM:int=40;
		
		/**
		 *能量圈 
		 */		
		public var enduranceCircle:MovieClip;
		
		/**
		 *护盾圈 
		 */		
		public var shieldCircle:MovieClip;

		
        public function BattleEnergShieldComponent(skin:DisplayObjectContainer)
        {
            super(skin);
			
			enduranceCircle=getSkin("enduranceCircle");
			shieldCircle=getSkin("shieldCircle");
			
			sortChildIndex();			
        }
		
		public function upDataEn(prt:Number):void
		{
			var num:int=int(prt*MAXNUM);
			enduranceCircle.gotoAndStop(num);
		}
		
		public function upDataSh(prt:Number):void
		{
			var num:int=int(prt*MAXNUM);
			shieldCircle.gotoAndStop(num);			
		}
    }
}