package controller.battle.fight
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.EnterFrameUtil;
	import com.zn.utils.RandomUtil;
	import com.zn.utils.StringUtil;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	import mediator.battle.BattleFightMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import ui.utils.DisposeUtil;

	import utils.battle.FightDataUtil;

	import view.battle.fight.FightDropNumComponent;

	import vo.battle.fight.FightHitVO;

	/**
	 *伤害
	 * @author zn
	 *
	 */
	public class FightHitCommand extends SimpleCommand
	{
		public static const FIGHT_HIT_COMMAND:String="FIGHT_HIT_COMMAND";

		private var fightMed:BattleFightMediator;

		public function FightHitCommand()
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
			var hitList:Array=notification.getBody() as Array;
			fightMed=getMediator(BattleFightMediator);

			var hitVO:FightHitVO;
			var voObj:Object;
			var comp:DisplayObject;
			var hitNumComp:FightDropNumComponent;
			var enduranceDis:Number;
			for (var i:int=0; i < hitList.length; i++)
			{
				hitVO=hitList[i];

				voObj=FightDataUtil.getVO(hitVO.id);

				if (!voObj)
					return;

				comp=fightMed.comp.getCompByID(hitVO.id);
				enduranceDis=hitVO.current_endurance - voObj.currentEndurance;
				voObj.currentEndurance=hitVO.current_endurance;

				//显示减血效果
				hitNumComp=new FightDropNumComponent();
				hitNumComp.num=enduranceDis;
				hitNumComp.x=comp.x;
				hitNumComp.y=comp.y;
				fightMed.comp.addEffect(hitNumComp);
				hitNumComp.start();

				if (voObj.currentEndurance == 0)
				{
					//摧毁
					var className:String=StringUtil.formatString("battle.disposeEffect_{0}", RandomUtil.getRangeInt(0, 2));
					disposeEffect(className, comp);
				}
				else if (hitVO.current_shield > 0)
				{
					//显示护盾
				}
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
