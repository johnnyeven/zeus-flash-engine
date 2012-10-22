package proxy.friendList
{
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import vo.allView.FriendInfoVo;
	
	public class FriendProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FriendProxy";
		
		private var _getFriendListCallBack:Function;
		
		[Bindable]
		public var friendArr:Array=[];
		
		[Bindable]
		public var enemyArr:Array = [];
		
		public function FriendProxy( data:Object=null)
		{
			super(NAME, data);
			
			Protocol.registerProtocol(CommandEnum.friendList,getFriendInfoResult);
		}
		
		
		public function getFriendList(playerID:String,callBack:Function):void
		{
			_getFriendListCallBack = callBack;
			var obj:Object = {player_id:playerID};
			ConnDebug.send(CommandEnum.friendList,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function getFriendInfoResult(data:Object):void
		{
			var friendList:Array=[];
			var enemyList:Array=[];
			if(data.friends_list)
			{
				for(var i:int = 0;i<data.friends_list.length;i++)
				{
					var friendListVO:FriendInfoVo = new FriendInfoVo();
					    friendListVO.id = data.friends_list[i].id;
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
					    enemyListVO.id = data.enemies_list[i].id;
					    enemyListVO.nickname = data.enemies_list[i].nickname;
					    enemyListVO.age_level = data.enemies_list[i].age_level;
					    enemyListVO.vip_level = data.enemies_list[i].vip_level;
						enemyListVO.attack_time = data.enemies_list[i].attack_time;
						enemyListVO.attack_fort_id = data.enemies_list[i].attack_fort_id;
						enemyListVO.x = data.enemies_list[i].x;
						enemyListVO.y = data.enemies_list[i].y;
						enemyListVO.z = data.enemies_list[i].z;
						enemyListVO.is_captured = data.enemies_list[i].is_captured;
					
					    enemyList.push(enemyListVO);
				}
				enemyArr=enemyList;
			}
			if(_getFriendListCallBack != null)
				_getFriendListCallBack();
			 _getFriendListCallBack=null;
		}
	}
}