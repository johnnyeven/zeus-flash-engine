package controller.battle.fight
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.EnterFrameUtil;
	import com.zn.utils.SoundUtil;
	import com.zn.utils.StringUtil;
	
	import enum.SoundEnum;
	import enum.battle.FightVOTypeEnum;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mediator.battle.BattleFightMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.battle.BattleProxy;
	
	import ui.utils.DisposeUtil;
	
	import utils.battle.FightDataUtil;
	import utils.battle.FightUtil;
	
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;

	/**
	 * 开火
	 * @author zn
	 *
	 */
	public class FightFireCommand extends SimpleCommand
	{
		public static const FIGHT_FIRE_COMMAND:String="FIGHT_FIRE_COMMAND";

		private var fireVO:FightFireVO;

		private var fightMed:BattleFightMediator;

		public function FightFireCommand()
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
			//开火
			fireVO=notification.getBody() as FightFireVO;

			fightMed=getMediator(BattleFightMediator);

			var className:String;
			var voObj:Object=FightDataUtil.getVO(fireVO.id);
			
			if(!voObj)
				return ;
			
			if (voObj.voType == FightVOTypeEnum.building)
			{
				//炮台
				var buildVO:FORTBUILDING=voObj as FORTBUILDING;
				//设置开火冷却时间
				buildVO.attackCoolEndTime=DateFormatter.currentTimeM + buildVO.currentAttackCoolDown;

				switch(buildVO.attackType)
				{
					case 1:
						SoundUtil.play(SoundEnum.ammunition_fire,false);
						break;
					case 2:
						SoundUtil.play(SoundEnum.electric_fire,false);
						break;
					case 3:
						SoundUtil.play(SoundEnum.laser_fire,false);
						break;
					case 4:
						SoundUtil.play(SoundEnum.nuclear_fire,false);
						break;
				}
				//开火特效
				className=StringUtil.formatString("battle.FireEffect_{0}_1", buildVO.attackType);
				
			}
			else if (voObj is CHARIOT)
			{
				var tankpartVO:TANKPART=FightDataUtil.getVO(fireVO.guaJianID) as TANKPART;
				var chariotVO:Object=FightDataUtil.getVO(fireVO.id.toString());

				//设置开火冷却时间
				tankpartVO.attackCoolEndTime=DateFormatter.currentTimeM + tankpartVO.attackCoolDown;

				switch(tankpartVO.attackType)
				{
					case 1:
						SoundUtil.play(SoundEnum.ammunition_fire,false);
						break;
					case 2:
						SoundUtil.play(SoundEnum.electric_fire,false);
						break;
					case 3:
						SoundUtil.play(SoundEnum.laser_fire,false);
						break;
					case 4:
						SoundUtil.play(SoundEnum.nuclear_fire,false);
						break;
				}
				// 开火特效
				className=StringUtil.formatString("battle.FireEffect_{0}_{1}", tankpartVO.attackType, tankpartVO.caliber);
			}
			
			showEffect(className);
		}

		private function showEffect(className:String):void
		{
			var effectMC:MovieClip=ClassUtil.getObject(className);
			effectMC.mouseChildren=effectMC.mouseEnabled=false;
			effectMC.addEventListener(Event.COMPLETE, effectMC_completeHandler);
			effectMC.rotation=-fireVO.rotation;
			effectMC.x=fireVO.startX;
			effectMC.y=fireVO.startY;
			fightMed.comp.addEffect(effectMC);
			effectMC.gotoAndPlay(1);
		}


		/**
		 *开火特效播放完成
		 * @param event
		 *
		 */
		protected function effectMC_completeHandler(event:Event):void
		{
			var effectObj:DisplayObject=event.currentTarget as DisplayObject;
			effectObj.removeEventListener(Event.COMPLETE, effectMC_completeHandler);
			EnterFrameUtil.callLater(function():void
			{
				DisposeUtil.dispose(effectObj);
			});

			//开火完成，发送爆炸信息

			//判断是否控制权是否在我
			var voObj:Object=FightDataUtil.getVO(fireVO.hitID);
			var myID:String=FightDataUtil.getMyChariot().id.toString();
			
			if(voObj && (voObj.myAttackID==myID || myID==fireVO.hitID))
			{
				var explodeVO:FightExplodeVO=FightUtil.getExplodeVO(fireVO);
				if(explodeVO)
				{
					BattleProxy(getProxy(BattleProxy)).attacked(explodeVO);
	//				//通知爆炸控制器
					sendNotification(FightExplodeCommand.FIGHT_EXPLODE_COMMAND, explodeVO);
				}
					
	
				
			}
		}
	}
}
