package controller.init
{
	import com.zn.utils.URLFunc;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import vo.GlobalData;

	/**
	 *获取URL信息 
	 * @author zn
	 * 
	 */	
	public class GetURLParmsCommand extends SimpleCommand
	{
		public static const GET_URL_PARMS_COMMAND:String="getUrlParmsCommand";
		
		public function GetURLParmsCommand()
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
			var parmsObj:Object=URLFunc.getURLParms();
			
			if (parmsObj.hasOwnProperty("channel"))
				GlobalData.channel = parmsObj["channel"];
			
			//加载配置文件
			sendNotification(LoadConfigCommand.LOAD_CONFIG_NOTE);
		}

	}
}