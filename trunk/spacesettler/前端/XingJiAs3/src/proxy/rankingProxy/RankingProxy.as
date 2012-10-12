package proxy.rankingProxy
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import vo.ranking.RankingVo;
	
	public class RankingProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String="RankingProxy";
		
		[Bindable]
		public var rankingArr:Array=[];
		
		[Bindable]
		public var myRankingArr:Array=[];
		
		public var callBcakFunction:Function;
		public function RankingProxy(data:Object=null)
		{
			super(NAME, data);
			
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
		
		
		private function setArr(data:*):void
		{
			rankingArr.length=0;
			myRankingArr.length=0;
			
			var list:Array=[];
			for(var i:int;i<data.ranks.length;i++)
			{
				var rankingVo:RankingVo=new RankingVo();
				rankingVo.id=data.ranks[i].id;
				rankingVo.nickname=data.ranks[i].nickname;
				rankingVo.vip_level=data.ranks[i].vip_level;
				rankingVo.legion_name=data.ranks[i].legion_name;
				rankingVo.rank=data.ranks[i].rank;
				rankingVo.show=data.ranks[i].prestige;
				list.push(rankingVo);
			}
			rankingArr=list;
			
			var list1:Array=[];
			for(var j:int;j<data.my_ranks_around.length;j++)
			{
				var rankingVo1:RankingVo=new RankingVo();
				rankingVo1.id=data.my_ranks_around[j].id;
				rankingVo1.nickname=data.my_ranks_around[j].nickname;
				rankingVo1.vip_level=data.my_ranks_around[j].vip_level;
				rankingVo1.legion_name=data.my_ranks_around[j].legion_name;
				rankingVo1.rank=data.my_ranks_around[j].rank;
				rankingVo1.show=data.my_ranks_around[j].prestige;
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