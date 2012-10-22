package view.cangKu
{
    import com.greensock.TweenLite;
    import com.zn.utils.ClassUtil;
    
    import enum.factory.FactoryEnum;
    import enum.item.ItemEnum;
    
    import events.buildingView.AddViewEvent;
    import events.cangKu.ChaKanEvent;
    import events.cangKu.DonateEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.packageView.PackageViewProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.components.Button;
    import ui.components.Container;
    import ui.components.Label;
    import ui.components.VScrollBar;
    import ui.core.Component;
    import ui.layouts.HTileLayout;
    import ui.utils.DisposeUtil;
    
    import vo.BuildInfoVo;
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.GuaJianInfoVO;
    import vo.cangKu.ZhanCheInfoVO;

    /**
     * 查看物资仓库界面
     *
     */
    public class CangkuPackageViewComponent extends Component
    {
        public var shuiJinRL:Label; //水晶容量

        public var anWuZhiRL:Label; //暗物质容量

        public var chuanQiRL:Label; //氚气容量

        public var anNengShuiJinRL:Label; //暗能水晶容量

        public var boxNumRL:Label; //背包格子占用/背包格子总数 初始 0/20

        public var vScrollBar:VScrollBar; //拖动条

        public var buyBtn:Button; //购买仓位按钮

        public var closeBtn:Button; //关闭按钮

        public var gridComp:CangKuGridComponent; //格子

        public var mcUp:Component;

        public var mcDown:Component;

        public var menuLine:MovieClip;

        public var zhuangPeiBtn:Button;

        public var qiangHuaBtn:Button;

        public var weiXiuBtn:Button;

        public var chaKanBtn:Button;

        public var useBtn:Button;

        public var xiaoHuiBtn:Button;

        public var juanXianBtn:Button;

        public var diuQiBtn:Button;

        public var menuMask:Sprite;

        public var jxComp:Component;

        public var jxClose:Button;

        public var jxBtn:Button;

        public var container:Container;

        public var curNum:int = 0;

        private var _buildVO:BuildInfoVo;

        private var obj:Object;

        private var hasLegion:Boolean;

        private var selectedItemVO:BaseItemVO;
		
		private var userInfoProxy:UserInfoProxy

        public function CangkuPackageViewComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            shuiJinRL = createUI(Label, "shuiJinRL_tf");
            anWuZhiRL = createUI(Label, "anWuZhiRL_tf");
            chuanQiRL = createUI(Label, "chuanQiRL_tf");
            anNengShuiJinRL = createUI(Label, "anNengShuiJinRL_tf");
            boxNumRL = createUI(Label, "boxNum_tf");

            buyBtn = createUI(Button, "buy_button");
            closeBtn = createUI(Button, "close_button");

            obj = new Object();

            container = new Container(null);
            container.contentWidth = 325;
            container.contentHeight = 335;
            container.layout = new HTileLayout(container);
            container.x = 12.5;
            container.y = 147.5;
            addChild(container);

            container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
            container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);

            vScrollBar = createUI(VScrollBar, "vScrollBar");
            vScrollBar.viewport = container;
            vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
            vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
            vScrollBar.alpahaTweenlite(0);

            sortChildIndex();

            addChild(vScrollBar);

            buyBtn.addEventListener(MouseEvent.CLICK, buyBtn_clickHandler);
            closeBtn.addEventListener(MouseEvent.CLICK, closeBtn_clickHandler);

            var userInfoProxy:UserInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
			hasLegion = userInfoProxy.userInfoVO.legion_id != null ? true : false;

            var packageViewProxy:PackageViewProxy = ApplicationFacade.getProxy(PackageViewProxy);

            cwList.push(BindingUtils.bindProperty(shuiJinRL, "text", userInfoProxy, [ "userInfoVO", "crystal" ]));
            cwList.push(BindingUtils.bindProperty(anWuZhiRL, "text", userInfoProxy, [ "userInfoVO", "broken_crysta" ]));
            cwList.push(BindingUtils.bindProperty(chuanQiRL, "text", userInfoProxy, [ "userInfoVO", "tritium" ]));
            cwList.push(BindingUtils.bindProperty(anNengShuiJinRL, "text", userInfoProxy, [ "userInfoVO", "dark_crystal" ]));
            cwList.push(BindingUtils.bindSetter(itemVOListChange, packageViewProxy, "itemVOList"));
        }

        private function removeAllItem():void
        {
            while (container.num > 0)
                DisposeUtil.dispose(container.removeAt(0));
        }

        public function itemVOListChange(value:Array):void
        {
            removeAllItem();
			curNum=0;
            for (var i:int = 0; i < value.length; i++)
            {
                gridComp = new CangKuGridComponent();
                if (value[i] != null)
                {
                    gridComp.info = value[i];
                    gridComp.addEventListener(MouseEvent.CLICK, grid_clickHandler);
                    curNum++;
                }
                gridComp.dyData = i;

                container.add(gridComp);
            }

            container.layout.update();

            boxNumRL.text = curNum + "/" + value.length;
            vScrollBar.update();
        }

        //点击物品 弹出选项菜单
        protected function grid_clickHandler(event:MouseEvent):void
        {
			
            var grid:CangKuGridComponent = event.currentTarget as CangKuGridComponent;
			var index:int=grid.dyData;
            var isLeft:Boolean = index % 3 == 0 ? true : false;
            var point:Point = new Point(grid.width / 2, grid.height / 2);
            point = grid.localToGlobal(point);
            point = globalToLocal(point);

            menuMask = new Sprite();
            menuMask.graphics.beginFill(0, 0.5);
            menuMask.graphics.drawRect(0, 0, this.width, this.height);
            menuMask.graphics.endFill();
            addChild(menuMask);

            selectedItemVO = grid.info;

            DisposeUtil.dispose(mcUp);
            DisposeUtil.dispose(mcDown);
            DisposeUtil.dispose(menuLine);
			
            if (hasLegion)
            {
                if (selectedItemVO.item_type == ItemEnum.Chariot) //Chariot
                {
                    mcUp = new Component(ClassUtil.getObject("up1_menu")); //装配  强化  维修
                    zhuangPeiBtn = mcUp.createUI(Button, "zhuangPei_btn");
                    qiangHuaBtn = mcUp.createUI(Button, "qiangHua_btn");
                    weiXiuBtn = mcUp.createUI(Button, "weiXiu_btn");
                    mcUp.sortChildIndex();

                    mcDown = new Component(ClassUtil.getObject("down3_menu")); //查看  捐给军团
                    chaKanBtn = mcDown.createUI(Button, "chaKan_btn");
                    juanXianBtn = mcDown.createUI(Button, "juanGei_btn");
                    mcDown.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right1_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left1_line_menu");
                    }
                }
                else if (selectedItemVO.item_type == ItemEnum.TankPart) //TankPart
                {
                    mcUp = new Component(ClassUtil.getObject("up2_menu")); //查看  销毁
                    chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
                    xiaoHuiBtn = mcUp.createUI(Button, "xiaoHui_btn");
                    mcUp.sortChildIndex();

                    mcDown = new Component(ClassUtil.getObject("down2_menu")); //捐给军团
                    juanXianBtn = mcDown.createUI(Button, "juanGei_btn");
                    mcDown.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right1_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left1_line_menu");
                    }
                }
                else if (selectedItemVO.item_type == ItemEnum.recipes) //recipes
                {
                    mcUp = new Component(ClassUtil.getObject("up3_menu")); //查看  丢弃
                    chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
                    diuQiBtn = mcUp.createUI(Button, "diuQi_btn");
                    mcUp.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right2_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left2_line_menu");
                    }
                }
                else //item
                {
                    mcUp = new Component(ClassUtil.getObject("up4_menu")); //查看 使用 销毁
                    chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
                    useBtn = mcUp.createUI(Button, "use_btn");
                    diuQiBtn = mcUp.createUI(Button, "xiaoHui_btn");
                    mcUp.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right2_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left2_line_menu");
                    }
                }
            }
            else
            {
                if (selectedItemVO.item_type == ItemEnum.Chariot) //chariot
                {
                    mcUp = new Component(ClassUtil.getObject("up1_menu")); //装配  强化  维修
                    zhuangPeiBtn = mcUp.createUI(Button, "zhuangPei_btn");
                    qiangHuaBtn = mcUp.createUI(Button, "qiangHua_btn");
                    weiXiuBtn = mcUp.createUI(Button, "weiXiu_btn");
                    mcUp.sortChildIndex();

                    mcDown = new Component(ClassUtil.getObject("down1_menu")); //查看
                    chaKanBtn = mcDown.createUI(Button, "chaKan_btn");
                    mcDown.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right1_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left1_line_menu");
                    }
                }
                else if (selectedItemVO.item_type == ItemEnum.TankPart) //TankPart
                {
                    mcUp = new Component(ClassUtil.getObject("up2_menu")); //查看  销毁
                    chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
                    xiaoHuiBtn = mcUp.createUI(Button, "xiaoHui_btn");
                    mcUp.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right2_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left2_line_menu");
                    }
                }
                else if (selectedItemVO.item_type == ItemEnum.recipes) //recipes
                {
                    mcUp = new Component(ClassUtil.getObject("up3_menu")); //查看  丢弃
                    chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
                    diuQiBtn = mcUp.createUI(Button, "diuQi_btn");
                    mcUp.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right2_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left2_line_menu");
                    }
                }
                else //item
                {
                    mcUp = new Component(ClassUtil.getObject("up4_menu")); //查看 使用 销毁
                    chaKanBtn = mcUp.createUI(Button, "chaKan_btn");
                    useBtn = mcUp.createUI(Button, "use_btn");
                    diuQiBtn = mcUp.createUI(Button, "xiaoHui_btn");
                    mcUp.sortChildIndex();

                    if (isLeft)
                    {
                        menuLine = ClassUtil.getObject("right2_line_menu");
                    }
                    else
                    {
                        menuLine = ClassUtil.getObject("left2_line_menu");
                    }
                }
            }
            menuLine.x = point.x;
            menuLine.y = point.y;
            mcUp.y = 50;
            if (mcDown)
                mcDown.y = 500;

            menuMask.addChild(mcUp);
            if (mcDown)
                menuMask.addChild(mcDown);
            menuMask.addChild(menuLine);
            move();

            menuMask.addEventListener(MouseEvent.CLICK, remove_clickHandler);
            chaKanBtn.addEventListener(MouseEvent.CLICK, chaKan_clickHandler);
			
            if (juanXianBtn)
                juanXianBtn.addEventListener(MouseEvent.CLICK, juanXian_clickHandler);
            if (xiaoHuiBtn)
                xiaoHuiBtn.addEventListener(MouseEvent.CLICK, xiaoHuiBtn_clickHandler);
            if (zhuangPeiBtn)
                zhuangPeiBtn.addEventListener(MouseEvent.CLICK, zhuangPeiBtn_clickHandler);
            if (diuQiBtn)
                diuQiBtn.addEventListener(MouseEvent.CLICK, xiaoHuiBtn_clickHandler);
            if (qiangHuaBtn)
                qiangHuaBtn.addEventListener(MouseEvent.CLICK, qiangHuaBtn_clickHandler);
            if (weiXiuBtn)
                weiXiuBtn.addEventListener(MouseEvent.CLICK, weiXiuBtn_clickHandler);
            if (useBtn)
				useBtn.addEventListener(MouseEvent.CLICK, useBtn_clickHandler);
        }
		
        public function move():void
        {
			var rect:Rectangle=menuLine.getRect(menuLine);
			
            TweenLite.to(mcUp, 0.5, { y: menuLine.y + rect.top -mcUp.height- 2 });
            if (mcDown)
                TweenLite.to(mcDown, 0.5, { y: menuLine.y + rect.bottom+2});
        }

        protected function remove_clickHandler(event:MouseEvent):void
        {
            this.removeChild(menuMask);
            menuMask = null;
        }

        protected function mouseOutHandler(event:MouseEvent):void
        {
            vScrollBar.alpahaTweenlite(0);
        }

        protected function mouseOverHandler(event:MouseEvent):void
        {
            vScrollBar.alpahaTweenlite(1);
        }

        //购买仓位 消耗暗能水晶
        protected function buyBtn_clickHandler(event:MouseEvent):void
        {
			dispatchEvent(new DonateEvent(DonateEvent.ADDSPACE_EVENT));
        }
		
		//使用道具
		protected function useBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new DonateEvent(DonateEvent.USE_EVENT, selectedItemVO));
		}

        //关闭窗口
        protected function closeBtn_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
        }


        //添加物品查看界面
        protected function chaKan_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new ChaKanEvent(ChaKanEvent.ADDCHAKANVIEW_EVENT, selectedItemVO));
        }

        //添加物品捐献界面
        protected function juanXian_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new DonateEvent(DonateEvent.DONATE_EVENT, selectedItemVO));
        }

        //添加消毁界面
        protected function xiaoHuiBtn_clickHandler(event:MouseEvent):void
        {
			dispatchEvent(new DonateEvent(DonateEvent.DESTROY_EVENT, selectedItemVO));
        }

        //添加装配界面
        protected function zhuangPeiBtn_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new ChaKanEvent(ChaKanEvent.ZHUANGPEI_EVENT,selectedItemVO));
			
		}
        //添加强化界面
        protected function qiangHuaBtn_clickHandler(event:MouseEvent):void
        {
			dispatchEvent(new ChaKanEvent(ChaKanEvent.QIANGHUA_EVENT,selectedItemVO));
        }

        //添加维修界面
        protected function weiXiuBtn_clickHandler(event:MouseEvent):void
        {
			dispatchEvent(new ChaKanEvent(ChaKanEvent.WEIXIU_EVENT,selectedItemVO));
        }
    }
}
