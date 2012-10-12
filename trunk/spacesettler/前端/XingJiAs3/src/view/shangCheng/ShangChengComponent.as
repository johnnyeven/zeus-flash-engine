package view.shangCheng
{
    import com.zn.utils.ClassUtil;
    
    import events.allView.AllViewEvent;
    import events.allView.FriendGiveEvent;
    import events.allView.ShopEvent;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import proxy.shangCheng.ShopProxy;
    import proxy.friend.FriendProxy;
    
    import ui.components.Button;
    import ui.components.Container;
    import ui.components.VScrollBar;
    import ui.core.Component;
    import ui.layouts.HTileLayout;
    
    import view.shangCheng.shangChengView.FriendGiveComponent;
    import view.shangCheng.shangChengView.ShuiJingPanelComponent;
    import view.shangCheng.shangChengView.TuZhiComponent;
    import view.shangCheng.shangChengView.ZiYuanComponent;
    
    import vo.allView.ShopInfoVo;
    import vo.allView.ShopItemVo;

    public class ShangChengComponent extends Component
    {
        /**
         * 购买暗能水晶导航按钮
         */
        public var anNengShuiJingBtn:Button;

        /**
         * 资源兑换导航按钮
         */
        public var ziYuanDuiHuanBtn:Button;

        /**
         * 折扣导航按钮
         */
        public var zheKouBtn:Button;

        /**
         * 道具导航按钮
         */
        public var daoJuBtn:Button;

        /**
         *资源容器
         */
        public var ziYuanSprite:Sprite;

        /**
         *折扣容器
         */
        public var zheKouSprite:Sprite;

        /**
         *道具容器
         */
        public var daoJuSprite:Sprite;

        /**
         *水晶容器
         */
        public var shuiJingSprite:Sprite;

        /**
         *关闭按钮
         */
        public var closeBtn:Button;

        /**
         *拖动条
         */
        public var vsBar:VScrollBar;

        private var ziYuanComp:ZiYuanComponent;

        private var shuiJingPanelComp:ShuiJingPanelComponent;

        private var container:Container;

        private var _arr:Array = [];

        private var _currentSelcetedBtn:Button;

        private var shopProxy:ShopProxy;

        private var friendProxy:FriendProxy;

        public function ShangChengComponent()
        {
            super(ClassUtil.getObject("view.allView.ShangChengSkin"));
            shopProxy = ApplicationFacade.getProxy(ShopProxy);
            friendProxy = ApplicationFacade.getProxy(FriendProxy);

            anNengShuiJingBtn = createUI(Button, "anneng_btn");
            ziYuanDuiHuanBtn = createUI(Button, "ziyuan_btn");
            zheKouBtn = createUI(Button, "zhekou_btn");
            daoJuBtn = createUI(Button, "daoju_btn");
            closeBtn = createUI(Button, "close_btn");
            vsBar = createUI(VScrollBar, "vs_bar");

            ziYuanSprite = getSkin("ziyuan_sprite");
            zheKouSprite = getSkin("zhekou_sprite");
            daoJuSprite = getSkin("daoju_sprite");
            shuiJingSprite = getSkin("shuijing_sprite");

            addContainer();
            vsBar.viewport = container;
            vsBar.visible = false;
            anNengShuiJingBtn.toggle = true;
            ziYuanDuiHuanBtn.toggle = true;
            zheKouBtn.toggle = true;
            daoJuBtn.toggle = true;
            currentSelcetedBtn = anNengShuiJingBtn;

            ziYuanComp = new ZiYuanComponent();
            ziYuanSprite.addChild(ziYuanComp);

            shuiJingPanelComp = new ShuiJingPanelComponent();
            shuiJingSprite.addChild(shuiJingPanelComp);

            daoJuSprite.addChild(container);

            sortChildIndex();

            anNengShuiJingBtn.mouseEnabled = false;
            ziYuanDuiHuanBtn.mouseEnabled = true;
            zheKouBtn.mouseEnabled = true;
            daoJuBtn.mouseEnabled = true;

            shuiJingSprite.visible = true;
            ziYuanSprite.visible = false;
            zheKouSprite.visible = false;
            daoJuSprite.visible = false;

            ziYuanDuiHuanBtn.addEventListener(MouseEvent.CLICK, ziYuan_ClickHandler);
            zheKouBtn.addEventListener(MouseEvent.CLICK, zheKou_ClickHandler);
            daoJuBtn.addEventListener(MouseEvent.CLICK, daoJu_ClickHandler);
            anNengShuiJingBtn.addEventListener(MouseEvent.CLICK, shuiJing_ClickHandler);
            closeBtn.addEventListener(MouseEvent.CLICK, close_clickHandler);
            vsBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
            vsBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
        }

        private function addContainer():void
        {
            container = new Container(null);
            container.contentWidth = 520;
            container.contentHeight = 370;
            container.layout = new HTileLayout(container);
            container.layout.hGap = 10;
            container.layout.vGap = 2;
            container.x = 0;
            container.y = 0;
            var array:Array = shopProxy.shopArr
            var length:int = array.length;

            for (var i:int = 0; i < length; i++)
            {
                if (array[i] is ShopInfoVo)
                {
                    var shopinfovo:ShopInfoVo = array[i];

                    var tuzhiComp:TuZhiComponent = new TuZhiComponent();
                    tuzhiComp.moneyText.text = shopinfovo.dark_crystal.toString();
                    tuzhiComp.titleText.text = shopinfovo.name;
                    tuzhiComp.dyData = shopinfovo;
                    addExchangeMouseEvent(tuzhiComp.exchangeBtn);
                    addGiveMouseEvent(tuzhiComp.giveBtn);
                    _arr.push(tuzhiComp);
                    container.add(tuzhiComp);

                }
                else
                {
                    var shopitemvo:ShopItemVo = array[i];

                    var tuZhiComp:TuZhiComponent = new TuZhiComponent();
                    tuZhiComp.moneyText.text = shopitemvo.dark_crystal.toString();
                    tuZhiComp.titleText.text = shopitemvo.name;
                    tuzhiComp.dyData = shopitemvo;
                    addExchangeMouseEvent(tuZhiComp.exchangeBtn);
                    addGiveMouseEvent(tuZhiComp.giveBtn);
                    _arr.push(tuZhiComp);
                    container.add(tuZhiComp);
                }

            }

            container.layout.update();
            vsBar.update();
            container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
            container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);

        }

        protected function mouseOutHandler(event:MouseEvent):void
        {
            vsBar.alpahaTweenlite(0);
        }

        protected function mouseOverHandler(event:MouseEvent):void
        {
            vsBar.alpahaTweenlite(1);
        }

        private function addExchangeMouseEvent(mc:Button):void
        {
            mc.addEventListener(MouseEvent.CLICK, doExchangeHandler);

        }

        private function addGiveMouseEvent(mc:Button):void
        {
            mc.addEventListener(MouseEvent.CLICK, doGiveHandler);
        }

        protected function doExchangeHandler(event:MouseEvent):void
        {

            for (var i:int; i < _arr.length; i++)
            {
                var tuzhiComp:TuZhiComponent = _arr[i];
                if (tuzhiComp.exchangeBtn == event.currentTarget)
                {
					dispatchEvent(new ShopEvent(ShopEvent.BUY_ITEM, true, false,0,"",tuzhiComp.dyData["index"]));
                }
            }

        }

        protected function doGiveHandler(event:MouseEvent):void
        {
            for (var i:int; i < _arr.length; i++)
            {
                var tuzhiComp:TuZhiComponent = _arr[i];
                if (tuzhiComp.giveBtn == event.currentTarget as Button)
                {

                    dispatchEvent(new FriendGiveEvent(FriendGiveEvent.SHOW_FRIENDGIVE, friendProxy.friendArr, tuzhiComp.moneyText.text, i + 1, tuzhiComp.titleText.text));
                }
            }


        }

        protected function close_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new AllViewEvent(AllViewEvent.CLOSED_EVENT));
        }

        protected function shuiJing_ClickHandler(event:MouseEvent):void
        {
            anNengShuiJingBtn.mouseEnabled = false;
            ziYuanDuiHuanBtn.mouseEnabled = true;
            zheKouBtn.mouseEnabled = true;
            daoJuBtn.mouseEnabled = true;

            shuiJingSprite.visible = true;
            ziYuanSprite.visible = false;
            zheKouSprite.visible = false;
            daoJuSprite.visible = false;
            vsBar.visible = false;

            currentSelcetedBtn = anNengShuiJingBtn;
        }

        protected function daoJu_ClickHandler(event:MouseEvent):void
        {
            anNengShuiJingBtn.mouseEnabled = true;
            ziYuanDuiHuanBtn.mouseEnabled = true;
            zheKouBtn.mouseEnabled = true;
            daoJuBtn.mouseEnabled = false;

            shuiJingSprite.visible = false;
            ziYuanSprite.visible = false;
            zheKouSprite.visible = false;
            daoJuSprite.visible = true;
            vsBar.visible = true;

            currentSelcetedBtn = daoJuBtn;
        }

        protected function zheKou_ClickHandler(event:MouseEvent):void
        {
            anNengShuiJingBtn.mouseEnabled = true;
            ziYuanDuiHuanBtn.mouseEnabled = true;
            zheKouBtn.mouseEnabled = false;
            daoJuBtn.mouseEnabled = true;

            shuiJingSprite.visible = false;
            ziYuanSprite.visible = false;
            zheKouSprite.visible = true;
            daoJuSprite.visible = false;
            vsBar.visible = false;

            currentSelcetedBtn = zheKouBtn;

        }

        protected function ziYuan_ClickHandler(event:MouseEvent):void
        {
            anNengShuiJingBtn.mouseEnabled = true;
            ziYuanDuiHuanBtn.mouseEnabled = false;
            zheKouBtn.mouseEnabled = true;
            daoJuBtn.mouseEnabled = true;

            shuiJingSprite.visible = false;
            ziYuanSprite.visible = true;
            zheKouSprite.visible = false;
            daoJuSprite.visible = false;
            vsBar.visible = false;

            currentSelcetedBtn = ziYuanDuiHuanBtn;
        }

        public function get currentSelcetedBtn():Button
        {
            return _currentSelcetedBtn;
        }

        public function set currentSelcetedBtn(value:Button):void
        {
            if (_currentSelcetedBtn)
            {
                _currentSelcetedBtn.selected = false;
                _currentSelcetedBtn = null;
            }
            _currentSelcetedBtn = value;

            _currentSelcetedBtn.selected = true;
        }

    }
}
