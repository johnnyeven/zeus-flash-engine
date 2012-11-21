package proxy.crystalSmelter
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import controller.task.TaskCompleteCommand;
	
	import enum.TaskEnum;
	import enum.command.CommandEnum;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.userInfo.UserInfoProxy;
	
	public class CrystalSmelterProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "CrystalSmelterProxy";
		
		private var userInforProxy:UserInfoProxy;
		
		public function CrystalSmelterProxy(data:Object=null)
		{
			super(NAME, data);
			
			Protocol.registerProtocol(CommandEnum.smelte, smelteResult);
		}
		
		public function smelte():void
		{
			userInforProxy = getProxy(UserInfoProxy);
			var baseID:String = userInforProxy.userInfoVO.id;
			var count:int = 4000;
			var obj:Object = {base_id:baseID,crystal:count};
			ConnDebug.send(CommandEnum.smelte,obj);
		}
		
		private function smelteResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
			userInforProxy.updateServerData(data);
			if(userInforProxy.userInfoVO.index==TaskEnum.index5)
			{
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			}
		}
	}
}