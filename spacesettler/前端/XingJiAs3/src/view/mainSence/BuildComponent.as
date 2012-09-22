package view.mainSence
{
    import com.greensock.TweenLite;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;
    
    import enum.BuildTypeEnum;
    import enum.MainSenceEnum;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.userInfo.UserInfoProxy;
    
    import ui.core.Component;
    import ui.utils.DisposeUtil;
    
    import view.mainView.BuildUpLoaderViewComponent;
    
    import vo.BuildInfoVo;
    import vo.userInfo.UserInfoVO;

    public class BuildComponent extends Component
    {
        private var _buildInfoVo:BuildInfoVo;

        private var buildUp:BuildUpLoaderViewComponent;

        public var userInfoVO:UserInfoVO;

        private var buildSp:Sprite;

        private var spriteLoader:Sprite;

        private var spriteUp:Sprite;

        private var spriteBuild:Sprite;

        public function BuildComponent()
        {
            super(null);
            userInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
            buildSp = new Sprite();
            addChild(buildSp);
        }

        public function addBuildSp(obj:DisplayObject):void
        {
            spriteLoader = Sprite((obj as DisplayObjectContainer).getChildByName("sprite"));
            spriteUp = Sprite((obj as DisplayObjectContainer).getChildByName("sprite1"));
            spriteBuild = Sprite((obj as DisplayObjectContainer).getChildByName("sprite2"));

            if (buildSp.numChildren > 0)
            {
                var oldObj:DisplayObject = buildSp.getChildAt(0);
                TweenLite.to(oldObj, 1, { alpha: 0, onComplete: function():void
                {
                    DisposeUtil.dispose(oldObj);
                }});
				
				buildSp.addChild(obj);
				obj.alpha = 0;
                TweenLite.to(obj, 1, { alpha: 1 });
            }
            else
            {
                buildSp.addChild(obj);
                buildSp.alpha = 1;
            }
			
			addChild(buildSp);
        }

        private function formatStr(str:String):String
        {
            return StringUtil.formatString(str, userInfoVO.camp);
        }

        public function get buildInfoVo():BuildInfoVo
        {
            return _buildInfoVo;
        }

        private function newBuildUp():void
        {
            buildUp = new BuildUpLoaderViewComponent(this);
            buildUp.buildInfoVo = _buildInfoVo;
            buildUp.x = -(buildUp.width * 0.5);
            spriteLoader.addChild(buildUp);
        }

        private function addBuild(obj:DisplayObjectContainer):void
        {
            for (var i:int = 1; i < 5; i++)
            {
                var mc:Sprite = Sprite(obj.getChildByName("mc_" + String(i)));
                mc.visible = false;

                if (_buildInfoVo.type == 6)
                { //科学院
                    var count:int = int((_buildInfoVo.level - 1) / 10) + 1;
                    if (i <= count)
                        mc.visible = true;
                }
                else if (_buildInfoVo.type == 1)
                { //主基地
                    var count1:int = _buildInfoVo.level;
                    if (i <= count1)
                        mc.visible = true;
                }

            }
            addBuildSp(obj);
        }

        public function set buildInfoVo(value:BuildInfoVo):void
        {
            _buildInfoVo = value;

            cwList.push(BindingUtils.bindSetter(showBuild, this, [ "buildInfoVo", "eventID" ]));
        }


        /**
         *显示建筑 *
         */
        private function showBuild(value:* = null):void
        {

            switch (_buildInfoVo.type)
            {
                case BuildTypeEnum.CENTER:
                { //主基地 需要确认建筑等级
                    if (_buildInfoVo.eventID == 0)
                    {
                        DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.centerBuildingURL, formatStr("sence{0}_centerBuilding_normal"), function(obj:DisplayObject):void
                        {
                            addBuild(obj as DisplayObjectContainer);
                        }));
                    }
                    else
                    {
                        DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.centerBuildingURL, formatStr("sence{0}_centerBuilding_up"), function(obj:DisplayObject):void
                        {
                            addBuild(obj as DisplayObjectContainer);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "center_up"));
                        }));
                    }

                    break;
                }
                case  BuildTypeEnum.CHUANQIN:
                { //氚气
                    if (_buildInfoVo.eventID == 0)
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, formatStr("sence{0}_chuanQingCang_normal"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, formatStr("sence{0}_chuanQingCang_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                        });
                    }

                    break;
                }
                case  BuildTypeEnum.DIANCHANG:
                { //暗能电厂
                    if (_buildInfoVo.eventID == 0)
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.anNengDianChangURL, formatStr("sence{0}_anNengDianChang_normal"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.anNengDianChangURL, formatStr("sence{0}_anNengDianChang_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                        });
                    }

                    break;
                }
                case  BuildTypeEnum.CANGKU:
                { //仓库
                    if (_buildInfoVo.eventID == 0)
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.cangKuURL, formatStr("sence{0}_cangKu_normal"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.cangKuURL, formatStr("sence{0}_cangKu_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "cangku_up"));
                        });
                    }

                    break;
                }
                case  BuildTypeEnum.KUANGCHANG:
                { //矿场
                    if (_buildInfoVo.eventID == 0)
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.kuangChangURL, formatStr("sence{0}_kuangChang_normal"), function(obj:DisplayObject):void
                        {45
                            addBuildSp(obj);
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.kuangChangURL, formatStr("sence{0}_kuangChang_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                            //spriteBuild.removeChildAt(0);
                        });
                    }

                    break;
                }
                case  BuildTypeEnum.KEJI:
                { //科学院  需要确认建筑等级
                    if (_buildInfoVo.eventID == 0)
                    {
                        DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.keXueYuanURL, formatStr("sence{0}_keXueYuan_normal"), function(obj:DisplayObject):void
                        {
                            addBuild(obj as DisplayObjectContainer);
                        }));
                    }
                    else
                    {
                        DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.keXueYuanURL, formatStr("sence{0}_keXueYuan_up"), function(obj:DisplayObject):void
                        {
                            addBuild(obj as DisplayObjectContainer);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                        }));
                    }

                    break;
                }
                case  BuildTypeEnum.JUNGONGCHANG:
                { //军工厂
                    if (_buildInfoVo.eventID == 0)
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.junGongCangURL, formatStr("sence{0}_junGongCang_normal"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.junGongCangURL, formatStr("sence{0}_junGongCang_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                        });
                    }

                    break;
                }
                case  BuildTypeEnum.SHIJINMAC:
                {
                    if (_buildInfoVo.eventID == 0)
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.timeMachineURL, formatStr("sence{0}_timeMachine_normal"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.timeMachineURL, formatStr("sence{0}_timeMachine_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, formatStr("sence{0}_building_up")));
                        });
                    }

                    break;
                }
            }
        }

    }
}
