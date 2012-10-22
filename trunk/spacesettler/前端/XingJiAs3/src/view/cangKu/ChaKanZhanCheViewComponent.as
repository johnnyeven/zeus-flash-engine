package view.cangKu
{
    import com.zn.multilanguage.MultilanguageManager;
    
    import enum.ResEnum;
    
    import events.cangKu.ChaKanEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    
    import proxy.packageView.PackageViewProxy;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.components.LoaderImage;
    import ui.core.Component;
    
    import vo.cangKu.ZhanCheInfoVO;

    public class ChaKanZhanCheViewComponent extends Component
    {
        public var wpName:Label;

        public var wplevel:Label;

        public var wpScore:Label;

        public var shuXing1:Label;

        public var shuXing2:Label;

        public var shuXing3:Label;

        public var shuXing4:Label;

        public var shuXing5:Label;

        public var shuXing6:Label;

        public var shuXing7:Label;

        public var shuXing8:Label;

        public var backBtn:Button;

        public var wpImage:LoaderImage;

        public function ChaKanZhanCheViewComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            wpName = createUI(Label, "name_tf");
            wplevel = createUI(Label, "level_tf");
            wpScore = createUI(Label, "score_tf");
            shuXing1 = createUI(Label, "attack_tf");
            shuXing2 = createUI(Label, "naiJiu_tf");
            shuXing3 = createUI(Label, "anerge_tf");
            shuXing4 = createUI(Label, "switch_tf");
            shuXing5 = createUI(Label, "jianShang1_tf");
            shuXing6 = createUI(Label, "jianShang2_tf");
            shuXing7 = createUI(Label, "jianShang3_tf");
            shuXing8 = createUI(Label, "jianShang4_tf");
            backBtn = createUI(Button, "back_btn");
            wpImage = createUI(LoaderImage, "wp_image");

            sortChildIndex();

            backBtn.addEventListener(MouseEvent.CLICK, back_clickHandler);

            var packageProxy:PackageViewProxy = ApplicationFacade.getProxy(PackageViewProxy);
            showValue(packageProxy.chakanVO as ZhanCheInfoVO);
        }

        public function showValue(info:ZhanCheInfoVO):void
        {
			if(info==null)
				return;
			
            wpName.text = info.name;
            wplevel.text = info.level + "";
            wpScore.text = info.value + "";

            shuXing1.text = info.attack + "/3"+MultilanguageManager.getString("timeMiao");
            shuXing2.text = info.current_endurance + "/" + info.total_endurance;
            shuXing3.text = info.energy_in_use + "/" + info.total_energy;
            shuXing4.text = info.total_attack_speed + "";
            shuXing5.text = (info.damageDescShiDan * 100) + "%";
            shuXing6.text = (info.damageDescDianCi * 100) + "%";
            shuXing7.text = (info.damageDescJiGuang * 100) + "%";
            shuXing8.text = (info.damageDescAnNeng * 100) + "%";

            wpImage.source = ResEnum.senceEquipment + info.item_type + "_" + info.category + ".png";
        }

        protected function back_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new ChaKanEvent(ChaKanEvent.CLOSEVIEW_EVENT));
        }
    }
}
