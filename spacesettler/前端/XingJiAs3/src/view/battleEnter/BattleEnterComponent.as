package view.battleEnter
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.Sprite;
    
    import ui.core.Component;

    /**
     *飞船入口
     * @author zn
     *
     */
    public class BattleEnterComponent extends Component
    {
        public var infoComp:BattleEnterInfoComponent;

        public var bg:Sprite;

        public function BattleEnterComponent()
        {
            super(ClassUtil.getObject("battleEnter.BattleEnterSkin"));
			
			infoComp=createUI(BattleEnterInfoComponent,"infoComp");
			bg=getSkin("bg");
			
			sortChildIndex();
			
        }
    }
}