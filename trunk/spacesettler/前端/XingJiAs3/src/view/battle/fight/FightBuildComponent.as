package view.battle.fight
{
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;
    
    import enum.battle.BattleScaleEnum;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    import mx.binding.utils.BindingUtils;
    
    import ui.components.Label;
    import ui.components.ProgressBar;
    import ui.core.Component;
    import ui.utils.DisposeUtil;

    /**
     *战场建筑
     * @author zn
     *
     */
    public class FightBuildComponent extends Component
    {
        private var _itemVO:FORTBUILDING;

        private var _buildSp:Sprite;

		public var infoComp:Component;
		
		public var hpBar:ProgressBar;
		public var nameLabel:Label;
		
        private var _tankPartRotaion:Number;

		/**
		 *建筑在攻击范围内的特效 
		 */		
		private var buildRangeEffect:MovieClip;
		private var _setBuildRangeEffectVisible:Boolean = false;
		/**
		 *建筑炮塔的开火特效
		 */	
		public var buildFireEffect:Sprite;
        public function FightBuildComponent(buildVO:FORTBUILDING)
        {
            super(null);

			buildRangeEffect = ClassUtil.getObject("battle.BuildRangeEffectSkin") as MovieClip;
			infoComp=new Component(ClassUtil.getObject("battle.FightBuildInfoBarSkin"));
			hpBar=infoComp.createUI(ProgressBar,"hpBar");
			nameLabel=infoComp.createUI(Label,"nameLabel");
			infoComp.sortChildIndex();
			infoComp.y=120;
            buttonMode = true;
            this.itemVO = buildVO;
			buildRangeEffect.visible = _setBuildRangeEffectVisible;
			this.addChild(buildRangeEffect);

            x = buildVO.x;
            y = buildVO.y;
            cwList.push(BindingUtils.bindSetter(stateChange, buildVO, "state"));
        }

        private function stateChange(value:*):void
        {
            DisposeUtil.dispose(_buildSp);

            var className:String = "";

            if (itemVO.type == 1 || itemVO.type == 2)
                className = StringUtil.formatString("build_icon_{0}_normal", itemVO.type);
            else
                className = StringUtil.formatString("battle.build_{0}", itemVO.type);

            _buildSp = ClassUtil.getObject(className);
            if (turretMC)
			{
				turretMC.gotoAndStop(1);
				buildFireEffect = turretMC.getChildByName("point") as Sprite;
			}
                

			
            addChild(_buildSp);
			addChild(infoComp);
        }

        public function get turretMC():MovieClip
        {
            return _buildSp.getChildByName("taMC") as MovieClip;
        }

        public function get tankPartRotaion():Number
        {
            return _tankPartRotaion;
        }

        public function set tankPartRotaion(value:Number):void
        {
            if (value == 360)
                value = 0;

            _tankPartRotaion = value;

            var r:int = Math.round(value / 20) * 2;

            if (r == 36)
                r = 0;

            var flagStr:String = "d" + r;
            if (turretMC)
			{
				turretMC.gotoAndStop(flagStr);
				buildFireEffect = turretMC.getChildByName("point") as Sprite;
			}
                
        }

		public function get itemVO():FORTBUILDING
		{
			return _itemVO;
		}

		public function set itemVO(value:FORTBUILDING):void
		{
			_itemVO = value;
			nameLabel.text=value.name;
			updateHp();
		}
		
		public function updateHp():void
		{
			hpBar.percent=itemVO.currentEndurance/itemVO.totalEndurance;
		}

		public function get setBuildRangeEffectVisible():Boolean
		{
			return _setBuildRangeEffectVisible;
		}

		public function set setBuildRangeEffectVisible(value:Boolean):void
		{
			_setBuildRangeEffectVisible = value;
			buildRangeEffect.visible = _setBuildRangeEffectVisible;
		}
    }
}
