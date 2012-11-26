package controller.mainSence
{
	import com.greensock.TweenLite;
	
	import enum.SenceTypeEnum;
	
	import flash.utils.setTimeout;
	
	import mediator.BaseMediator;
	import mediator.battle.BattleEditMediator;
	import mediator.battle.BottomViewComponentMediator;
	import mediator.battle.TimeViewComponentMediator;
	import mediator.groupFight.GroupFightComponentMediator;
	import mediator.groupFight.GroupFightMapComponentMediator;
	import mediator.groupFight.GroupFightMenuComponentMediator;
	import mediator.groupFight.GroupFightShowComponentMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ShowCommand extends SimpleCommand
	{
		public static const SHOW_INTERFACE:String="SHOW_INTERFACE";
		
		private var obj:Object;
		public function ShowCommand()
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
					sendNotification(GroupFightComponentMediator.SHOW_NOTE);
					sendNotification(GroupFightMenuComponentMediator.SHOW_NOTE);
					sendNotification(GroupFightShowComponentMediator.SHOW_NOTE);
					sendNotification(GroupFightMapComponentMediator.SHOW_NOTE);
					getMediator(GroupFightComponentMediator,function(med:GroupFightComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(GroupFightMapComponentMediator,function(med:GroupFightMapComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(GroupFightShowComponentMediator,function(med:GroupFightShowComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(GroupFightMenuComponentMediator,function(med:GroupFightMenuComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(MainViewMediator,function(med:MainViewMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					break;
				}
				case SenceTypeEnum.PLANT:
				{
					setTimeout(function():void
					{
						sendNotification(PlantioidComponentMediator.SHOW_NOTE);
						getMediator(PlantioidComponentMediator,function(med:PlantioidComponentMediator):void
						{			
							med.comp.alpha=0;
							setTimeout(function():void
							{
								TweenLite.to(med.comp,1,{alpha:1});
							},1000);			
						});
						getMediator(MainViewMediator,function(med:MainViewMediator):void
						{			
							med.comp.alpha=0;
							setTimeout(function():void
							{
								TweenLite.to(med.comp,1,{alpha:1});
							},1000);			
						});
					},500);
					
					break;
				}
				case SenceTypeEnum.EDIT_BATTLE:
				{
					sendNotification(BattleEditMediator.SHOW_NOTE,obj.id);
					getMediator(BattleEditMediator,function(med:BattleEditMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(BottomViewComponentMediator,function(med:BottomViewComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(MainViewMediator,function(med:MainViewMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(TimeViewComponentMediator,function(med:TimeViewComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					break;
				}
				case SenceTypeEnum.MAIN:
				{
					sendNotification(MainSenceComponentMediator.SHOW_NOTE);
					sendNotification(MainViewMediator.SHOW_NOTE);
					sendNotification(MainViewMediator.SHOW_TOP_VIEW_NOTE);
					getMediator(MainSenceComponentMediator,function(med:MainSenceComponentMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					getMediator(MainViewMediator,function(med:MainViewMediator):void
					{			
						med.comp.alpha=0;
						setTimeout(function():void
						{
							TweenLite.to(med.comp,1,{alpha:1});
						},1000);			
					});
					break;
				}
			}
		}

	}
}