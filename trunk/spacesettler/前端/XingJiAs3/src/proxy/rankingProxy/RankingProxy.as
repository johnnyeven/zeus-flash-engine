package proxy.rankingProxy
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import vo.ranking.RankingUserVo;
	import vo.ranking.RankingVo;
	
	public class RankingProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String="RankingProxy";
		
		[Bindable]
		public var rankingArr:Array=[];
		
		[Bindable]
		public var myRankingArr:Array=[];
		
		public var callBcakFunction:Function;
		
		[Bindable]
		public var rankUserVo:RankingUserVo;
		public function RankingProxy(data:Object=null)
		{
			super(NAME, data);
			
		}
		
		/**
		 *排名初始化 
		 * 
		 */		
		public function rank_info(callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.rank_info, rankInfoReputation))
				Protocol.registerProtocol(CommandEnum.rank_info, rankInfoReputation);
			var obj:Object = {};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.rank_info, obj);
		}
		
		private function rankInfoReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.rank_info, rankInfoReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			if(!rankUserVo)
				rankUserVo=new RankingUserVo();
			
			rankUserVo.forts_count_daily_rank_first=data.forts_count_daily_rank_first.nickname;
			rankUserVo.forts_count_total_rank_first=data.forts_count_total_rank_first.nickname;
			rankUserVo.forts_count_rank_updated_time=data.forts_count_rank_updated_time;
			
			rankUserVo.legion_prestige_daily_rank_first=data.legion_prestige_daily_rank_first.legion_name;
			rankUserVo.legion_prestige_total_rank_first=data.legion_prestige_total_rank_first.legion_name;
			rankUserVo.legion_prestige_rank_updated_time=data.legion_prestige_rank_updated_time;
			
			rankUserVo.orders_daily_rank_first=data.orders_daily_rank_first.nickname;
			rankUserVo.orders_total_rank_first=data.orders_total_rank_first.nickname;
			rankUserVo.orders_rank_updated_time=data.orders_rank_updated_time;
			
			rankUserVo.person_prestige_daily_rank_first=data.person_prestige_daily_rank_first.nickname;
			rankUserVo.person_prestige_total_rank_first=data.person_prestige_total_rank_first.nickname;
			rankUserVo.person_prestige_rank_updated_time=data.person_prestige_rank_updated_time;
			
			if(callBcakFunction!=null)
				callBcakFunction();
			callBcakFunction=null
			
			
			
		}
		
		/**
		 *刷新声望日榜排名接口 
		 * 
		 */		
		public function dayListReputation(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.dayListReputation, getRankingReputation))
				Protocol.registerProtocol(CommandEnum.dayListReputation, getRankingReputation);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.dayListReputation, obj);
		}
		
		/**
		 *刷新声望总榜排名接口 
		 * 
		 */		
		public function listReputation(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.listReputation, getRankingReputation))
				Protocol.registerProtocol(CommandEnum.listReputation, getRankingReputation);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.listReputation, obj);
		}
		
		/**
		 *刷新军团声望日榜排名接口 
		 * 
		 */		
		public function dayListPrestige(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.dayListPrestige, getPrestigeRuslut))
				Protocol.registerProtocol(CommandEnum.dayListPrestige, getPrestigeRuslut);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.dayListPrestige, obj);
		}
		
		/**
		 *刷新军团声望总榜排名接口 
		 * 
		 */		
		public function listPrestige(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.listPrestige, getPrestigeRuslut))
				Protocol.registerProtocol(CommandEnum.listPrestige, getPrestigeRuslut);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.listPrestige, obj);
		}
		
		/**
		 *刷新财富日榜排名接口 
		 * 
		 */		
		public function dayListWealth(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.dayListWealth, getMoneyRuslut))
				Protocol.registerProtocol(CommandEnum.dayListWealth, getMoneyRuslut);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.dayListWealth, obj);
		}
		
		/**
		 *刷新财富总榜排名接口 
		 * 
		 */		
		public function listWealth(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.listWealth, getMoneyRuslut))
				Protocol.registerProtocol(CommandEnum.listWealth, getMoneyRuslut);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.listWealth, obj);
		}
		
		/**
		 *刷新要塞日榜排名接口 
		 * 
		 */		
		public function dayListFortress(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.dayListFortress, getRankingFortress))
				Protocol.registerProtocol(CommandEnum.dayListFortress, getRankingFortress);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.dayListFortress, obj);
		}
		
		/**
		 *刷新要塞总榜排名接口 
		 * 
		 */		
		public function listFortress(playerId:String,page:int,callBcakFun:Function=null):void
		{
			if(!Protocol.registerProtocol(CommandEnum.listFortress, getRankingFortress))
				Protocol.registerProtocol(CommandEnum.listFortress, getRankingFortress);
			var obj:Object = {player_id:playerId,page:page };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.listFortress, obj);
		}
		
		//**********************************************************************下面为处理返回数据
		
		/**
		 *声望 
		 * @param data
		 * 
		 */		
		public function getRankingReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.dayListReputation, getRankingReputation);
			Protocol.deleteProtocolFunction(CommandEnum.listReputation, getRankingReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			setArr(data);
			
		}
		/**
		 *要塞接口调用返回函数 
		 * @param data
		 * 
		 */		
		public function getRankingFortress(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.dayListFortress, getRankingFortress);
			Protocol.deleteProtocolFunction(CommandEnum.listFortress, getRankingFortress);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			setArr(data);
		}
		
		/**
		 *财富接口调用返回函数 
		 * @param data
		 * 
		 */		
		public function getMoneyRuslut(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.dayListWealth, getMoneyRuslut);
			Protocol.deleteProtocolFunction(CommandEnum.listWealth, getMoneyRuslut);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			setArr(data);
		}
		
		/**
		 *军团声望接口调用返回函数 
		 * @param data
		 * 
		 */		
		public function getPrestigeRuslut(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.dayListPrestige, getPrestigeRuslut);
			Protocol.deleteProtocolFunction(CommandEnum.listPrestige, getPrestigeRuslut);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			rankingArr.length=0;
			myRankingArr.length=0;
			
			var list:Array=[];
			
			for(var i:int=0;i<data.ranks.length;i++)
			{
				var rankingVo:RankingVo=new RankingVo();
				rankingVo.id=data.ranks[i].id;
				rankingVo.nickname=data.ranks[i].name;
				rankingVo.vip_level=data.ranks[i].president_vip_level;
				rankingVo.legion_name=data.ranks[i].president;
				rankingVo.rank=data.ranks[i].rank;
				rankingVo.show=data.ranks[i].prestige;
				list.push(rankingVo);
			}
			rankingArr=list;
			if(data.my_ranks_around)
			{
				var list1:Array=[];
				for(var j:int=0;j<data.my_ranks_around.length;j++)
				{
					var rankingVo1:RankingVo=new RankingVo();
					rankingVo1.id=data.my_ranks_around[j].id;
					rankingVo1.nickname=data.my_ranks_around[j].name;
					rankingVo1.vip_level=data.my_ranks_around[j].president_vip_level;
					rankingVo1.legion_name=data.my_ranks_around[j].president;
					rankingVo1.rank=data.my_ranks_around[j].rank;
					rankingVo1.show=data.my_ranks_around[j].prestige;
					list1.push(rankingVo1);
				}
				myRankingArr=list1;
			}
			
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				rankingArr.length=0;
				myRankingArr.length=0;
			}
			callBcakFunction=null;
			
		}
		
		
		private function setArr(data:*):void
		{
			rankingArr.length=0;
			myRankingArr.length=0;
			
			var list:Array=[];
			for(var i:int=0;i<data.ranks.length;i++)
			{
				var rankingVo:RankingVo=new RankingVo();
				rankingVo.id=data.ranks[i].id;
				rankingVo.nickname=data.ranks[i].nickname;
				rankingVo.vip_level=data.ranks[i].vip_level;
				rankingVo.legion_name=data.ranks[i].legion_name;
				rankingVo.rank=data.ranks[i].rank;
				if(data.ranks[i].total_dark_crystals)
					rankingVo.show=data.ranks[i].total_dark_crystals;
				if(data.ranks[i].prestige)
					rankingVo.show=data.ranks[i].prestige;
				if(data.ranks[i].forts_count)
					rankingVo.show=data.ranks[i].forts_count;
				
				list.push(rankingVo);
			}
			rankingArr=list;
			
			var list1:Array=[];
			for(var j:int=0;j<data.my_ranks_around.length;j++)
			{
				var rankingVo1:RankingVo=new RankingVo();
				rankingVo1.id=data.my_ranks_around[j].id;
				rankingVo1.nickname=data.my_ranks_around[j].nickname;
				rankingVo1.vip_level=data.my_ranks_around[j].vip_level;
				rankingVo1.legion_name=data.my_ranks_around[j].legion_name;
				rankingVo1.rank=data.my_ranks_around[j].rank;
				if(data.my_ranks_around[j].total_dark_crystals)
					rankingVo1.show=data.my_ranks_around[j].total_dark_crystals;
				if(data.my_ranks_around[j].prestige)
					rankingVo1.show=data.my_ranks_around[j].prestige;
				if(data.my_ranks_around[j].forts_count)
					rankingVo1.show=data.my_ranks_around[j].forts_count;
					
				list1.push(rankingVo1);
			}
			myRankingArr=list1;
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				rankingArr.length=0;
				myRankingArr.length=0;
			}
			callBcakFunction=null;
			
		}
	}
}