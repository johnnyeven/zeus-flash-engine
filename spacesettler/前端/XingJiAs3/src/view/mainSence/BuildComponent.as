package view.mainSence
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.greensock.loading.BinaryDataLoader;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;
    
    import enum.BuildTypeEnum;
    import enum.MainSenceEnum;
    
    import events.buildEvent.CaiKuangCheEffectEvent;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.BuildProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.components.Alert;
    import ui.core.Component;
    import ui.utils.DisposeUtil;
    
    import view.mainView.BuildUpLoaderViewComponent;
    
    import vo.BuildInfoVo;
    import vo.userInfo.UserInfoVO;

    public class BuildComponent extends Component
    {
        private var _buildInfoVo:BuildInfoVo;

        public var userInfoVO:UserInfoVO;

        private var buildSp:Sprite;

        private var spriteLoader:Sprite;

        private var spriteUp:Sprite;

        private var spriteBuild:Sprite;

        private var oldObj:DisplayObject;

        private var caiKuangCheEffectComp:CaiKuangCheEffectComponent;
		
		private var _buildProxy:BuildProxy;
		
		public var isShiJian:Boolean;
		
        public function BuildComponent()
        {
            super(null);
            userInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
            buildSp = new Sprite();
            addChild(buildSp);
			
			buttonMode=mouseEnabled=true;
        }

        public function addBuildSp(obj:DisplayObject):void
        {
            spriteLoader = Sprite((obj as DisplayObjectContainer).getChildByName("sprite"));
            spriteUp = Sprite((obj as DisplayObjectContainer).getChildByName("sprite1"));
            spriteBuild = Sprite((obj as DisplayObjectContainer).getChildByName("sprite2"));

            if (oldObj)
            {
                TweenLite.to(oldObj, 1, { alpha: 0, onComplete: function():void
                {
                    DisposeUtil.dispose(oldObj);
                    oldObj = obj;

                    if (_buildInfoVo.type == BuildTypeEnum.KUANGCHANG)
                    {
                        var mc:MovieClip = (oldObj as DisplayObjectContainer).getChildByName("dengMC") as MovieClip;
                        if (mc)
                            mc.gotoAndStop("close");
                    }
                }});

                buildSp.addChild(obj);
                obj.alpha = 0;
                TweenLite.to(obj, 1, { alpha: 1 });
            }
            else
            {
                oldObj = obj;
                buildSp.addChild(obj);
                buildSp.alpha = 1;
            }
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
            var buildUp:BuildUpLoaderViewComponent = new BuildUpLoaderViewComponent(this);
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

                if (_buildInfoVo.type == BuildTypeEnum.KEJI)
                { //科学院
                    var count:int = int((_buildInfoVo.level - 1) / 10) + 1;
                    if (i <= count)
                        mc.visible = true;
                }
                else if (_buildInfoVo.type == BuildTypeEnum.CENTER)
                { //主基地
                    var count1:int = userInfoVO.level;
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
                { //1主基地 需要确认建筑等级
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
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
                case BuildTypeEnum.CHUANQIN:
                { //2氚气
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
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

                            if (_buildInfoVo.level != 0)
                            {
                                spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                            } else
                            {
                                spriteBuild.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildBuildURL, "tongyong_build"));
                            }

                        });
                    }

                    break;
                }
                case BuildTypeEnum.DIANCHANG:
                { //3暗能电厂
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
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
                            if (_buildInfoVo.level != 0)
                            {
                                spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                            } else
                            {
                                spriteBuild.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildBuildURL, "tongyong_build"));
                            }

                        });
                    }

                    break;
                }
                case BuildTypeEnum.CANGKU:
                { //4仓库
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
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
                            if (_buildInfoVo.level != 0)
                            {
                                spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "cangku_up"));
                            } else
                            {
                                spriteBuild.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildBuildURL, "tongyong_build"));
                            }

                        });
                    }

                    break;
                }
                case BuildTypeEnum.KUANGCHANG:
                { //5矿场
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.kuangChangURL, formatStr("sence{0}_kuangChang_normal"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            addCaiKuangEffect();
                        });
                    }
                    else
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.kuangChangURL, formatStr("sence{0}_kuangChang_up"), function(obj:DisplayObject):void
                        {
                            addBuildSp(obj);
                            newBuildUp();
                            if (_buildInfoVo.level != 0)
                            {
                                spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                            } else
                            {
                                spriteBuild.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildBuildURL, "tongyong_build"));
                            }

                        });
                    }

                    break;
                }
                case BuildTypeEnum.KEJI:
                { //6科学院  需要确认建筑等级
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
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
                            if (_buildInfoVo.level != 0)
                            {
                                spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                            } else
                            {
                                spriteBuild.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildBuildURL, "keji_build"));
                            }

                        }));
                    }

                    break;
                }
                case BuildTypeEnum.JUNGONGCHANG:
                { //7军工厂
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
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
                            if (_buildInfoVo.level != 0)
                            {
                                spriteUp.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL, "tongyong_up"));
                            } else
                            {
                                spriteBuild.addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildBuildURL, "tongyong_build"));
                            }

                        });
                    }

                    break;
                }
                case BuildTypeEnum.SHIJINMAC:
                { //8时间机器
					_buildProxy=ApplicationFacade.getProxy(BuildProxy);
					isShiJian=_buildProxy.isBuild;
                    if (StringUtil.isEmpty(_buildInfoVo.eventID))
                    {
                        ClassUtil.getDisplayObjectByLoad(MainSenceEnum.timeMachineURL, formatStr("sence{0}_timeMachine_normal"), function(obj:DisplayObject):void
                        {
							spriteLoader = Sprite((obj as DisplayObjectContainer).getChildByName("sprite"));
							spriteUp = Sprite((obj as DisplayObjectContainer).getChildByName("sprite1"));
							spriteBuild = Sprite((obj as DisplayObjectContainer).getChildByName("sprite2"));
							
							oldObj = obj;
							buildSp.addChild(obj);
							buildSp.alpha = 1;
							if(isShiJian)
							{
								obj.y = -200;
								TweenLite.to(obj, 2, { y: 0, ease: Linear.easeNone });
							}
								
								
                        });
                    }
                    break;
                }
            }
        }

        private function addCaiKuangEffect():void
        {
            if (caiKuangCheEffectComp == null)
            {
                caiKuangCheEffectComp = new CaiKuangCheEffectComponent();
                addChild(caiKuangCheEffectComp);
                caiKuangCheEffectComp.init();
                caiKuangCheEffectComp.addEventListener(CaiKuangCheEffectEvent.OUT_EVENT, caiKuangEffectEvent);
                caiKuangCheEffectComp.addEventListener(CaiKuangCheEffectEvent.BACK_EVENT, caiKuangEffectEvent);
            }
        }

        private function caiKuangEffectEvent(event:Event):void
        {
            var mc:MovieClip;
            if (oldObj)
            {
                mc = (oldObj as DisplayObjectContainer).getChildByName("dengMC") as MovieClip;
                if (mc == null)
                    return;

                if (caiKuangCheEffectComp.backCount > 0)
                    mc.gotoAndStop("open");
                else
                    mc.gotoAndStop("close");
            }
        }
    }
}
