package view.cangKu
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.ResEnum;
    import enum.item.ItemEnum;
    
    import proxy.packageView.PackageViewProxy;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.components.LoaderImage;
    import ui.core.Component;
    
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.GuaJianInfoVO;
    import vo.cangKu.ItemVO;
    import vo.cangKu.ZhanCheInfoVO;

    public class CangKuGridComponent extends Component
    {
        public var wpName:Label;

        public var wpLevel:Label;

        public var jiLabel:Label;

        public var image:LoaderImage;

        public var typeImage:LoaderImage;

        public var grid:Button;

        private var _info:BaseItemVO;

        public function CangKuGridComponent()
        {
            super(ClassUtil.getObject("grid_skin"));
            wpName = createUI(Label, "wpName_tf");
            wpLevel = createUI(Label, "level_tf");
            jiLabel = createUI(Label, "ji_tf");
            typeImage = createUI(LoaderImage, "typeImage");
            image = createUI(LoaderImage, "image");
            grid = createUI(Button, "grid_button");

            sortChildIndex();
			
			info=null;
        }

        public function get info():BaseItemVO
        {
            return _info;
        }

        public function set info(value:BaseItemVO):void
        {
            _info = value;

            wpName.text = "";
            wpLevel.text = "";
            jiLabel.visible = false;
            image.source = null;
            typeImage.source = null;

            if (info)
            {
                switch (value.item_type)
                {
                    case ItemEnum.Chariot:
                    {
                        wpName.text = info.name + MultilanguageManager.getString("chariot");
                        wpLevel.text = (info as ZhanCheInfoVO).level + "";
                        jiLabel.visible = true;
                        image.source =info.iconURL;
                        break;
                    }
                    case ItemEnum.TankPart:
                    {
                        wpName.text = info.name + MultilanguageManager.getString("tankPart");
                        wpLevel.text = (info as GuaJianInfoVO).level + "";
                        jiLabel.visible = true;
						image.source =info.iconURL;
                        typeImage.source = ResEnum.getEnhanceIconURL(info.enhanced);
                        break;
                    }
                    case ItemEnum.recipes:
                    {
                        wpName.text = info.name ;
                        //                    wpLevel.text = info.level+"";
                        wpLevel.visible = false;
                        jiLabel.visible = false;
						image.source =info.iconURL;

                        break;
                    }
                    case ItemEnum.item:
                    {
						var obj:Object=info as Object;
                        wpName.text = info.name;
                        //                    wpLevel.text = info.level+"";
                        wpLevel.visible = false;
                        jiLabel.visible = false;
						if(obj.key=="vip_level_1")
							image.source =info.iconURL+ "1.png";
						if(obj.key=="vip_level_2")
							image.source =info.iconURL+ "2.png";
						if(obj.key=="vip_level_3")
							image.source =info.iconURL+ "3.png";
						
						image.y+=15;
						image.x+=10;
                        break;
                    }
                }
            }
        }
    }
}
