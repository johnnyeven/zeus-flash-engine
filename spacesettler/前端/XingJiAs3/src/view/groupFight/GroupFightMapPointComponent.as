package view.groupFight
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import proxy.groupFight.GroupFightProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.core.Component;
	
	import vo.groupFight.GroupFightVo;
	import vo.groupFight.MyArmiesVo;
	import vo.userInfo.UserInfoVO;
	
	public class GroupFightMapPointComponent extends Component
	{
		public var sPoint:MovieClip;//小圆点
		public var mPoint:MovieClip;//中圆点
		public var lPoint:MovieClip;//大圆点
		
		private var _info:GroupFightVo;
		
		public function GroupFightMapPointComponent()
		{
			super(ClassUtil.getObject("view.GroupFightMapPointSkin"))
			
			sPoint=getSkin("SPoint");
			mPoint=getSkin("MPoint");
			lPoint=getSkin("LPoint");
			sortChildIndex();
			
			sPoint.visible=false;
			mPoint.visible=false;
			lPoint.visible=false;
			
			this.mouseEnabled=true;
			this.buttonMode=true;
		}

		public function setPointColor(starVO:GroupFightVo):void
		{
			var tempProxy:GroupFightProxy=GroupFightProxy(ApplicationFacade.getProxy(GroupFightProxy));
			if(!starVO.legion_name)
			{
				sPoint.visible=true;
				sPoint.gotoAndStop(1);
				
				if(starVO.type==4)
				{
					sPoint.visible=false;
					mPoint.visible=true;
					mPoint.gotoAndStop(1);
					lPoint.visible=false;
				}
				if(starVO.type==5)
				{
					sPoint.visible=false;
					mPoint.visible=false;
					lPoint.visible=true;
					lPoint.gotoAndStop(1);
				}
			}
			
			if(starVO.legion_name && starVO.legion_name==tempProxy.myStarVo.legion_name)//军团占领的行星
			{
				//暗绿色
				if(starVO.type==4)//中圆点
				{
					mPoint.visible=true;
					mPoint.gotoAndStop(2);
				}
				else if(starVO.type==5)//大圆点
				{
					lPoint.visible=true;
					lPoint.gotoAndStop(2);
				}
				else//小圆点
				{
					sPoint.visible=true;
					sPoint.gotoAndStop(2);
				}
				
				if(tempProxy.myArmiesArr!=null)//有我派遣的战舰  亮绿色
				{
					var len:int=tempProxy.myArmiesArr.length;
					for(var i:int=0;i<len;i++)
					{
						var myArmiesVO:MyArmiesVo=tempProxy.myArmiesArr[i];
						if(myArmiesVO.warship!=0)
						{
							if(myArmiesVO.name==starVO.name)
							{
								if(starVO.type==4)//中圆点
								{
									mPoint.visible=true;
									mPoint.gotoAndStop(3);
								}
								else if(starVO.type==5)//大圆点
								{
									lPoint.visible=true;
									lPoint.gotoAndStop(3);
								}
								else//小圆点
								{
									sPoint.visible=true;
									sPoint.gotoAndStop(3);
								}
							}
						}
					}
				}
			}
			
			if(starVO.legion_name && starVO.legion_name!=tempProxy.myStarVo.legion_name)//敌人占领了的行星
			{
				//小圆点
				if(starVO.total_warships>=0 && starVO.total_warships<10001)//小圆点黄色
				{
					sPoint.visible=true;
					sPoint.gotoAndStop(4);
				}
				if(starVO.total_warships>=10001 && starVO.total_warships<100001)//小圆点橙色
				{
					sPoint.visible=true;
					sPoint.gotoAndStop(6);
				}
				if(starVO.total_warships>=100001)//小圆点红色
				{
					sPoint.visible=true;
					sPoint.gotoAndStop(5);
				}
				
				if(starVO.type==4)//中圆点
				{
					mPoint.visible=true;
					if(starVO.total_warships>=0 && starVO.total_warships<10001)//中圆点黄色
					{
						mPoint.gotoAndStop(4);
					}
					if(starVO.total_warships>=10001 && starVO.total_warships<100001)//中圆点橙色
					{
						mPoint.gotoAndStop(6);
					}
					if(starVO.total_warships>=100001)//中圆点红色
					{
						mPoint.gotoAndStop(5);
					}	
				}
				if(starVO.type==5)//大圆点
				{
					lPoint.visible=true;
					if(starVO.total_warships>=0 && starVO.total_warships<10001)//大圆点黄色
					{
						lPoint.gotoAndStop(4);
					}
					if(starVO.total_warships>=10001 && starVO.total_warships<100001)//大圆点橙色
					{
						lPoint.gotoAndStop(6);
					}
					if(starVO.total_warships>=100001)//大圆点红色
					{
						lPoint.gotoAndStop(5);
					}
				}
			}
			
			if(tempProxy.myStarVo.name == starVO.name)
			{
				if(starVO.type==4)//中圆点
				{
					mPoint.visible=true;
					mPoint.gotoAndStop(3);
				}
				else if(starVO.type==5)//大圆点
				{
					lPoint.visible=true;
					lPoint.gotoAndStop(3);
				}
				else//小圆点
				{
					sPoint.visible=true;
					sPoint.gotoAndStop(3);
				}
			}
		}
		
		public function get key():GroupFightVo
		{
			return _info;
		}

		public function set key(value:GroupFightVo):void
		{
			_info = value;
		}
	}
}