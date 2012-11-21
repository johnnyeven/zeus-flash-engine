package view.battleEnter
{
    import com.zn.utils.ClassUtil;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    import ui.components.Label;
    import ui.components.LoaderImage;
    import ui.core.Component;
    import vo.cangKu.ZhanCheInfoVO;

    /**
     *飞船项
     * @author zn
     *
     */
    public class BattleEnterItemComonent extends Component
    {
        public var unselectedSP:Sprite;

        public var naiJiuLabel:Label;

        public var gongJiLabel:Label;

        public var pingFenLabel:Label;

        public var image:LoaderImage;

        public var levelLabel:Label;

        public var nameLabel:Label;

        private var _itemVO:ZhanCheInfoVO;

        public function BattleEnterItemComonent()
        {
            super(ClassUtil.getObject("battleEnter.BattleEnterItemSkin"));

            unselectedSP = getSkin("unselectedSP");
            naiJiuLabel = createUI(Label, "naiJiuLabel");
            gongJiLabel = createUI(Label, "gongJiLabel");
            pingFenLabel = createUI(Label, "pingFenLabel");
            levelLabel = createUI(Label, "levelLabel");
            nameLabel = createUI(Label, "nameLabel");
            image = createUI(LoaderImage, "image");

            sortChildIndex();

			buttonMode=true;
        }

        public function set selected(value:Boolean):void
        {
            unselectedSP.visible = !value;
        }

        public function get itemVO():ZhanCheInfoVO
        {
            return _itemVO;
        }

        public function set itemVO(value:ZhanCheInfoVO):void
        {
            _itemVO = value;

            nameLabel.text = itemVO.name;
            levelLabel.text = itemVO.level + "";
            pingFenLabel.text = itemVO.value + "";
            gongJiLabel.text = itemVO.attack + "";
            naiJiuLabel.text = itemVO.current_endurance + "";
            image.source = itemVO.iconURL;
        }
    }
}
