package controller.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;

	import enum.battle.FightBuffItemTypeEnum;

	import flash.display.DisplayObject;

	import mediator.battle.BattleFightMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import utils.battle.FightDataUtil;

	import view.battle.fight.FightItemComponent;

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

			voObj.isPick=true;

			//增加效果
			switch (itemType)
			{
				case FightBuffItemTypeEnum.naiJiu:
				{
					zhanCheVO.currentEndurance=Math.min(zhanCheVO.totalEndurance, zhanCheVO.currentEndurance + fightItemComp.itemVO.delta);
					break;
				}
				case FightBuffItemTypeEnum.huDun:
				{
					zhanCheVO.currentEndurance=Math.min(zhanCheVO.totalShield, zhanCheVO.currentShield + fightItemComp.itemVO.delta);
					break;
				}
				case FightBuffItemTypeEnum.jinJing:
				{

					break;
				}
				case FightBuffItemTypeEnum.chuanQing:
				{

					break;
				}
				case FightBuffItemTypeEnum.anWuZhi:
				{

					break;
				}
				case FightBuffItemTypeEnum.anNengShuiJing:
				{

					break;
				}
				case FightBuffItemTypeEnum.liaoJi:
				{
					//TODO:ZN 增加僚机
					break;
				}
			}

			//销毁物品
			var zhanCheComp:DisplayObject=fightMed.comp.compIDDic[zhanCheVO.id];
			var x:Number=zhanCheComp.x;
			var y:Number=zhanCheComp.y;
			TweenLite.to(fightItemComp, 0.5, {x: x, y: y, scaleX: 0.2, scaleY: 0.2,
					ease: Linear.easeNone,
					onComplete: complete, onCompleteParams: [fightItemComp]});
		}

		private function complete(obj:DisplayObject):void
		{
			fightMed.comp.disposeComp(obj);
		}
	}
}
