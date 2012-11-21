package vo
{
	import com.zn.utils.SoundUtil;
	
	import enum.SenceTypeEnum;
	import enum.SoundEnum;
	
	import flash.net.sendToURL;
	
	import mediator.BaseMediator;
	import mediator.battle.BattleEditMediator;
	import mediator.battle.BattleFightMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ui.managers.PopUpManager;
	import ui.utils.UIUtil;

	/**
	 *全局数据 
	 * @author zn
	 * 
	 */	
	public class GlobalData
	{
		public static var channel:int=0;
		
		/**
		 *获取服务器列表时使用 
		 */		
		public static var game_id:String="";
		
		/**
		 *当前场景 
		 */		
		private static var _currentSence:int;
		
		private static var _currentSenceMed:*;

		public static function get currentSence():int
		{
			return _currentSence;
		}

		public static function set currentSence(value:int):void
		{
			if(_currentSence==value)
				return ;
			
			if(_currentSenceMed)
			{
				PopUpManager.closeAll(0);
				ApplicationFacade.getInstance().sendNotification(_currentSenceMed["DESTROY_NOTE"]);
				_currentSenceMed=null;
			}
			
			_currentSence = value;
			
			switch(_currentSence)
			{
				case SenceTypeEnum.MAIN:
				{
					SoundUtil.stopAll();
					SoundUtil.play(SoundEnum.bg_music,true);
					_currentSenceMed=MainSenceComponentMediator;
					break;
				}
				case SenceTypeEnum.PLANT:
				{
					SoundUtil.stopAll();
					SoundUtil.play(SoundEnum.bg_music,true);
					_currentSenceMed=PlantioidComponentMediator;
					break;
				}
				case SenceTypeEnum.EDIT_BATTLE:
				{
					SoundUtil.stopAll();
					SoundUtil.play(SoundEnum.bg_music,true);
					_currentSenceMed=BattleEditMediator;
					break;
				}
				case SenceTypeEnum.FIGHT_BATTLE:
				{
					SoundUtil.stopAll();
					SoundUtil.play(SoundEnum.battle_bg_music,true);
					_currentSenceMed=BattleFightMediator;
					break;
				}
			}
		}

	}
}