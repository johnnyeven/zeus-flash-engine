package proxy.friend
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import vo.allView.FriendInfoVo;
	
	public class FriendProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FriendProxy";
		
		private var _getUserInfoCallBack:Function;
		
		[Bindable]
		public var friendArr:Array=[];
		public function FriendProxy( data:Object=null)
		{
			super(NAME, data);
		}
		
		public function getFriendInfoResult(data:Object):void
		{
			var list:Array=[];
			if(data.friends_list)
			{
				for(var i:int;i<data.friends_list.length;i++)
				{
					var friendVo:FriendInfoVo=new FriendInfoVo();
					friendVo.id=data.friends_list[i].id;
					friendVo.nickname=data.friends_list[i].nickname;
					friendVo.officer_id=data.friends_list[i].officer_id;
					friendVo.vip_level=data.friends_list[i].vip_level;
					
					list.push(friendVo);
				}
				friendArr=list;
			}
			
		}
	}
}