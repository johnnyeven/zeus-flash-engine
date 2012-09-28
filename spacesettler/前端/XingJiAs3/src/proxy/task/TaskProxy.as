package proxy.task
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.BuildProxy;
	import proxy.friend.FriendProxy;
	import proxy.login.LoginProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.userInfo.UserInfoVO;

	/**
	 *任务
	 * @author zn
	 *
	 */
	public class TaskProxy extends Proxy implements IProxy
	{
		public static const NAME:String="TaskProxy";

		public function TaskProxy(data:Object=null)
		{
			super(NAME, data);
			
			Protocol.registerProtocol(CommandEnum.getFreshmanTask,getFreshmanTaskResult);
		}
		
		/**
		 *获取新手任务 
		 * 
		 */
		public function getFreshmanTask():void
		{
//			player_id=28587920797857447&force=1
//			var obj:Object={player_id:userInfoVO.id,force:1};
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var obj:Object={player_id:userInfoVO.player_id};
			ConnDebug.send(CommandEnum.getFreshmanTask, obj, ConnDebug.HTTP);
		}
		
		private function getFreshmanTaskResult(data:Object):void
		{
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return ;
			}
			
			var loginProxy:LoginProxy=getProxy(LoginProxy);
			loginProxy.serverData=data;
			
			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.getUserInfoResult(data);
			
			var friendInfoProxy:FriendProxy=getProxy(FriendProxy);
			friendInfoProxy.getFriendInfoResult(data);
			
			var builderProxy:BuildProxy=getProxy(BuildProxy);
			builderProxy.getBuildInfoResult(data);
		}
		
		/***********************************************************
		 * 
		 * 功能方法
		 * 
		 * ****************************************************/
		
	}
}