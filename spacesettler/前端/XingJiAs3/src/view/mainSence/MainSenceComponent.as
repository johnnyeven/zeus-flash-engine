package view.mainSence
{
    import com.zn.utils.ClassUtil;
    
    import enum.MainSenceEnum;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import proxy.userInfo.UserInfoProxy;
    
    import ui.components.LoaderImage;
    import ui.core.Component;

    /**
     *主场景
     * @author zn
     *
     */
    public class MainSenceComponent extends Component
    {
        private var _userInfoProxy:UserInfoProxy;

        public var xingQiuSp:Sprite;
		public var puBuSp:Sprite;
		public var dengGuangSp:Sprite;
		public var guanDaoSp:Sprite;

        public var xingQiuLoaderImage:LoaderImage;
		public var puBuLoaderImage:LoaderImage;
		public var dengGuangLoaderImage:LoaderImage;
		public var guanDaoLoaderImage:LoaderImage;

        public function MainSenceComponent()
        {
            _userInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
            super(ClassUtil.getObject("MainSence_" + _userInfoProxy.userInfoVO.camp));

            xingQiuSp = getSkin("xingQiuSp");
			puBuSp=getSkin("puBuSp");
			dengGuangSp=getSkin("dengGuangSp");
			guanDaoSp=getSkin("guanDaoSp");

            sortChildIndex();

            xingQiuLoaderImage = new LoaderImage();
            xingQiuLoaderImage.source = MainSenceEnum.xingQiuURL;
            xingQiuSp.addChild(xingQiuLoaderImage);
			
			puBuLoaderImage=new LoaderImage();
			puBuLoaderImage.source=MainSenceEnum.puBuURL;
			puBuSp.addChild(puBuLoaderImage);
			
			dengGuangLoaderImage=new LoaderImage();
			dengGuangLoaderImage.source=MainSenceEnum.dengGuangURL;
			dengGuangSp.addChild(dengGuangLoaderImage);
			
			guanDaoLoaderImage=new LoaderImage();
			guanDaoLoaderImage.source=MainSenceEnum.guanDaoURL;
			guanDaoSp.addChild(guanDaoLoaderImage);
        }
    }
}
