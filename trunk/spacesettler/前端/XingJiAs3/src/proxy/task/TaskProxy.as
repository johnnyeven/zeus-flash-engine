package proxy.task
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.utils.XMLUtil;

	import controller.task.TaskCommand;
	import controller.task.TaskCompleteCommand;

	import enum.TaskEnum;
	import enum.battle.GameServerErrorEnum;
	import enum.command.CommandEnum;

	import flash.net.URLRequestMethod;

	import mediator.prompt.PromptMediator;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import other.ConnDebug;

	import proxy.BuildProxy;
	import proxy.friendList.FriendProxy;
	import proxy.login.LoginProxy;
	import proxy.userInfo.UserInfoProxy;

	import vo.task.TaskInfoVO;
	import vo.userInfo.UserInfoVO;

	/**
	 *任务
	 * @author zn
	 *
	 */
	public class TaskProxy extends Proxy implements IProxy
	{
		public static const NAME:String="TaskProxy";

		public var taskXML:XML

		public var taskInfoVO:TaskInfoVO;

		private var callBackFun:Function;
		private var _callBackFun:Function;

		public function TaskProxy(data:Object=null)
		{
			super(NAME, data);

			taskXML=XMLUtil.getXML("task.xml");

			Protocol.registerProtocol(CommandEnum.getFreshmanTask, getFreshmanTaskResult);
			Protocol.registerProtocol(CommandEnum.web_update, web_updateResult);
		}

		/**
		 *游戏内用户注册 修改账户信息
		 *
		 */
		public function web_update(username:String, password:String, nickname:String, email:String=null, fun:Function=null):void
		{
			_callBackFun=fun;
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var obj:Object={officer_id: userInfoVO.officer_id, username: username, password: password, nickname: nickname, email: email};
			ConnDebug.send(CommandEnum.web_update, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}



		/**
		 *获取新手任务
		 *
		 */
		public function getFreshmanTask(fun:Function=null, force:int=0):void
		{
			callBackFun=fun;
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var obj:Object={};
			obj={player_id: userInfoVO.player_id, force: 1};
			ConnDebug.send(CommandEnum.getFreshmanTask, obj, ConnDebug.HTTP, URLRequestMethod.GET);

//			获取所有任务奖励
//			var obj:Object={player_id:userInfoVO.id,force:1};
//			for (var i:int = 0; i < 30; i++) 
//			{
//				ConnDebug.send(CommandEnum.getFreshmanTask, obj, ConnDebug.HTTP,URLRequestMethod.GET);
//			}

			//获取所有东西作弊
//			var obj:Object={player_id:userInfoVO.player_id};
//			ConnDebug.send(CommandEnum.getCheat, obj, ConnDebug.HTTP);
		}

		private function web_updateResult(data:Object):void
		{
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return;
			}


			if (_callBackFun != null)
				_callBackFun();
			_callBackFun=null;
		}

		private function getFreshmanTaskResult(data:Object):void
		{
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return;
			}

			var loginProxy:LoginProxy=getProxy(LoginProxy);
			loginProxy.serverData=data;

			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.getUserInfoResult(data);

//			var friendInfoProxy:FriendProxy=getProxy(FriendProxy);
//			friendInfoProxy.getFriendList(data.playerID,null);

			var builderProxy:BuildProxy=getProxy(BuildProxy);
			builderProxy.getBuildInfoResult(data);



			if (callBackFun != null)
				callBackFun();
			callBackFun=null;

		}

		/***********************************************************
		 *
		 * 功能方法
		 *
		 * ****************************************************/
		public function getTaskItemInfo(obj:Object):TaskInfoVO
		{
			taskInfoVO=new TaskInfoVO();
			taskInfoVO.is_finished=obj.isFinished;
			taskInfoVO.is_rewarded=obj.isRewarded
			taskInfoVO.index=obj.index;

			if (taskInfoVO.index == TaskEnum.index1)
			{
				taskInfoVO.is_finished=false;
			}
			var xml:XML;
			xml=taskXML.taskItem.(index == taskInfoVO.index)[0];

			if (xml != null)
			{
				taskInfoVO.title=xml.title;
				taskInfoVO.type=xml.type;
				if (xml.name)
					taskInfoVO.name=xml.name;

				taskInfoVO.broken_crystal=xml.broken_crystal;
				taskInfoVO.crystal=xml.crystal;
				taskInfoVO.tritium=xml.tritium;
				taskInfoVO.dark_crystal=xml.dark_crystal;

				taskInfoVO.des=xml.des;
				taskInfoVO.goalDes=xml.goalDes;
				taskInfoVO.completeDes=xml.completeDes;

				var xmlList:XMLList=xml.compID.id;
				var length:int=xmlList.length();
				var list:Array=[];
				for (var i:int; i < length; i++)
				{
					var id:int=xmlList[i];
					list.push(id);
				}
				taskInfoVO.idArr=list;

			}

			return taskInfoVO;
		}
	}
}
