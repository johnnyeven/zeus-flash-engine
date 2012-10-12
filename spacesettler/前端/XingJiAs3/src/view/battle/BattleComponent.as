package view.battle
{
	import com.zn.utils.BitmapUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import ui.core.Component;
	
	import utils.battle.BattleParseUtils;
	
	/**
	 *战场 
	 * @author zn
	 * 
	 */	
	public class BattleComponent extends Component
	{
		public var moveBitMapData:BitmapData;
		
		public var startPoint:Point;
		
		public function BattleComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			moveBitMapData=BattleParseUtils.getMoveRangeBitmapData(this,true);
			startPoint=BattleParseUtils.getStartPoint(this,true);
		}
	}
}