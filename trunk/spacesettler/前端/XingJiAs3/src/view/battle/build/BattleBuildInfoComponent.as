package view.battle.build
{
    import com.zn.utils.ClassUtil;

    import flash.events.MouseEvent;

    import ui.components.Button;
    import ui.components.Label;
    import ui.components.Window;
    import ui.core.Component;

    import vo.battle.BattleBuildVO;

    /**
     *战场显示建筑信息界面
     * @author zn
     *
     */
    public class BattleBuildInfoComponent extends Window
    {
        public var close_btn:Button;

        public var endurace_tf:Label;

        public var attact_tf:Label;

        public var descrip_tf:Label;

        public var name_tf:Label;

        private var _buildVO:BattleBuildVO;

        public function BattleBuildInfoComponent()
        {
            super(ClassUtil.getObject("battle.BattleBuildInfoSkin"));

            close_btn = createUI(Button, "close_btn");
            endurace_tf = createUI(Label, "endurace_tf");
            attact_tf = createUI(Label, "attact_tf");
            descrip_tf = createUI(Label, "descrip_tf");
            name_tf = createUI(Label, "name_tf");

            sortChildIndex();

            close_btn.addEventListener(MouseEvent.CLICK, closeBtn_clickHandler);
        }

        public function get buildVO():BattleBuildVO
        {
            return _buildVO;
        }

        public function set buildVO(value:BattleBuildVO):void
        {
            _buildVO = value;

            name_tf.text = buildVO.name;
            descrip_tf.text = buildVO.des;
            attact_tf.text = buildVO.attack + "";
            endurace_tf.text = buildVO.endurance + "";
        }
    }
}
