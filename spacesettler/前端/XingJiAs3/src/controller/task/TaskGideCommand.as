package controller.task
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.PointUtil;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	import enum.MainSenceEnum;
	import enum.TaskEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mediator.buildingView.CangKuCreateComponentMediator;
	import mediator.buildingView.ChuanQinCreateComponentMediator;
	import mediator.buildingView.ChuanQinUpComponentMediator;
	import mediator.buildingView.DianChangCreateComponentMediator;
	import mediator.buildingView.DianChangUpComponentMediator;
	import mediator.buildingView.JunGongCreateComponentMediator;
	import mediator.buildingView.KeJiCreateComponentMediator;
	import mediator.buildingView.SelectorViewComponentMediator;
	import mediator.buildingView.YeLianChangUpComponentMediator;
	import mediator.buildingView.YeLianCreateComponentMediator;
	import mediator.cangKu.CangkuPackageViewComponentMediator;
	import mediator.cangKu.ChaKanTuZhiViewComponentMediator;
	import mediator.crystalSmelter.CrystalSmelterFunctionComponentMediator;
	import mediator.factory.FactoryArmsComponentMediator;
	import mediator.factory.FactoryChangeComponentMediator;
	import mediator.factory.FactoryMakeAndServiceComponentMediator;
	import mediator.factory.FactoryMakeComponentMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	import mediator.scienceResearch.ScienceResearchComponentMediator;
	import mediator.shangCheng.ShangChengComponentMediator;
	import mediator.task.taskGideComponentMediator;
	import mediator.task.taskMilitaryComponentMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	
	import view.factory.FactoryItem_1Component;
	import view.factory.FactoryItem_3Component;
	import view.scienceResearch.ScienceResearchItem;
	
	import vo.task.TaskInfoVO;
	
	public class TaskGideCommand extends SimpleCommand
	{
		public static const TASKGIDE_COMMAND:String="TASKGIDE_COMMAND";
		
		public static var isAddObj:Boolean=false;
		public static var LENGTH:int;		
		public static var BUTTON_TYPE:int=1;
		public static var objContainer:DisplayObjectContainer;
		public static var _button:Button;
		public static var _comp:DisplayObjectContainer;
		
		private var _type:int;
		private var taskVo:TaskInfoVO;
		private var _index:int;
		private var mainSenceMed:MainSenceComponentMediator;
		private var mainMed:MainViewMediator
		private var sprite:Sprite;
		private var userProxy:UserInfoProxy;
		private var currtentBtn:Button;
		public function TaskGideCommand()
		{
			super();
			mainSenceMed=getMediator(MainSenceComponentMediator);
			mainMed=getMediator(MainViewMediator);
			userProxy=getProxy(UserInfoProxy);
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			index=0;			
		}
		
		private function formatStr(str:String):String
		{
			return StringUtil.formatString(str, userProxy.userInfoVO.camp);
		}
		
		private function checkTypeId(type:int):void
		{
			switch(type)
			{
				case TaskEnum.TYPE1://*********************************************************建造氚气分离厂
				{					
					allNotClick(mainSenceMed.comp.chuanQinSp);
					if(isAddObj==false)
					{
						isAddObj=true;
						objContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, 
										formatStr("sence{0}_chuanQingCang_up")));
						mainSenceMed.comp.chuanQinSp.addChild(objContainer);						
					}
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.chuanQiZhiYinSp);
					break;
				}				
				case TaskEnum.TYPE2:
				{
					getMediator(ChuanQinCreateComponentMediator,function(chuanQiMed:ChuanQinCreateComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,chuanQiMed.comp.createButton);
						chuanQiMed.comp.createButton.addEventListener(MouseEvent.CLICK,clearObjContainer);
						chuanQiMed.comp.closeButton.addEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
					});
					
					break;
				}				
				case TaskEnum.TYPE3://*******************************************************建造暗能电厂
				{
					allNotClick(mainSenceMed.comp.anNengDianChangSp);
					if(isAddObj==false)
					{
						isAddObj=true;
						objContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, 
							formatStr("sence{0}_anNengDianChang_up")));
						mainSenceMed.comp.anNengDianChangSp.addChild(objContainer);
					}
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.anNengDianChangSp);
					break;
				}				
				case TaskEnum.TYPE4:
				{
					getMediator(DianChangCreateComponentMediator,function(dianChangMed:DianChangCreateComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,dianChangMed.comp.createButton);
						dianChangMed.comp.createButton.addEventListener(MouseEvent.CLICK,clearObjContainer);
						dianChangMed.comp.closeButton .addEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
					});
						
					break;
				}				
				case TaskEnum.TYPE5://************************************************************建造矿场
				{
					allNotClick(mainSenceMed.comp.kuangChangSp);
					if(isAddObj==false)
					{
						isAddObj=true;
						objContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, 
							formatStr("sence{0}_kuangChang_up")));
						mainSenceMed.comp.kuangChangSp.addChild(objContainer);
					}
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.kuangChangZhiShiSp);
					
					break;
				}				
				case TaskEnum.TYPE6:
				{
					getMediator(YeLianCreateComponentMediator,function(yeLianMed:YeLianCreateComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,yeLianMed.comp.createButton);
						yeLianMed.comp.createButton.addEventListener(MouseEvent.CLICK,clearObjContainer);
						yeLianMed.comp.closeButton.addEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
					});
					
					break;
				}				
				case TaskEnum.TYPE7://*********************************************************************熔炼暗物质
				{
					allNotClick(mainSenceMed.comp.kuangChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.kuangChangZhiShiSp);
					break;
				}				
				case TaskEnum.TYPE8:	
				{
					BUTTON_TYPE=0;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});							
					break;
				}				
				case TaskEnum.TYPE9:	
				{
					getMediator(CrystalSmelterFunctionComponentMediator,function(cryViewMed:CrystalSmelterFunctionComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,cryViewMed.comp.smeltBtn);
					});							
					break;
				}	
				case TaskEnum.TYPE10://***************************************************************建造仓库
				{
					allNotClick(mainSenceMed.comp.cangKuSp);
					if(isAddObj==false)
					{
						isAddObj=true;
						objContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, 
							formatStr("sence{0}_cangKu_up")));
						mainSenceMed.comp.cangKuSp.addChild(objContainer);
					}
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.cangKuSp);
					
					break;
				}				
				case TaskEnum.TYPE11:
				{
					getMediator(CangKuCreateComponentMediator,function(cangKuMed:CangKuCreateComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,cangKuMed.comp.createButton);
						cangKuMed.comp.createButton.addEventListener(MouseEvent.CLICK,clearObjContainer);
						cangKuMed.comp.closeButton.addEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
					});
					
					break;
				}	
				case TaskEnum.TYPE12://*****************************************************************氚气升级
				{					
					allNotClick(mainSenceMed.comp.chuanQinSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.chuanQiZhiYinSp);
					break;
				}				
				case TaskEnum.TYPE13:
				{
					BUTTON_TYPE=1;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					
					break;
				}				
				case TaskEnum.TYPE14:
				{
					getMediator(ChuanQinUpComponentMediator,function(chuanQiMed:ChuanQinUpComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,chuanQiMed.comp.upLevelButton);
					});
					
					break;
				}				
				case TaskEnum.TYPE15://*************************************************************暗能电厂升级
				{
					allNotClick(mainSenceMed.comp.anNengDianChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.anNengDianChangSp);
					break;
				}				
				case TaskEnum.TYPE16:
				{
					BUTTON_TYPE=1;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					
					break;
				}				
				case TaskEnum.TYPE17:
				{
					getMediator(DianChangUpComponentMediator,function(dianChangMed:DianChangUpComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,dianChangMed.comp.upLevelButton);
					});
					
					break;
				}				
				case TaskEnum.TYPE18://******************************************************************矿场升级
				{
					allNotClick(mainSenceMed.comp.kuangChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.kuangChangZhiShiSp);
					break;
				}				
				case TaskEnum.TYPE19:
				{
					BUTTON_TYPE=1;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					
					break;
				}				
				case TaskEnum.TYPE20:
				{
					getMediator(YeLianChangUpComponentMediator,function(dianChangMed:YeLianChangUpComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,dianChangMed.comp.upLevelButton);
					});
					
					break;
				}						
				case TaskEnum.TYPE21://**********************************************************建造科学院
				{					
					allNotClick(mainSenceMed.comp.keJiSp);
					if(isAddObj==false)
					{
						isAddObj=true;
						objContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, 
							formatStr("sence{0}_keXueYuan_up")));
						mainSenceMed.comp.keJiSp.addChild(objContainer);
					}
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.keJiZhiYinSp);
					break;
				}				
				case TaskEnum.TYPE22:
				{
					getMediator(KeJiCreateComponentMediator,function(chuanQiMed:KeJiCreateComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,chuanQiMed.comp.createButton);
						chuanQiMed.comp.createButton.addEventListener(MouseEvent.CLICK,clearObjContainer);
						chuanQiMed.comp.closeButton.addEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
					});
					
					break;
				}		
				case TaskEnum.TYPE23://********************************************************建造军工厂
				{					
					allNotClick(mainSenceMed.comp.junGongChangSp);
					if(isAddObj==false)
					{
						isAddObj=true;
						objContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL, 
							formatStr("sence{0}_junGongCang_up")));
						mainSenceMed.comp.junGongChangSp.addChild(objContainer);
					}
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.junGongChangSp);
					break;
				}				
				case TaskEnum.TYPE24:
				{					
					getMediator(JunGongCreateComponentMediator,function(chuanQiMed:JunGongCreateComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,chuanQiMed.comp.createButton);
						chuanQiMed.comp.createButton.addEventListener(MouseEvent.CLICK,clearObjContainer);
						chuanQiMed.comp.closeButton.addEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
					});
					
					break;
				}	
				case TaskEnum.TYPE25://********************************************************建造时间机器
				{
					var buildProxy:BuildProxy=getProxy(BuildProxy);
					buildProxy.create_time_machine(function():void
					{
						sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
					});
					break;
				}		
				case TaskEnum.TYPE26://********************************************************军工厂加速
				{
					allNotClick(mainSenceMed.comp.junGongChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.junGongChangZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE27:
				{
					getMediator(JunGongCreateComponentMediator,function(chuanQiMed:JunGongCreateComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,chuanQiMed.comp.speedButton);
						button=chuanQiMed.comp.speedButton;
					});
					break;
				}		
				case TaskEnum.TYPE28:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(MoneyAlertComponentMediator,function(chuanQiMed:MoneyAlertComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,chuanQiMed.comp.okButton);
					});
					break;
				}		
				case TaskEnum.TYPE29://******************************************************用户注册 如果已经注册自动完成任务
				{
					if(TaskEnum.IS_SPEED_LOGIN==true)						
						sendNotification(taskMilitaryComponentMediator.SHOW_NOTE,taskVo);
					else
						sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
					break;
				}								
				case TaskEnum.TYPE30://******************************************************学习能源科技
				{
					allNotClick(mainSenceMed.comp.keJiSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.keJiZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE31:
				{
					BUTTON_TYPE=0;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					break;
				}		
				case TaskEnum.TYPE32:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(ScienceResearchComponentMediator,function(SelViewMed:ScienceResearchComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.KEJI_NENGYUAN,function(obj:DisplayObject):void
						{
							currtentBtn=(obj as ScienceResearchItem).researchBtn;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,currtentBtn);
						});
					});	
					break;
				}		
				case TaskEnum.TYPE33://*************************************************************学习机械科技
				{
					allNotClick(mainSenceMed.comp.keJiSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.keJiZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE34:
				{
					BUTTON_TYPE=0;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					break;
				}		
				case TaskEnum.TYPE35:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(ScienceResearchComponentMediator,function(SelViewMed:ScienceResearchComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.KEJI_JIXIE,function(obj:DisplayObject):void
						{
							currtentBtn=(obj as ScienceResearchItem).researchBtn;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,currtentBtn);
						});
					});	
					break;
				}		
				case TaskEnum.TYPE36://**************************************************************学习采集科技
				{
					allNotClick(mainSenceMed.comp.keJiSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.keJiZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE37:
				{
					BUTTON_TYPE=0;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					break;
				}		
				case TaskEnum.TYPE38:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(ScienceResearchComponentMediator,function(SelViewMed:ScienceResearchComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.KEJI_CAIJI,function(obj:DisplayObject):void
						{
							currtentBtn=(obj as ScienceResearchItem).researchBtn;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,currtentBtn);
						});
					});	
					break;
				}		
				case TaskEnum.TYPE39://**********************************************************学习图纸
				{
					var mainMed:MainViewMediator=getMediator(MainViewMediator);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainMed.comp.controlComp.arsenalBtn);
					button=mainMed.comp.controlComp.arsenalBtn;
					break;
				}		
				case TaskEnum.TYPE40:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(CangkuPackageViewComponentMediator,function(SelViewMed:CangkuPackageViewComponentMediator):void
					{
						comp=SelViewMed.comp.searchContainer(TaskEnum.TUZHI_STR);
						sendNotification(taskGideComponentMediator.SHOW_NOTE,comp);
					});	
					break;
				}		
				case TaskEnum.TYPE41:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(CangkuPackageViewComponentMediator,function(SelViewMed:CangkuPackageViewComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.currtentTuZhiBtn);
						button=SelViewMed.comp.currtentTuZhiBtn;
					});	
					break;
				}		
				case TaskEnum.TYPE42:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(ChaKanTuZhiViewComponentMediator,function(SelViewMed:ChaKanTuZhiViewComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.useBtn);
					});	
					break;
				}		
				case TaskEnum.TYPE43://****************************************制造企业号战车
				{
					allNotClick(mainSenceMed.comp.junGongChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.junGongChangZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE44:
				{
					BUTTON_TYPE=3;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					break;
				}		
				case TaskEnum.TYPE45:
				{
					getMediator(FactoryMakeAndServiceComponentMediator,function(SelViewMed:FactoryMakeAndServiceComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.zhanCheMakeBtn);
						button=SelViewMed.comp.zhanCheMakeBtn;
					});	
					break;
				}		
				case TaskEnum.TYPE46:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(FactoryMakeComponentMediator,function(SelViewMed:FactoryMakeComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.ZHANCHE_STR,function(obj:DisplayObject):void
						{
							currtentBtn=(obj as FactoryItem_1Component).zhizao_btn;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,currtentBtn);
						});
					});	
					break;
				}		
				case TaskEnum.TYPE47://******************************************制造武器挂件
				{
					allNotClick(mainSenceMed.comp.junGongChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.junGongChangZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE48:
				{
					BUTTON_TYPE=3;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					break;
				}		
				case TaskEnum.TYPE49:
				{
					getMediator(FactoryMakeAndServiceComponentMediator,function(SelViewMed:FactoryMakeAndServiceComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.wuQiMakeBtn);
						button=SelViewMed.comp.wuQiMakeBtn;
					});	
					break;
				}		
				case TaskEnum.TYPE50:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(FactoryMakeComponentMediator,function(SelViewMed:FactoryMakeComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.GUAJIAN_STR,function(obj:DisplayObject):void
						{
							currtentBtn=(obj as FactoryItem_1Component).zhizao_btn;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,currtentBtn);
						});
					});	
					break;
				}		
				case TaskEnum.TYPE51://**********************************************装配挂件
				{
					allNotClick(mainSenceMed.comp.junGongChangSp);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.junGongChangZhiYinSp);
					break;
				}		
				case TaskEnum.TYPE52:
				{
					BUTTON_TYPE=1;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					break;
				}		
				case TaskEnum.TYPE53:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(FactoryMakeAndServiceComponentMediator,function(SelViewMed:FactoryMakeAndServiceComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.jiaZaiBtn);
						button=SelViewMed.comp.jiaZaiBtn;
					});	
					break;
				}	
				case TaskEnum.TYPE54:
				{
					getMediator(FactoryArmsComponentMediator,function(SelViewMed:FactoryArmsComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.ZHANCHE_STR,function(obj:DisplayObject):void
						{
							comp=obj as DisplayObjectContainer;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,obj);
						});
					});		
					break;
				}						
				case TaskEnum.TYPE55:
				{
					getMediator(FactoryChangeComponentMediator,function(SelViewMed:FactoryChangeComponentMediator):void
					{
						comp=SelViewMed.comp.item_3_1 as DisplayObjectContainer;
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.zhiYinSp);
					});	
					break;
				}		
				case TaskEnum.TYPE56:
				{
					getMediator(FactoryChangeComponentMediator,function(SelViewMed:FactoryChangeComponentMediator):void
					{						
						sendNotification(taskGideComponentMediator.SHOW_NOTE,SelViewMed.comp.jiaZaiBtn);	
						button=SelViewMed.comp.jiaZaiBtn;
					});	
					break;
				}		
				case TaskEnum.TYPE57:
				{
					getMediator(FactoryArmsComponentMediator,function(SelViewMed:FactoryArmsComponentMediator):void
					{
						SelViewMed.comp.searchContainer(TaskEnum.GUAJIAN_STR,function(obj:DisplayObject):void
						{
							comp=obj as DisplayObjectContainer;
							sendNotification(taskGideComponentMediator.SHOW_NOTE,obj);
						});
					});	
					break;
				}		
				
				case TaskEnum.TYPE58://*********************************************暗能电厂再次升级
				{
					allNotClick(mainSenceMed.comp.anNengDianChangSp);
					mainMed=getMediator(MainViewMediator);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainSenceMed.comp.anNengDianChangSp);
					break;
				}				
				case TaskEnum.TYPE59:
				{
					BUTTON_TYPE=1;
					getMediator(SelectorViewComponentMediator,function(SelViewMed:SelectorViewComponentMediator):void
					{
						SelViewMed.addEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
					});	
					
					break;
				}				
				case TaskEnum.TYPE60:
				{
					getMediator(DianChangUpComponentMediator,function(dianChangMed:DianChangUpComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,dianChangMed.comp.upLevelButton);
					});
					
					break;
				}				
				case TaskEnum.TYPE61://*********************************************商城兑换资源
				{ 
					allClick();
					mainMed=getMediator(MainViewMediator);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainMed.comp.controlComp.shopBtn);
					button=mainMed.comp.controlComp.shopBtn;
					break;
				}				
				case TaskEnum.TYPE62:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					
					getMediator(ShangChengComponentMediator,function(dianChangMed:ShangChengComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,dianChangMed.comp.ziYuanDuiHuanBtn);
						button=dianChangMed.comp.ziYuanDuiHuanBtn;
					});				
					break;
				}				
				case TaskEnum.TYPE63:
				{
					sendNotification(taskGideComponentMediator.DESTROY_NOTE);
					getMediator(ShangChengComponentMediator,function(dianChangMed:ShangChengComponentMediator):void
					{
						sendNotification(taskGideComponentMediator.SHOW_NOTE,dianChangMed.comp.ziYuanComp.shuiJingBtn);
					});
					break;
				}				
				case TaskEnum.TYPE64://*********************************************攻占小行星
				{
					mainMed=getMediator(MainViewMediator);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainMed.comp.controlComp.planetBtn);
					button=mainMed.comp.controlComp.planetBtn;
										
					break;
				}				
						
				case TaskEnum.TYPE65://*********************************************加入军团或者创建军团
				{
					mainMed=getMediator(MainViewMediator);
					sendNotification(taskGideComponentMediator.SHOW_NOTE,mainMed.comp.controlComp.armyGroupBtn);
					button=mainMed.comp.controlComp.armyGroupBtn;
					break;
				}				
			}
		}
		
		
		
		protected function sendStarHandler(event:AddViewEvent):void
		{
			event.currentTarget.removeEventListener(AddViewEvent.SEND_STAR_EVENT,sendStarHandler);
			if(BUTTON_TYPE==0)
			{
				button=event.comp.rightButton;
				sendNotification(taskGideComponentMediator.SHOW_NOTE,event.comp.rightButton);	
			}else if(BUTTON_TYPE==1)
			{
				button=event.comp.upButton;
				sendNotification(taskGideComponentMediator.SHOW_NOTE,event.comp.upButton);
			}else if(BUTTON_TYPE==3)
			{
				button=event.comp.leftButton;
				sendNotification(taskGideComponentMediator.SHOW_NOTE,event.comp.leftButton);
			}
		}
		
		protected function compClickHandler(event:MouseEvent):void
		{
			_comp.removeEventListener(MouseEvent.CLICK,compClickHandler);
			index+=1
		}
		
		
		protected function btnClickHandler(event:MouseEvent):void
		{
			_button.removeEventListener(MouseEvent.CLICK,btnClickHandler);
			index+=1
			if(_button==mainMed.comp.controlComp.armyGroupBtn||_button==mainMed.comp.controlComp.planetBtn)
			{
				sendNotification(taskGideComponentMediator.DESTROY_NOTE);
			}
		}
		
		
		public function allNotClick(sp:Sprite):void
		{	
			sprite=sp;
			mainSenceMed.comp.jiDiSp.mouseChildren=mainSenceMed.comp.jiDiSp.mouseEnabled=false;
			mainSenceMed.comp.chuanQinSp.mouseChildren=mainSenceMed.comp.chuanQinSp.mouseEnabled=false;
			mainSenceMed.comp.anNengDianChangSp.mouseChildren=mainSenceMed.comp.anNengDianChangSp.mouseEnabled=false;
			mainSenceMed.comp.cangKuSp.mouseChildren=mainSenceMed.comp.cangKuSp.mouseEnabled=false;
			mainSenceMed.comp.kuangChangSp.mouseChildren=mainSenceMed.comp.kuangChangSp.mouseEnabled=false;
			mainSenceMed.comp.keJiSp.mouseChildren=mainSenceMed.comp.keJiSp.mouseEnabled=false;
			mainSenceMed.comp.junGongChangSp.mouseChildren=mainSenceMed.comp.junGongChangSp.mouseEnabled=false;
			
			sprite.mouseChildren=sp.mouseEnabled=true;
			sprite.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			sprite.removeEventListener(MouseEvent.CLICK,clickHandler);
			sendNotification(taskGideComponentMediator.DESTROY_NOTE);
			index+=1
		}
		
		protected function closeButtonHandler(event:Event):void
		{
			event.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE,closeButtonHandler);
			clearContainer();
		}
		
		private function clearContainer():void
		{
			if(objContainer)
				objContainer.parent.removeChild(objContainer);
			objContainer=null;
			isAddObj=false;
		}
		
		private function clearObjContainer(event:MouseEvent):void
		{
			TweenLite.to(objContainer,1,{alpha:0.1});
			setTimeout(clearContainer,1000);
		}
		
		public function allClick():void
		{
			mainSenceMed.comp.jiDiSp.mouseChildren=mainSenceMed.comp.jiDiSp.mouseEnabled=true;
			mainSenceMed.comp.chuanQinSp.mouseChildren=mainSenceMed.comp.chuanQinSp.mouseEnabled=true;
			mainSenceMed.comp.anNengDianChangSp.mouseChildren=mainSenceMed.comp.anNengDianChangSp.mouseEnabled=true;
			mainSenceMed.comp.cangKuSp.mouseChildren=mainSenceMed.comp.cangKuSp.mouseEnabled=true;
			mainSenceMed.comp.kuangChangSp.mouseChildren=mainSenceMed.comp.kuangChangSp.mouseEnabled=true;
			mainSenceMed.comp.keJiSp.mouseChildren=mainSenceMed.comp.keJiSp.mouseEnabled=true;
			mainSenceMed.comp.junGongChangSp.mouseChildren=mainSenceMed.comp.junGongChangSp.mouseEnabled=true;
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
			if(_index>=LENGTH)
			{
				_index=LENGTH;
			}else if(_index<=0)
			{
				_index=0;
			}
			taskVo=TaskEnum.CURRTENT_TASKVO;
			LENGTH=taskVo.idArr.length;
			_type=taskVo.idArr[_index];	
			checkTypeId(_type);	
		}

		public function get button():Button
		{
			return _button;
		}

		public function set button(value:Button):void
		{
			if(value)
			{
				_button = value;
				_button.addEventListener(MouseEvent.CLICK,btnClickHandler);				
			}
		}

		public function get comp():DisplayObjectContainer
		{
			return _comp;
		}

		public function set comp(value:DisplayObjectContainer):void
		{
			if(value)
			{
				_comp = value;
				_comp.addEventListener(MouseEvent.CLICK,compClickHandler);				
			}
		}


	}
}