package controller.battle.fight
{
	import com.zn.utils.RandomUtil;
	import com.zn.utils.RotationUtil;
	
	import enum.battle.FightVOTypeEnum;
	
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.battle.BattleProxy;
	
	import utils.battle.CalculateUtil;
	import utils.battle.FightDataUtil;
	
	import view.battle.fight.BattleFightComponent;
	import view.battle.fight.FightFeiJiComponent;
	import view.battle.fight.FightZhanCheComponent;

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

			var feiJiComp:FightFeiJiComponent;

			var fightComp:BattleFightComponent=fightMed.comp;

			var allChariotIDList:Array=FightDataUtil.getAllPlayerChariotID();
			var battleProxy:BattleProxy=getProxy(BattleProxy);
			var controlID:String;
			
			var chariots:Array=player1.chariots;
			var zhanCheVO:CHARIOT;
			for (var i:int=0; i < chariots.length; i++)
			{
				zhanCheVO=chariots[i];
				
				feiJiComp=new FightFeiJiComponent(zhanCheVO);
				feiJiComp.x=Math.random() * (Main.WIDTH + 200) - 100;
				feiJiComp.y=-Math.random() * 100;

				fightComp.feiJiCompList.push(feiJiComp);
				fightComp.allCompList.push(feiJiComp);
				fightComp.compIDDic[zhanCheVO.id]=feiJiComp;

				fightComp.airSp.addChild(feiJiComp);
				feiJiComp.gid=player1.gid;

				//如果是大飞机，设置大飞机移动
				if (zhanCheVO.voType==FightVOTypeEnum.daFeiJi)
					feiJiComp.movePath();
				else if (zhanCheVO.voType==FightVOTypeEnum.xiaoFeiJi)
				{
					//获取飞机控制权
					controlID=allChariotIDList[RandomUtil.getRangeInt(0,allChariotIDList.length-1)];
					battleProxy.getContorl(controlID);
				}
			}
		}
	}
}