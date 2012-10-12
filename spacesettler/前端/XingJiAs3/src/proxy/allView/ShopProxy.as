package proxy.allView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.content.ContentProxy;
	import proxy.plantioid.PlantioidProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.allView.ShopInfoVo;
	import vo.allView.ShopItemVo;
	import vo.userInfo.UserInfoVO;
	
	public class ShopProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "ShopProxy";
		
		[Bindable]
		public var shopArr:Array=[];
		
		private var userInfoProxy:UserInfoProxy;
		public function ShopProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function getContentInfoResult(callFunction:Function=null):void
		{
			var contentProxy:ContentProxy=getProxy(ContentProxy);
			var list:Array=[];
			for each(var objItem:Object in contentProxy.contentData.items)
			{
				if(objItem.type)
				{
					var shopInfoVo:ShopInfoVo=new ShopInfoVo();
					shopInfoVo.name=objItem.name;
					shopInfoVo.description=objItem.description;
					shopInfoVo.dark_crystal=objItem.cost.dark_crystal;
					shopInfoVo.type=objItem.type;
					shopInfoVo.recipe_id=objItem.property.recipe_id;
					
					list.push(shopInfoVo);
				}else
				{
					var shopItemVo:ShopItemVo=new ShopItemVo();	
					shopItemVo.name=objItem.name;
					shopItemVo.description=objItem.description;
					shopItemVo.dark_crystal=objItem.cost.dark_crystal;
					shopItemVo.key=objItem.key;
					shopItemVo.time=objItem.time;
					shopItemVo.broken_crystal_inc=objItem.property.broken_crystal_inc;
					shopItemVo.crystal_inc=objItem.property.crystal_inc;
					shopItemVo.discount=objItem.property.discount;
					shopItemVo.tritium_inc=objItem.property.tritium_inc;
					
					list.push(shopItemVo);
				}
				
			}
			shopArr=list;
			if(callFunction())
			{
				callFunction();				
			}
			callFunction=null;
		}
		
		/**
		 * 购买资源
		 * 
		 */		
		public function buyResource(resource_name:String,count:int,player_id:String):void
		{
			var obj:Object = {resource_name:resource_name,count:count,player_id:player_id};
			if(!Protocol.registerProtocol(CommandEnum.buyResources, buyResourceRrsult))
				Protocol.registerProtocol(CommandEnum.buyResources, buyResourceRrsult);
			ConnDebug.send(CommandEnum.buyResources, obj);
		}
		
		/**
		 * 购买暗能水晶
		 * @return 
		 * 
		 */		
		public function buyCrystal(player_id:String,type:String):void
		{
			var obj:Object={player_id:player_id,type:type};
			if(!Protocol.registerProtocol(CommandEnum.buyCrystal, buyCrystalRrsult))
				Protocol.registerProtocol(CommandEnum.buyCrystal, buyCrystalRrsult);
			ConnDebug.send(CommandEnum.buyCrystal,obj);
		}
			
		/**
		 * 购买道具
		 * @param playerid
		 * @return 
		 * 
		 */		
		public function buyItem(playerid:String,itemtype:int,friendid:String=null):void
		{
			var obj:Object = {player_id:playerid,item_type:itemtype,friend_id:friendid};
			if(!Protocol.registerProtocol(CommandEnum.buyItem, buyItemRrsult))
				Protocol.registerProtocol(CommandEnum.buyItem, buyItemRrsult);
			ConnDebug.send(CommandEnum.buyItem, obj);
		}

		//返回数据处理
		
		private function buyResourceRrsult(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.buyResources, buyResourceRrsult);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));				
				return;
			}
			userInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.userInfoVO.broken_crysta=data.base.resources.broken_crystal;
			userInfoProxy.userInfoVO.crystal=data.base.resources.crystal;
			userInfoProxy.userInfoVO.tritium=data.base.resources.tritium;
			userInfoProxy.userInfoVO.dark_crystal=data.dark_crystal;
			
		}	
		
		private function buyItemRrsult(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.buyCrystal, buyCrystalRrsult);
			Protocol.deleteProtocolFunction(CommandEnum.buyItem, buyItemRrsult);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));				
				return;
			}
			userInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.updateInfo();
			
		}
		
		private function buyCrystalRrsult(data:*):void
		{
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));				
				return;
			}
			userInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.userInfoVO.prestige=data.prestige;
			userInfoProxy.userInfoVO.dark_crystal=data.dark_crystal;
			
		}
	}
}