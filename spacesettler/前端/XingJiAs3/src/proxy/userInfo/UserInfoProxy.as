package proxy.userInfo
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.utils.StringUtil;
	
	import controller.task.TaskCompleteCommand;
	
	import enum.TaskEnum;
	import enum.command.CommandEnum;
	import enum.friendList.FriendListCardEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.mainView.MainViewMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.BuildProxy;
	import proxy.login.LoginProxy;
	import proxy.timeMachine.TimeMachineProxy;
	
	import vo.userInfo.BuffVo;
	import vo.userInfo.UserInfoVO;

	/**
	 *用户信息
	 * @author zn
	 *
	 */
	public class UserInfoProxy extends Proxy implements IProxy
	{
		public static const NAME:String="UserInfoProxy";

		public static var SESSION_KEY:String="";

		private var _getUserInfoCallBack:Function;
		
		

		[Bindable]
		public var userInfoVO:UserInfoVO;

		public function UserInfoProxy(data:Object=null)
		{
			super(NAME, data);
		}

		/**
		 *刷新玩家信息
		 *
		 */
		public function updateInfo(callFun:Function=null):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.updateInfo, updateInfoResult))
				Protocol.registerProtocol(CommandEnum.updateInfo, updateInfoResult);
			_getUserInfoCallBack=callFun;
			var id:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.id;
			var obj:Object={id: id};
			ConnDebug.send(CommandEnum.updateInfo, obj, ConnDebug.HTTP, URLRequestMethod.GET);
		}

		public function updateInfoResult(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.updateInfo, updateInfoResult);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return;
			}

			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.updateServerData(data);
			
			if(_getUserInfoCallBack!=null)
				_getUserInfoCallBack();
			_getUserInfoCallBack=null;
		}

		public function getUserInfoResult(data:Object):void
		{
			if (!userInfoVO)
			{
				userInfoVO=new UserInfoVO();
			}
			userInfoVO.id=data.base.id;
			userInfoVO.player_id=data.base.player_id;
			userInfoVO.nickname=data.nickname;
			userInfoVO.vip_level=data.vip_level;
			userInfoVO.officer_id=data.officer_id;
			userInfoVO.vip_mail=data.vip_mail;
			userInfoVO.vip_speed=data.vip_speed;
			
			userInfoVO.crystal_volume=data.base.crystal_volume;
			userInfoVO.tritium_volume=data.base.tritium_volume;

			userInfoVO.crystal_output=data.base.crystal_output;
			userInfoVO.tritium_output=data.base.tritium_output;
			userInfoVO.broken_crystal_output=data.base.broken_crystal_output;

			userInfoVO.crystal=data.base.crystal;
			userInfoVO.broken_crysta=data.base.broken_crystal;
			userInfoVO.current_power_consume=data.base.current_power_consume;
			userInfoVO.current_power_supply=data.base.current_power_supply;
			userInfoVO.dark_crystal=data.dark_crystal;
			userInfoVO.level=data.age_level;
			userInfoVO.prestige=data.prestige;
			userInfoVO.tritium=data.base.tritium;
			userInfoVO.userName=data.base.name;
			if (data.legion_id)
				userInfoVO.legion_id=data.legion_id;
			if (data.legion)
				userInfoVO.legion_name=data.legion.name;
			userInfoVO.militaryRrank=data.military_rank;

			userInfoVO.server_camp=data.camp_id;
			userInfoVO.camp=userInfoVO.server_camp + 1;
//			userInfoVO.camp=2;
			if (data.current_quest)
			{
				userInfoVO.index=data.current_quest.index;
				userInfoVO.is_finished=data.current_quest.is_finished;
				userInfoVO.is_rewarded=data.current_quest.is_rewarded;
			}
			else
			{
				userInfoVO.index=28;
			}
			
			FriendListCardEnum.friendListarr=data.friends_list;

			if (data.buffs)
			{
				for (var i:int=0; i < data.buffs.length; i++)
				{
					var buffVo:BuffVo=new BuffVo;
					buffVo.type=data.buffs[i].type;
					buffVo.value=data.buffs[i].value;
					if (i == 0)
					{
						userInfoVO.buff1=buffVo;
					}
					else if (i == 1)
					{
						userInfoVO.buff2=buffVo;
					}
					else if (i == 2)
					{
						userInfoVO.buff3=buffVo;
					}
				}
			}
			
			userInfoVO.new_mail=data.new_mail;
			if(data.new_mail>0)
				sendNotification(MainViewMediator.SHOW_NEW_EMAIL_TIPS_NOTE,true);
			else
				sendNotification(MainViewMediator.SHOW_NEW_EMAIL_TIPS_NOTE,false);

			userInfoVO.received_daily_rewards=data.received_daily_rewards;
			userInfoVO.received_continuous_rewards=data.received_continuous_rewards;
			userInfoVO.received_online_rewards=data.received_online_rewards;

			if (StringUtil.isEmpty(userInfoVO.session_key))
				userInfoVO.session_key=data.session_key;

			userInfoVO.start();



			if (_getUserInfoCallBack != null)
				_getUserInfoCallBack();
			_getUserInfoCallBack=null;

			Main.setMouseCursor(userInfoVO.camp);
		}

		/***********************************************************
		 *
		 * 功能方法
		 *
		 * ****************************************************/
		/**
		 *更新服务器数据
		 * @param data
		 */
		public function updateServerData(data:*=null):void
		{
			var loginProxy:LoginProxy=getProxy(LoginProxy);
			if (data)
				loginProxy.serverData=data;

			getUserInfoResult(loginProxy.serverData);

			var buildProxy:BuildProxy=getProxy(BuildProxy);
			buildProxy.getBuildInfoResult(loginProxy.serverData);
			var timeMachineProxy:TimeMachineProxy=getProxy(TimeMachineProxy);
			timeMachineProxy.timeMachineInfor(loginProxy.serverData);

			SESSION_KEY=userInfoVO.session_key;
		}
	}
}
