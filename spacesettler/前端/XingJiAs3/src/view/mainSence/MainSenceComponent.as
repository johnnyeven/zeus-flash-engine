package view.mainSence
{
    import com.greensock.loading.BinaryDataLoader;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;

    import enum.BuildTypeEnum;
    import enum.MainSenceEnum;

    import events.buildEvent.BuildCompleteEvent;
    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import mx.binding.utils.BindingUtils;

    import proxy.BuildProxy;
    import proxy.userInfo.UserInfoProxy;

    import ui.components.LoaderImage;
    import ui.core.Component;

    import vo.BuildInfoVo;

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

        public var jiDiSp:Sprite;

        public var chuanQinSp:Sprite;

        public var anNengDianChangSp:Sprite;

        public var cangKuSp:Sprite;

        public var kuangChangSp:Sprite;

        public var keJiSp:Sprite;

        public var junGongChangSp:Sprite;

        public var shiJianJiQiSp:Sprite;

        public var xingQiuLoaderImage:LoaderImage;

        public var puBuLoaderImage:LoaderImage;

        public var dengGuangLoaderImage:LoaderImage;

        public var guanDaoLoaderImage:LoaderImage;

        public var buildCompDic:Object = {};

        public function MainSenceComponent()
        {
            _userInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
            super(ClassUtil.getObject("MainSence_" + _userInfoProxy.userInfoVO.camp));
			
            jiDiSp = getSkin("sprite_1");
            chuanQinSp = getSkin("sprite_2");
            anNengDianChangSp = getSkin("sprite_3");
            cangKuSp = getSkin("sprite_4");
            kuangChangSp = getSkin("sprite_5");
            keJiSp = getSkin("sprite_6");
            junGongChangSp = getSkin("sprite_7");
            shiJianJiQiSp = getSkin("sprite_8");

            sortChildIndex();

            addMouseClick(jiDiSp);
            addMouseClick(chuanQinSp);
            addMouseClick(anNengDianChangSp);
            addMouseClick(cangKuSp);
            addMouseClick(kuangChangSp);
            addMouseClick(keJiSp);
            addMouseClick(junGongChangSp);



            var buildProxy:BuildProxy = ApplicationFacade.getProxy(BuildProxy);
            cwList.push(BindingUtils.bindSetter(buildListChange, buildProxy, "buildArr"));
        }

        public override function dispose():void
        {
            super.dispose();
            buildCompDic = null;
        }

        private function addMouseClick(sp:Sprite):void
        {
            sp.addEventListener(MouseEvent.CLICK, doClickHandler);
        }

        protected function doClickHandler(event:MouseEvent):void
        {
            var buildProxy:BuildProxy = ApplicationFacade.getProxy(BuildProxy);
            var sp:Sprite = event.currentTarget as Sprite;
            var clickSp:Sprite = sp.getChildByName("click_sprite") as Sprite;
            var buildVO:BuildInfoVo;

            switch (sp)
            {
                case jiDiSp:
                {
                    //只有一种点击  升级
                    dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                           MultilanguageManager.getString("buildSelectorFieldUp"),
                                                           MultilanguageManager.getString("buildSelectorFieldRongYu"),
                                                           MultilanguageManager.getString("buildSelectorFieldZongLan"),
                                                           4, clickSp.localToGlobal(new Point()), BuildTypeEnum.CENTER));
                    break;
                }
                case chuanQinSp:
                {
                    //判断是否有建筑 然后确认是升级还是建造
                    if (!buildProxy.hasBuild(BuildTypeEnum.CHUANQIN))
                    {
                        dispatchEvent(new AddViewEvent(AddViewEvent.ADDCHUANQINCREATEVIEW_EVENT, BuildTypeEnum.CHUANQIN));
                    }
                    else
                    {
                        buildVO = buildProxy.getBuild(BuildTypeEnum.CHUANQIN);
						if(buildVO.isBuild)
							dispatchEvent(new AddViewEvent(AddViewEvent.ADDCHUANQINCREATEVIEW_EVENT, BuildTypeEnum.CHUANQIN));
                        if (!buildVO.isBuild)
                            dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                                   MultilanguageManager.getString("buildSelectorFieldUp"),
                                                                   null,
                                                                   null,
                                                                   2, clickSp.localToGlobal(new Point()), BuildTypeEnum.CHUANQIN));
                    }
                    break;
                }
                case anNengDianChangSp:
                {
                    //判断是否有建筑 然后确认是升级还是建造
                    if (!buildProxy.hasBuild(BuildTypeEnum.DIANCHANG))
                    {
                        dispatchEvent(new AddViewEvent(AddViewEvent.ADDDIANCHANGCREATEVIEW_EVENT, BuildTypeEnum.DIANCHANG));
                    }
                    else
                    {
                        buildVO = buildProxy.getBuild(BuildTypeEnum.DIANCHANG);
						if(buildVO.isBuild)
							dispatchEvent(new AddViewEvent(AddViewEvent.ADDDIANCHANGCREATEVIEW_EVENT, BuildTypeEnum.DIANCHANG));
                        if (!buildVO.isBuild)
                            dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                                   MultilanguageManager.getString("buildSelectorFieldUp"),
                                                                   null,
                                                                   null,
                                                                   2, clickSp.localToGlobal(new Point()), BuildTypeEnum.DIANCHANG));
                    }
                    break;
                }
                case cangKuSp:
                {
                    //判断是否有建筑 然后确认是升级还是建造
                    if (!buildProxy.hasBuild(BuildTypeEnum.CANGKU))
                    {
                        dispatchEvent(new AddViewEvent(AddViewEvent.ADDCANGKUCREATEVIEW_EVENT, BuildTypeEnum.CANGKU));
                    }
                    else
                    {
                        buildVO = buildProxy.getBuild(BuildTypeEnum.CANGKU);
						if(buildVO.isBuild)
							dispatchEvent(new AddViewEvent(AddViewEvent.ADDCANGKUCREATEVIEW_EVENT, BuildTypeEnum.CANGKU));
                        if (!buildVO.isBuild)
                            dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                                   MultilanguageManager.getString("buildSelectorFieldUp"),
                                                                   MultilanguageManager.getString("buildSelectorFieldChaKan"),
                                                                   null,
                                                                   3, clickSp.localToGlobal(new Point()), BuildTypeEnum.CANGKU));
                    }
                    break;
                }
                case kuangChangSp:
                {
                    //判断是否有建筑 然后确认是升级还是建造
                    if (!buildProxy.hasBuild(BuildTypeEnum.KUANGCHANG))
                    {
                        dispatchEvent(new AddViewEvent(AddViewEvent.ADDYELIANCREATEVIEW_EVENT, BuildTypeEnum.KUANGCHANG));
                    }
                    else
                    {
                        buildVO = buildProxy.getBuild(BuildTypeEnum.KUANGCHANG);
						if(buildVO.isBuild)
							dispatchEvent(new AddViewEvent(AddViewEvent.ADDYELIANCREATEVIEW_EVENT, BuildTypeEnum.KUANGCHANG));
                        if (!buildVO.isBuild)
                            dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                                   MultilanguageManager.getString("buildSelectorFieldUp"),
                                                                   MultilanguageManager.getString("buildSelectorFieldRongLan"),
                                                                   null,
                                                                   3, clickSp.localToGlobal(new Point()), BuildTypeEnum.KUANGCHANG));
                    }
                    break;
                }
                case keJiSp:
                {
                    //判断是否有建筑 然后确认是升级还是建造
                    if (!buildProxy.hasBuild(BuildTypeEnum.KEJI))
                    {
                        dispatchEvent(new AddViewEvent(AddViewEvent.ADDKEJICREATEVIEW_EVENT, BuildTypeEnum.KEJI));
                    }
                    else
                    {
                        buildVO = buildProxy.getBuild(BuildTypeEnum.KEJI);
						if(buildVO.isBuild)
							dispatchEvent(new AddViewEvent(AddViewEvent.ADDKEJICREATEVIEW_EVENT, BuildTypeEnum.KEJI));
                        if (!buildVO.isBuild)
                            dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                                   MultilanguageManager.getString("buildSelectorFieldUp"),
                                                                   MultilanguageManager.getString("buildSelectorFieldKeYan"),
                                                                   null,
                                                                   3, clickSp.localToGlobal(new Point()), BuildTypeEnum.KEJI));
                    }
                    break;
                }
                case junGongChangSp:
                {
                    //判断是否有建筑 然后确认是升级还是建造
                    if (!buildProxy.hasBuild(BuildTypeEnum.JUNGONGCHANG))
                    {
                        dispatchEvent(new AddViewEvent(AddViewEvent.ADDJUNGONGCREATEVIEW_EVENT, BuildTypeEnum.JUNGONGCHANG));
                    }
                    else
                    {
                        buildVO = buildProxy.getBuild(BuildTypeEnum.JUNGONGCHANG);
						if(buildVO.isBuild)
							dispatchEvent(new AddViewEvent(AddViewEvent.ADDJUNGONGCREATEVIEW_EVENT, BuildTypeEnum.JUNGONGCHANG));
                        if (!buildVO.isBuild)
                            dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                                   MultilanguageManager.getString("buildSelectorFieldGaiZhang"),
                                                                   MultilanguageManager.getString("buildSelectorFieldWeiXiu"),
                                                                   MultilanguageManager.getString("buildSelectorFieldZhiZao"),
                                                                   4, clickSp.localToGlobal(new Point()), BuildTypeEnum.JUNGONGCHANG));
                    }
                    break;
                }
                case shiJianJiQiSp:
                {
                    //只有一种点击  查看
                    dispatchEvent(new AddSelectorViewEvent(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,
                                                           MultilanguageManager.getString("buildSelectorFieldTime"),
                                                           null,
                                                           null,
                                                           2, clickSp.localToGlobal(new Point()), BuildTypeEnum.SHIJINMAC));
                    break;
                }
            }
        }

        private function buildListChange(value:Array):void
        {
            for (var i:int; i < value.length; i++)
            {
                var buildInfoVo:BuildInfoVo = value[i];

                var buildComp:BuildComponent = buildCompDic[buildInfoVo.type];
                if (buildComp == null)
                {
                    buildComp = new BuildComponent();
                    buildCompDic[buildInfoVo.type] = buildComp;
                    buildComp.buildInfoVo = buildInfoVo;

                    if (buildInfoVo.type == BuildTypeEnum.CENTER)
                        jiDiSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.CHUANQIN)
                        chuanQinSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.DIANCHANG)
                        anNengDianChangSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.CANGKU)
                        cangKuSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.KUANGCHANG)
                        kuangChangSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.KEJI)
                        keJiSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.JUNGONGCHANG)
                        junGongChangSp.addChild(buildComp);
                    else if (buildInfoVo.type == BuildTypeEnum.SHIJINMAC)
                    {
                        shiJianJiQiSp.addChild(buildComp);
                        addMouseClick(shiJianJiQiSp);
                    }
                }
            }
        }

        private function judgeType(buildInfoVo:BuildInfoVo):void
        {
        }
    }
}
