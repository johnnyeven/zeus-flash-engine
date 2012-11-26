package controller.battle.fight
{
	import com.zn.utils.RotationUtil;
	
	import enum.battle.FightVOTypeEnum;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.battle.BattleProxy;
	
	import utils.battle.FightDataUtil;
	
	import view.battle.fight.BattleFightComponent;
	import view.battle.fight.FightFeiJiComponent;

	/**
	 *生成小飞机
	 * @author zn
	 *
	 */
	public class FightCreateFeiJiCommand extends SimpleCommand
	{
		public static const CREATE_FEI_JI_COMMAND:String="CREATE_FEI_JI_COMMAND";

		private var fightMed:BattleFightMediator;

		public function FightCreateFeiJiCommand()
		{
			super();

			fightMed=getMediator(BattleFightMediator);

			var r:Number=500; //半径
			var moveCount:int=60; //移动多少个点
			var p:Point;
			var list:Array=[];
			if (!FightFeiJiComponent.movePathList)
			{
				//生成大飞机移动路径
				var centerPoint:Point=new Point(fightMed.comp.feiJiCenterSp.x, fightMed.comp.feiJiCenterSp.y);
				var radian:Number;
				for (var i:int=0; i < moveCount; i++)
				{
					radian=RotationUtil.toRadian(360 / moveCount * i);
					p=new Point();
					p.x=Math.sin(radian) * r + centerPoint.x;
					p.y=Math.cos(radian) * r + centerPoint.y;
					list.push(p);
				}

				list.push(list[0]);
				FightFeiJiComponent.movePathList=list;
			}
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			var player1:PLAYER1=notification.getBody() as PLAYER1;

			var myID:String=FightDataUtil.getMyChariot().id.toString();

			var feiJiComp:FightFeiJiComponent;

			var fightComp:BattleFightComponent=fightMed.comp;

			var allChariotIDList:Array=FightDataUtil.getAllPlayerChariotID();
			var battleProxy:BattleProxy=getProxy(BattleProxy);
			var controlID:String;

			var chariots:Array=player1.chariots;
			var feiJiVO:CHARIOT;

			for (var i:int=0; i < chariots.length; i++)
			{
				feiJiVO=chariots[i];

				feiJiComp=new FightFeiJiComponent(feiJiVO);
				//TODO LW:多人战斗中 大小飞机同步
				feiJiComp.x=0.05*i * (Main.WIDTH + 200) - 100;
				feiJiComp.y=-0.05*i * 100;
//				feiJiComp.x=Math.random() * (Main.WIDTH + 200) - 100;
//				feiJiComp.y=-Math.random() * 100;

				fightComp.feiJiCompList.push(feiJiComp);
				fightComp.allCompList.push(feiJiComp);
				fightComp.compIDDic[feiJiVO.id]=feiJiComp;

				fightComp.airSp.addChild(feiJiComp);
				feiJiVO.gid=player1.gid;

				//如果是大飞机，设置大飞机移动
				if (feiJiVO.voType == FightVOTypeEnum.daFeiJi)
				{
					BattleFightComponent.daFeiJiCompList.push(feiJiComp);
					feiJiComp.movePath(true);
				}
				else if (feiJiVO.voType == FightVOTypeEnum.xiaoFeiJi)
				{
					//获取飞机控制权

					//计算离小飞机最近的战车
					var zhanCheObj:DisplayObject;
					var feiJiP:Point=new Point(feiJiComp.x, feiJiComp.y);
					var minDis:Number;
					var minID:String;
					var dis:Number;
					for (var j:int=0; j < allChariotIDList.length; j++)
					{
						zhanCheObj=fightMed.comp.getCompByID(allChariotIDList[j]);
						dis=Point.distance(feiJiP, new Point(zhanCheObj.x, zhanCheObj.y));
						if (isNaN(minDis) || dis < minDis)
						{
							minDis=dis;
							minID=allChariotIDList[j];
						}
					}

					if (minID == myID)
						battleProxy.getContorl(feiJiVO.id.toString());
				}
			}
		}
	}
}
