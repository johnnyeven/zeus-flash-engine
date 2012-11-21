package controller.battle.fight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import enum.ResEnum;
	import enum.battle.FightBuffItemTypeEnum;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	import mediator.battle.BattleFightViewComponentMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import other.DebugInfo;
	
	import ui.managers.SystemManager;
	import ui.utils.DisposeUtil;
	
	import view.battle.fight.FightItemComponent;
	
	import vo.battle.fight.FightHonorVO;

	/**
	 *击毁建筑（炮台）获得荣誉
	 * @author zn
	 *
	 */
	public class FightDropHonorCommand extends SimpleCommand
	{
		public static const FIGHT_DROP_HONOR_COMMAND:String="FIGHT_DROP_HONOR_COMMAND";

		private var fightMed:BattleFightMediator;

		public function FightDropHonorCommand()
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
			var buffVO:BUFFER_DEF=notification.getBody() as BUFFER_DEF;
			var honorVO:FightHonorVO=buffVO.data as FightHonorVO;

			fightMed=getMediator(BattleFightMediator);
			var obj:DisplayObject=fightMed.comp.getCompByID(honorVO.buildingID);

			var itemComp:FightItemComponent=new FightItemComponent();
			itemComp.itemVO=buffVO;

			var fightViewMed:BattleFightViewComponentMediator=getMediator(BattleFightViewComponentMediator);
			
			var p:Point=obj.localToGlobal(new Point());
			p=fightViewMed.comp.globalToLocal(p);
			itemComp.x=p.x;
			itemComp.y=p.y;
			fightViewMed.comp.addChild(itemComp);
				
			//飞到头顶动画
			p=fightViewMed.getHonrPoint();
			p=fightViewMed.comp.globalToLocal(p);
			itemComp.moveTweenLite=TweenLite.to(itemComp, 1.5, {x: p.x, y: p.y, scaleX: 0.2, scaleY: 0.2,
					ease: Linear.easeNone,
					onComplete: complete, onCompleteParams: [itemComp]});
		}

		private function complete(obj:DisplayObject):void
		{
			DisposeUtil.dispose(obj);
		}
	}
}
