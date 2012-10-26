package controller.battle.fight
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.EnterFrameUtil;
	import com.zn.utils.RandomUtil;
	import com.zn.utils.StringUtil;

	import enum.battle.FightVOTypeEnum;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	import mediator.battle.BattleFightMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import ui.utils.DisposeUtil;

	import utils.battle.FightDataUtil;
	import utils.battle.FightUtil;

	import view.battle.fight.FightBuildComponent;
	import view.battle.fight.FightDropNumComponent;
	import view.battle.fight.FightFeiJiComponent;
	import view.battle.fight.FightZhanCheComponent;

	import vo.battle.fight.FightExplodeItemVO;
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;

	/**
	 *爆炸控制器
	 * @author zn
	 *
	 */
	public class FightExplodeCommand extends SimpleCommand
	{
		public static const FIGHT_EXPLODE_COMMAND:String="FIGHT_EXPLODE_COMMAND";

		private var _explodeVO:FightExplodeVO;
		private var fightMed:BattleFightMediator;

		public function FightExplodeCommand()
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
			_explodeVO=notification.getBody() as FightExplodeVO;
			fightMed=getMediator(BattleFightMediator);

			var className:String;

			var voObj:Object=FightDataUtil.getVO(_explodeVO.id);

			if (!voObj)
				return;

			if (voObj.voType == FightVOTypeEnum.guaJia)
			{
				//挂件攻击
				var tankpartVO:TANKPART=voObj as TANKPART;
				var chariotVO:CHARIOT=FightDataUtil.getVO(tankpartVO.chariotId.toString()) as CHARIOT;

				if (chariotVO.voType == FightVOTypeEnum.xiaoFeiJi)
				{
					//小飞机自爆
					className=StringUtil.formatString("battle.feiJDisposeEffect_{0}", RandomUtil.getRangeInt(0, 2));
					disposeEffect(className, fightMed.comp.getCompByID(chariotVO.id.toString()));
				}
				else
				{
					className=StringUtil.formatString("battle.explodeEffect_{0}", tankpartVO.attackType);
					showEffect(className);
				}
			}
			else if (voObj.voType == FightVOTypeEnum.building)
			{
				//炮塔
				className=StringUtil.formatString("battle.explodeEffect_{0}", voObj.attackType);
				showEffect(className);
			}
		}

		private function disposeEffect(className:String, hitObj:DisplayObject):void
		{
			var effectMC:MovieClip=ClassUtil.getObject(className);
			effectMC.mouseChildren=effectMC.mouseEnabled=false;
			effectMC.addEventListener(Event.COMPLETE, effectMC_completeHandler);
			effectMC.x=hitObj.x;
			effectMC.y=hitObj.y;
			fightMed.comp.addEffect(effectMC);
			effectMC.gotoAndPlay(1);

			fightMed.comp.disposeComp(hitObj);
		}

		private function showEffect(className:String):void
		{
			var effectMC:MovieClip=ClassUtil.getObject(className);
			effectMC.mouseChildren=effectMC.mouseEnabled=false;
			effectMC.addEventListener(Event.COMPLETE, effectMC_completeHandler);
			effectMC.x=_explodeVO.startX;
			effectMC.y=_explodeVO.startY;
			fightMed.comp.addEffect(effectMC);
			effectMC.gotoAndPlay(1);
		}


		protected function effectMC_completeHandler(event:Event):void
		{
			var effectObj:DisplayObject=event.currentTarget as DisplayObject;
			effectObj.removeEventListener(Event.COMPLETE, effectMC_completeHandler);
			EnterFrameUtil.callLater(function():void
			{
				DisposeUtil.dispose(effectObj);
			});
		}
	}
}
