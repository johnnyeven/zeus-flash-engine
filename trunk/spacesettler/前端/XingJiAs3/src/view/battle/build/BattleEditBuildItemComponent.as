package view.battle.build
{
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;
    
    import enum.battle.BattleBuildStateEnum;
    
    import events.battle.BattleBuildEvent;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import mx.binding.utils.BindingUtils;
    
    import ui.core.Component;
    import ui.utils.DisposeUtil;
    
    import vo.battle.BattleBuildVO;

    /**
     *战场编辑建筑
     * @author zn
     *
     */
    public class BattleEditBuildItemComponent extends Component
    {
        private var _buildVO:BattleBuildVO;

        private var _buildSp:Sprite;

        public function BattleEditBuildItemComponent()
        {
            super(null);

            buttonMode = true;
            addEventListener(MouseEvent.CLICK, mouse_clickHandler);
        }
        public function get buildVO():BattleBuildVO
        {
            return _buildVO;
        }

        public function set buildVO(value:BattleBuildVO):void
        {
            _buildVO = value;

            removeCWList();

            cwList.push(BindingUtils.bindSetter(stateChange, buildVO, "state"));
            cwList.push(BindingUtils.bindSetter(stateChange, buildVO, "type"));
            x = value.x;
            y = value.y;
        }

        private function stateChange(value:*):void
        {
            DisposeUtil.dispose(_buildSp);
            var className:String = "";

            if (buildVO.state == BattleBuildStateEnum.build)
                className = StringUtil.formatString("build_icon_{0}_build", buildVO.type);
            else if (buildVO.state == BattleBuildStateEnum.normal)
                className = StringUtil.formatString("build_icon_{0}_normal", buildVO.type);

            _buildSp = ClassUtil.getObject(className);
            addChild(_buildSp);
			
			if (buildVO.state == BattleBuildStateEnum.build)
			{
				var timeComp:BattleBuildTimeBarComponent=new BattleBuildTimeBarComponent();
				timeComp.buildVO=buildVO;
				timeSp.addChild(timeComp);
			}
        }
		
		public function get timeSp():Sprite
		{
			return _buildSp.getChildByName("timeSp") as Sprite;
		}

        protected function mouse_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new BattleBuildEvent(BattleBuildEvent.BUILD_CLICK_EVENT, buildVO));
        }
    }
}
