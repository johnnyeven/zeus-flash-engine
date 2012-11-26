package controller.mainSence
{
	import com.greensock.TweenLite;
	
	import enum.SenceTypeEnum;
	
	import flash.utils.setTimeout;
	
	import mediator.BaseMediator;
	import mediator.battle.BattleEditMediator;
	import mediator.battle.BattleFightMediator;
	import mediator.battle.BottomViewComponentMediator;
	import mediator.battle.TimeViewComponentMediator;
	import mediator.groupFight.GroupFightComponentMediator;
	import mediator.groupFight.GroupFightMapComponentMediator;
	import mediator.groupFight.GroupFightMenuComponentMediator;
	import mediator.groupFight.GroupFightShowComponentMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class DestroyCommand extends SimpleCommand
	{
		public static const DESTROY_INTERFACE:String="DESTROY_INTERFACE";
		
		private var obj:Object;
		public function DestroyCommand()
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
			obj=notification.getBody();
			
			switch(obj.type)
			{
				case SenceTypeEnum.GROUP_FIGHT:
				{
					getMediator(GroupFightComponentMediator,function(med:GroupFightComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{
							med.destroy();
							sendNotification(GroupFightMenuComponentMediator.DESTROY_NOTE);
							sendNotification(GroupFightShowComponentMediator.DESTROY_NOTE);
							sendNotification(GroupFightMapComponentMediator.DESTROY_NOTE);
						}});
					});
					/*getMediator(GroupFightMenuComponentMediator,function(med:GroupFightMenuComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					getMediator(GroupFightShowComponentMediator,function(med:GroupFightShowComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					getMediator(GroupFightMapComponentMediator,function(med:GroupFightMapComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});*/
					break;
				}
				case SenceTypeEnum.PLANT:
				{
					getMediator(PlantioidComponentMediator,function(med:PlantioidComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					break;
				}
				case SenceTypeEnum.MAIN:
				{
					getMediator(MainSenceComponentMediator,function(med:MainSenceComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					break;
				}
				case SenceTypeEnum.EDIT_BATTLE:
				{
//					sendNotification(BattleEditMediator.DESTROY_NOTE);
					getMediator(BattleEditMediator,function(med:BattleEditMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					getMediator(BottomViewComponentMediator,function(med:BottomViewComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					getMediator(TimeViewComponentMediator,function(med:TimeViewComponentMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					break;
				}
				case SenceTypeEnum.FIGHT_BATTLE:
				{
//					sendNotification(BattleFightMediator.DESTROY_NOTE);
					getMediator(BattleFightMediator,function(med:BattleFightMediator):void
					{			
						med.comp.alpha=1;
						TweenLite.to(med.comp,1,{alpha:0,onComplete:function():void{med.destroy()}});
					});
					
					break;
				}
			}
			
		}

	}
}