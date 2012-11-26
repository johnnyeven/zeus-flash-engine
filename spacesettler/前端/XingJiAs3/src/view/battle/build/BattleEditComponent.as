package view.battle.build
{
	import com.zn.utils.BitmapUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import proxy.plantioid.PlantioidProxy;
	
	import ui.core.Component;
	import ui.utils.DisposeUtil;
	
	import utils.battle.FightUtil;

	/**
	 *战场编辑
	 * @author zn
	 *
	 */
	public class BattleEditComponent extends Component
	{
		public var bgSp:Sprite;
		public var buildSp:Sprite;

		private var _plantioidProxy:PlantioidProxy;

		private var _buildCompList:Array=[];

		public function BattleEditComponent(skin:Sprite)
		{
			super(skin);
			var sp:Sprite=getSkin("startPoint");
			DisposeUtil.dispose(sp);

			sp=getSkin("moveRangeSp");
			DisposeUtil.dispose(sp);

			buildSp=getSkin("buildSp");

			bgSp = getSkin("bg");
			_plantioidProxy=ApplicationFacade.getProxy(PlantioidProxy);

			initBuild();
		}

		private function initBuild():void
		{
			var buildVOList:Array=PlantioidProxy.selectedVO.buildVOList;
			var buildComp:BattleEditBuildItemComponent;
			for (var i:int=0; i < buildVOList.length; i++)
			{
				buildComp=new BattleEditBuildItemComponent();
				buildComp.buildVO=buildVOList[i];

//				buildComp.y=height-buildComp.y;
				buildSp.addChild(buildComp);
				_buildCompList.push(buildComp);
			}
		}
	}
}