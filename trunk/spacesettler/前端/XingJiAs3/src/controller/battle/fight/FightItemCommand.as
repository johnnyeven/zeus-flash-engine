package controller.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.netease.protobuf.FieldDescriptor;
	
	import enum.battle.FightBuffItemTypeEnum;
	import enum.battle.FightVOTypeEnum;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	import mediator.battle.BattleFightViewComponentMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.battle.CalculateUtil;
	import utils.battle.FightDataUtil;
	
	import view.battle.fight.BattleFightComponent;
	import view.battle.fight.FightDropNumComponent;
	import view.battle.fight.FightFeiJiComponent;
	import view.battle.fight.FightItemComponent;
	import view.battle.fight.FightZhanCheComponent;
	
	import vo.battle.fight.FightHitVO;
	import vo.battle.fight.FightHonorVO;
	import vo.battle.fight.FightItemVO;
	import vo.cangKu.ZhanCheInfoVO;

	/**
	 *拾取物品控制器
	 * @author zn
	 *
	 */
	public class FightItemCommand extends SimpleCommand
	{
		public static const FIGHT_ITEM_COMMAND:String="FIGHT_ITEM_COMMAND";

		private var itemVO:FightItemVO;
		private var fightMed:BattleFightMediator;

		public function FightItemCommand()
		{
			super();
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			itemVO=notification.getBody() as FightItemVO;

			fightMed=getMediator(BattleFightMediator);

			//拾取地面物品
			var voObj:BUFFER_DEF=FightDataUtil.getVO(itemVO.uid) as BUFFER_DEF;

			if (!voObj)
				return;

			var fightItemComp:FightItemComponent=fightMed.comp.compIDDic[itemVO.uid];
			var itemType:int=fightItemComp.itemVO.itemType;

			var zhanCheVO:CHARIOT=FightDataUtil.getVO(itemVO.pickID) as CHARIOT;
			var zhanCheComp:DisplayObject = fightMed.comp.compIDDic[zhanCheVO.id];//测试数据(lw)
			voObj.isPick=true;

			//增加效果
			switch (itemType)
			{
				case FightBuffItemTypeEnum.naiJiu:
				{
					break;
				}
				case FightBuffItemTypeEnum.huDun:
				{					
					zhanCheVO.totalShield+=voObj.delta;
					zhanCheVO.currentShield+=voObj.delta;		
					
					break;
				}
				case FightBuffItemTypeEnum.jinJing:
				{
					showDropNumComp(voObj.delta,zhanCheComp.x,zhanCheComp.y);
					break;
				}
				case FightBuffItemTypeEnum.chuanQing:
				{
					showDropNumComp(voObj.delta,zhanCheComp.x,zhanCheComp.y);
					break;
				}
				case FightBuffItemTypeEnum.anWuZhi:
				{
					showDropNumComp(voObj.delta,zhanCheComp.x,zhanCheComp.y);
					break;
				}
				case FightBuffItemTypeEnum.anNengShuiJing:
				{
					showDropNumComp(voObj.delta,zhanCheComp.x,zhanCheComp.y);
					break;
				}
				case FightBuffItemTypeEnum.liaoJi:
				{
					// 增加僚机
					var fightComp:BattleFightComponent=fightMed.comp;
					var feiJiVO:CHARIOT=(voObj as BUFFER_DEF).wingman[0];
					
					FightDataUtil.dataDic[feiJiVO.id]=feiJiVO;
					FightDataUtil.dataDic[feiJiVO.tankparts[0].id]=feiJiVO.tankparts[0];
					
					feiJiVO.voType=FightVOTypeEnum.liaoJi;
					feiJiVO.myMoveSpeed=CalculateUtil.fightZhanCheSpeed(feiJiVO);
					feiJiVO.lockArea=feiJiVO.totalAttackArea;
					
					feiJiVO.tankparts[0].myAttackArea=CalculateUtil.fightZhanCheAttackArea(feiJiVO, feiJiVO.tankparts[0]);
					feiJiVO.tankparts[0].voType=FightVOTypeEnum.guaJia;
					
					zhanCheVO=FightDataUtil.getVO(itemVO.pickID) as CHARIOT;
					feiJiVO.gid=zhanCheVO.gid;
					
					zhanCheComp=fightMed.comp.getCompByID(itemVO.pickID);
					
					var feiJiComp:FightFeiJiComponent=new FightFeiJiComponent(feiJiVO);
					feiJiComp.mouseChildren=feiJiComp.mouseEnabled=feiJiComp.buttonMode=false;
					
					feiJiComp.relativeZhanChePoint=(zhanCheComp as FightZhanCheComponent).getAreaRangePoint();
					var p:Point=new Point(zhanCheComp.x,zhanCheComp.y);
					
					feiJiComp.x=p.x+feiJiComp.relativeZhanChePoint.x;
					feiJiComp.y=p.y+feiJiComp.relativeZhanChePoint.y;
						
					fightComp.feiJiCompList.push(feiJiComp);
					fightComp.allCompList.push(feiJiComp);
					fightComp.compIDDic[feiJiVO.id]=feiJiComp;
					BattleFightComponent.liaoJiCompList.push(feiJiComp);
					
					fightComp.airSp.addChild(feiJiComp);
					feiJiVO.gid=zhanCheVO.gid;
					feiJiVO.ownID=zhanCheVO.id;
						
					break;
				}
			}

			//销毁物品
			zhanCheComp=fightMed.comp.compIDDic[zhanCheVO.id];
			var x:Number=zhanCheComp.x;
			var y:Number=zhanCheComp.y;
			fightItemComp.moveTweenLite=TweenLite.to(fightItemComp, 0.5, {x: x, y: y, scaleX: 0.2, scaleY: 0.2,
					ease: Linear.easeNone,
					onComplete: complete, onCompleteParams: [fightItemComp]});
		}
		
		private function showDropNumComp(num:Number,x:Number,y:Number):void
		{
			var fightDrop:FightDropNumComponent=new FightDropNumComponent();
			fightDrop.num=num;
			fightDrop.x=x;
			fightDrop.y=y;
			fightMed.comp.addEffect(fightDrop);
			fightDrop.start();
		}

		private function complete(obj:DisplayObject):void
		{
			fightMed.comp.disposeComp(obj);
		}
	}
}
