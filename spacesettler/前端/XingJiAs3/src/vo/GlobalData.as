package vo
{
	import enum.SenceTypeEnum;
	
	import flash.net.sendToURL;
	
	import mediator.BaseMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.patterns.mediator.Mediator;

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
				ApplicationFacade.getInstance().sendNotification(_currentSenceMed["DESTROY_NOTE"]);
				_currentSenceMed=null;
			}
			
			_currentSence = value;
			
			switch(_currentSence)
			{
				case SenceTypeEnum.MAIN:
				{
					_currentSenceMed=MainSenceComponentMediator;
					break;
				}
				case SenceTypeEnum.PLANT:
				{
					_currentSenceMed=PlantioidComponentMediator;
					break;
				}
			}
		}

	}
}