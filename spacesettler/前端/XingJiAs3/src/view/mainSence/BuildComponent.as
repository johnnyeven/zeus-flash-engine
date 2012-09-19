package view.mainSence
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import enum.MainSenceEnum;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import view.mainView.BuildUpLoaderViewComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	public class BuildComponent extends Component
	{
		private var _buildInfoVo:BuildInfoVo;
		private var buildUp:BuildUpLoaderViewComponent;
		public var userInfoVO:UserInfoVO;
		public function BuildComponent()
		{
			super(null);
			userInfoVO= UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			
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
			buildUp=new BuildUpLoaderViewComponent();
			buildUp.buildInfoVo=_buildInfoVo;
			addChild(buildUp);
		}
		
		private function addBuild(obj:DisplayObjectContainer):void
		{			
			for(var i:int=1;i<5;i++)
			{
				var mc:Sprite=Sprite(obj.getChildByName("mc_"+i));
				mc.visible=false;
				
				
				if(_buildInfoVo.type==6)
				{//科学院
					var count:int=int((_buildInfoVo.level-1)/10)+1;
					if(i<=count)mc.visible=true;					
				}else if(_buildInfoVo.type==1)
				{//主基地
					var count1:int=userInfoVO.level;
					if(i<=count1)mc.visible=true;
				}
				
			}
			addChild(obj);
		}
		public function set buildInfoVo(value:BuildInfoVo):void
		{
			_buildInfoVo = value;				
			cwList.push(BindingUtils.bindSetter(showBuild,this,["buildInfoVo","eventID"]));
			cwList.push(BindingUtils.bindSetter(showBuild,this,["buildInfoVo","type"]));
			
		}
		
		
		/**
		 *显示建筑 * 
		 */		
		private function showBuild(value:*=null):void
		{
			while(this.numChildren>0)
			{
				removeChildAt(0);
			}
			switch(_buildInfoVo.type)
			{
				case 1:
				{//主基地 需要确认建筑等级
					if(_buildInfoVo.eventID==0)
					{
						var object:DisplayObjectContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.centerBuildingURL,formatStr("sence{0}_centerBuilding_normal")));
						addBuild(object);
					}
					else
					{						
						var object1:DisplayObjectContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.centerBuildingURL,formatStr("sence{0}_centerBuilding_up")));
						addBuild(object1);						
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();							
					}
					
					break;
				}
				case 2:
				{
					if(_buildInfoVo.eventID==0)
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL,formatStr("sence{0}_chuanQingCang_normal")));
					}else
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.chuanQingCangURL,formatStr("sence{0}_chuanQingCang_up")));
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();
						
					}
					
					break;
				}
				case 3:
				{
					if(_buildInfoVo.eventID==0)
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.anNengDianChangURL,formatStr("sence{0}_anNengDianChang_normal")));
					}else
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.anNengDianChangURL,formatStr("sence{0}_anNengDianChang_up")));
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();
						
					}
					
					break;
				}
				case 4:
				{
					if(_buildInfoVo.eventID==0)
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.cangKuURL,formatStr("sence{0}_cangKu_normal")));
					}else
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.cangKuURL,formatStr("sence{0}_cangKu_up")));
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();
						
					}
					
					break;
				}
				case 5:
				{
					if(_buildInfoVo.eventID==0)
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.kuangChangURL,formatStr("sence{0}_kuangChang_normal")));
					}else
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.kuangChangURL,formatStr("sence{0}_kuangChang_up")));
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();
					}
					
					break;
				}
				case 6:
				{//科学院  需要确认建筑等级
					if(_buildInfoVo.eventID==0)
					{
						var object2:DisplayObjectContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.keXueYuanURL,formatStr("sence{0}_keXueYuan_normal")));
						addBuild(object2);
					}else
					{
						var object3:DisplayObjectContainer=DisplayObjectContainer(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.keXueYuanURL,formatStr("sence{0}_keXueYuan_up")));
						addBuild(object3);
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();						
					}
					
					break;
				}
				case 7:
				{
					if(_buildInfoVo.eventID==0)
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.junGongCangURL,formatStr("sence{0}_junGongCang_normal")));
					}else
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.junGongCangURL,formatStr("sence{0}_junGongCang_up")));
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();
						
					}
					
					break;
				}
				case 8:
				{
					if(_buildInfoVo.eventID==0)
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.timeMachineURL,formatStr("sence{0}_timeMachine_normal")));
					}else
					{
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.timeMachineURL,formatStr("sence{0}_timeMachine_up")));
						addChild(ClassUtil.getDisplayObjectByLoad(MainSenceEnum.buildUpURL,formatStr("sence{0}_building_up")));	
						newBuildUp();
						
					}
					
					break;
				}				
			}
		}

	}
}