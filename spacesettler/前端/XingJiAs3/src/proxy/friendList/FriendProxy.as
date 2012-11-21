package proxy.friendList
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.utils.ObjectUtil;
	
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.userInfo.UserInfoProxy;
	
	import vo.allView.FriendInfoVo;
	
	/**
	 *好友 
	 * @author lw
	 * 
	 */	
	public class FriendProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FriendProxy";
		
		private var _getFriendListCallBack:Function;
		
		[Bindable]
		public var friendArr:Array=[];
		
		[Bindable]
		public var enemyArr:Array = [];
		
		[Bindable]
		public var searchPlayerList:Array = [];
		
		[Bindable]
		public var playerIDCardVO:FriendInfoVo;
		
		private var callBackFunction:Function;
		
		private var userInforProxy:UserInfoProxy;
		/**
		 * 暂存的搜寻玩家数据
		 */		
		private var searchData:Object = {};
		public function FriendProxy( data:Object=null)
		{
			super(NAME, data);
			userInforProxy = getProxy(UserInfoProxy);
			Protocol.registerProtocol(CommandEnum.friendList,getFriendInfoResult);
			Protocol.registerProtocol(CommandEnum.searchPlayer,searchPlayerResult);
			Protocol.registerProtocol(CommandEnum.deletedFriend,deletedFriendResult);
			Protocol.registerProtocol(CommandEnum.viewPlayerIDCard,checkOtherPlayerResult);
			Protocol.registerProtocol(CommandEnum.addFriend,addFriendResult);
		}
		
		/**
		 *获取好友列表   或敌人列表 
		 * @param playerID
		 * @param callBack
		 * 
		 */		
		public function getFriendList(playerID:String,callBack:Function=null):void
		{
			_getFriendListCallBack = callBack;
			var obj:Object = {player_id:playerID};
			ConnDebug.send(CommandEnum.friendList,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function getFriendInfoResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			var friendList:Array=[];
			var enemyList:Array=[];
			if(data.friends_list)
			{
				for(var i:int = 0;i<data.friends_list.length;i++)
				{
					var friendListVO:FriendInfoVo = new FriendInfoVo();
					    friendListVO.id = data.friends_list[i].id;
						friendListVO.isMyFriend = true;
					    friendListVO.nickname = data.friends_list[i].nickname;
					    friendListVO.officer_id = data.friends_list[i].officer_id;
					    friendListVO.vip_level = data.friends_list[i].vip_level;
						friendListVO.age_level = data.friends_list[i].age_level;
						friendListVO.last_login_time = data.friends_list[i].last_login_time;
					
					    friendList.push(friendListVO);
				}
				friendArr=friendList;
			}
			if(data.enemies_list)
			{
				for(var j:int=0;j<data.enemies_list.length;j++)
				{
					var enemyListVO:FriendInfoVo = new FriendInfoVo();
					    enemyListVO.id = data.enemies_list[j].id;
						enemyListVO.isMyEnemy = true;
					    enemyListVO.nickname = data.enemies_list[j].nickname;
					    enemyListVO.age_level = data.enemies_list[j].age_level;
					    enemyListVO.vip_level = data.enemies_list[j].vip_level;
						enemyListVO.attack_time = data.enemies_list[j].attack_time;
						enemyListVO.attack_fort_id = data.enemies_list[j].attack_fort_id;
						enemyListVO.x = data.enemies_list[j].x;
						enemyListVO.y = data.enemies_list[j].y;
						enemyListVO.z = data.enemies_list[j].z;
						enemyListVO.is_captured = data.enemies_list[j].is_captured;
					
					    enemyList.push(enemyListVO);
				}
				enemyArr=enemyList;
			}
			if(_getFriendListCallBack != null)
				_getFriendListCallBack();
			 _getFriendListCallBack=null;
		}
		
		/**
		 * 搜寻玩家
		 * @param nickName
		 * 
		 */		
		public function searchPlayer(nickName:String):void
		{
			var obj:Object = {keyword:nickName};
			ConnDebug.send(CommandEnum.searchPlayer,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function searchPlayerResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			searchData = data;
			var playerList:Array=[];
			if(data.players)
			{
				for(var i:int = 0;i<data.players.length;i++)
				{
					var searchPlayerListVO:FriendInfoVo = new FriendInfoVo();
					searchPlayerListVO.id = data.players[i].id;
					searchPlayerListVO.isMyFriend = markFriend(searchPlayerListVO.id);
					searchPlayerListVO.isMyEnemy = markEnemy(searchPlayerListVO.id);
					searchPlayerListVO.nickname = data.players[i].nickname;
					searchPlayerListVO.officer_id = data.players[i].officer_id;
					searchPlayerListVO.vip_level = data.players[i].vip_level;
					searchPlayerListVO.age_level = data.players[i].age_level;
					searchPlayerListVO.last_login_time = data.players[i].last_login_time;
					
					playerList.push(searchPlayerListVO);
				}
				searchPlayerList=playerList;
			}
		}
		
		/**
		 *查看军官证 
		 * @param playerID
		 * @param callBack
		 * 
		 */		
		public function checkOtherPlayer(playerID:String,callBack:Function=null):void
		{
			callBackFunction = callBack;
			var obj:Object = {type:"player",id:playerID};
			ConnDebug.send(CommandEnum.viewPlayerIDCard,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function checkOtherPlayerResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			var idCardVO:FriendInfoVo = new FriendInfoVo();
			
			    idCardVO.vip_level = data.vip_level;
				idCardVO.vip_start_at=data.vip_start_at;
				idCardVO.vip_expired_at=data.vip_expired_at;
			    idCardVO.id = data.id;
				idCardVO.isMyFriend = markFriend(idCardVO.id);
				idCardVO.isMyEnemy = markEnemy(idCardVO.id);
		        idCardVO.nickname = data.nickname;
			    idCardVO.academy_level = data.academy_level;
				idCardVO.age_level = data.age_level;
				if(data.legion)
				{
					idCardVO.groupListVO.groupname = data.legion.name;
					idCardVO.groupListVO.level = data.legion.level;
				}
				
				idCardVO.military_rank = data.military_rank;
				idCardVO.total_prestige_rank = data.my_rank.total_prestige_rank;
				
				
			playerIDCardVO = idCardVO;
			if(callBackFunction != null)
				callBackFunction();
			callBackFunction = null;
		}
		
		/**
		 * 删除好友
		 * @param playerID
		 * 
		 */		
		public function deletedFriend(playerID:String):void
		{
			var myID:String = userInforProxy.userInfoVO.player_id;
			var obj:Object = {player_id:myID,friend_id:playerID};
			ConnDebug.send(CommandEnum.deletedFriend,obj);
		}
		
		private function deletedFriendResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			if(data.message_type == "remove_friend")
			{
				var obj:Object = {infoLable:MultilanguageManager.getString("removeFriendTitle"),showLable:MultilanguageManager.getString("removeFriendInfor"),mediatorLevel:2};
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			}
			getFriendInfoResult(data);
		}
		
		/**
		 * 添加好友
		 * @param playerID
		 * 
		 */		
		public function addFriend(playerID:String):void
		{
			var myID:String = userInforProxy.userInfoVO.player_id;
			var obj:Object = {player_id:myID,friend_id:playerID};
			ConnDebug.send(CommandEnum.addFriend,obj);
		}
		
		private function addFriendResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			if(data.message_type == "make_friend")
			{
				var obj:Object = {infoLable:MultilanguageManager.getString("makeFriendTitle"),showLable:MultilanguageManager.getString("makeFriendInfor"),mediatorLevel:3};
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			}
			getFriendInfoResult(data);
			searchPlayerResult(searchData);
			
		}
		
		/***********************************************************
		 *
		 * 功能方法
		 *
		 * ****************************************************/
		/**
		 * 好友标记
		 * @return 
		 * 
		 */		
		private function markFriend(playerID:String):Boolean
		{
			var bool:Boolean = false;
			var techDicObj:Object = ObjectUtil.CreateDic(friendArr,"id");
			var obj1:Object = techDicObj[playerID];
			if(obj1)
			{
				bool = true;
			}
			else
			{
				bool = false;
			}
			return bool;
		}
		
		/**
		 * 敌人标记
		 * @return 
		 * 
		 */		
		private function markEnemy(playerID:String):Boolean
		{
			var bool:Boolean = false;
			var techDicObj:Object = ObjectUtil.CreateDic(enemyArr,"id");
			var obj1:Object = techDicObj[playerID];
			if(obj1)
			{
				bool = true;
			}
			else
			{
				bool = false;
			}
			return bool;
		}
	}
}