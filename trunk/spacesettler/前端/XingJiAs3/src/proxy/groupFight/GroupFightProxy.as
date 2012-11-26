package proxy.groupFight
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	import enum.groupFightEnum.GroupFightEnum;
	
	import mediator.groupFight.GroupFightComponentMediator;
	import mediator.groupFight.GroupFightMapComponentMediator;
	import mediator.groupFight.GroupFightMenuComponentMediator;
	import mediator.groupFight.GroupFightShowComponentMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.groupFight.GroupFightVo;
	import vo.groupFight.LossReportVo;
	import vo.groupFight.MyArmiesVo;
	import vo.groupFight.RewardsStarVo;
	
	public class GroupFightProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "GroupFightProxy";
		public static var isAttack:Boolean;
		
		/**
		 *行星数组 
		 */		
		public var starArr:Array=[];
				
		/**
		 * 我的行星
		 */		
		public var myStarVo:GroupFightVo;
		
		/**
		 *部署的行星数组 里面只有name 和  战舰数 
		 */		
		public var myArmiesArr:Array=[];
		
		/**
		 *损失报告
		 */		
		public var lossReportVo:LossReportVo;
		
		public var num:int;
		
		//四个有资源的星球
		public var star4001:RewardsStarVo;
		public var star4002:RewardsStarVo;
		public var star4003:RewardsStarVo;
		public var star5000:RewardsStarVo;
		
		private var callBcakFunction:Function;
		private var userProxy:UserInfoProxy;
		private var groupProxy:GroupProxy;
		public function GroupFightProxy(data:Object=null)
		{
			super(NAME, data);
			userProxy=getProxy(UserInfoProxy);
			groupProxy=getProxy(GroupProxy);
			myStarVo=new GroupFightVo();
			lossReportVo=new LossReportVo();
		}
		
		/**
		 *获取军团战地图
		 * 参数：玩家ID 
		 */		
		public function get_star_map(callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.get_star_map, getMapReputation))
				Protocol.registerProtocol(CommandEnum.get_star_map, getMapReputation);
			var obj:Object = {player_id:userProxy.userInfoVO.player_id,legion_id:userProxy.userInfoVO.legion_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.get_star_map, obj);
		}
		
		private function getMapReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.get_star_map, getMapReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			starArr.length=0;
			star4001=new RewardsStarVo();
			star4002=new RewardsStarVo();
			star4003=new RewardsStarVo();
			star5000=new RewardsStarVo();
						
			//我的行星赋值
			myStarVo=creadVo(data.my_star);
			creatMyArmiesArr(data);
			
			//所有行星的赋值
			var list:Array=[];
			var num:int=0;
			for (var index:String in data.stars)
			{
				var starVo:GroupFightVo=new GroupFightVo();
				var obj:Object=data.stars[index] as Object;
				starVo=creadVo(obj);
				starVo.index=num;
				list[num]=starVo;
				num++;
			}
			starArr=list;
			
			var str1:String=GroupFightEnum.ZIYUAN1_STAR;
			star4001.broken_crystal=data.star_rewards[str1].legion.broken_crystal;
			star4001.type=data.star_rewards[str1].legion.buffs[0].type;
			star4001.value=data.star_rewards[str1].legion.buffs[0].value;
			star4001.time=data.star_rewards[str1].legion.buffs[0].time;
			star4001.resource_type=data.star_rewards[str1].person[0].resource_type;
			star4001.count=data.star_rewards[str1].person[0].count;			
			
			var str2:String=GroupFightEnum.ZIYUAN2_STAR;
			star4002.broken_crystal=data.star_rewards[str2].legion.broken_crystal;
			star4002.type=data.star_rewards[str2].legion.buffs[0].type;
			star4002.value=data.star_rewards[str2].legion.buffs[0].value;
			star4002.time=data.star_rewards[str2].legion.buffs[0].time;
			star4002.resource_type=data.star_rewards[str2].person[0].resource_type;
			star4002.count=data.star_rewards[str2].person[0].count;			
			
			var str3:String=GroupFightEnum.ZIYUAN3_STAR;
			star4003.broken_crystal=data.star_rewards[str3].legion.broken_crystal;
			star4003.type=data.star_rewards[str3].legion.buffs[0].type;
			star4003.value=data.star_rewards[str3].legion.buffs[0].value;
			star4003.time=data.star_rewards[str3].legion.buffs[0].time;
			star4003.resource_type=data.star_rewards[str3].person[0].resource_type;
			star4003.count=data.star_rewards[str3].person[0].count;			
			
			var str4:String=GroupFightEnum.ZHU_STAR;
			star5000.dark_crystal=data.star_rewards[str4].person[0].dark_crystal;
			star5000.resource_type=data.star_rewards[str4].person[0].resource_type;
			star5000.count=data.star_rewards[str4].person[0].count;
			if(isAttack==false)
			{
				sendNotification(GroupFightComponentMediator.CHANGE_NOTE);
				sendNotification(GroupFightMenuComponentMediator.CHANGE_NOTE);
				sendNotification(GroupFightMapComponentMediator.CHANGE_NOTE);
			}
			
			
			if(callBcakFunction!=null)
				callBcakFunction();
			callBcakFunction=null;
		}
		
		private function creatMyArmiesArr(data:*):void
		{			
			myArmiesArr.length=0;
			
			var list1:Array=[];
			for (var numStr:String in data.my_armies)
			{
				var armiesVo:MyArmiesVo=new MyArmiesVo();
				armiesVo.name=numStr;
				armiesVo.warship=data.my_armies[numStr].warship;
				list1.push(armiesVo);
			}
			myArmiesArr=list1;
			
			
			
		}
		
		public function creadLinesVo(starVo:GroupFightVo):GroupFightVo
		{
			var list:Array=[];
			for(var i:int=0;i<starVo.lines.length;i++)
			{
				var stVo1:GroupFightVo=starVo.lines[i] as GroupFightVo;	
				num=0;
				for(var j:int=0;j<starArr.length;j++)
				{
					var stVo2:GroupFightVo=starArr[j] as GroupFightVo;
					if(stVo2.isMine)
						num++;
					if(stVo1.name==stVo2.name)
					{
						list.push(stVo2)						
					}
				}				
			}
			starVo.lines=list;		
			
			return starVo;
		}
		
		private function creadVo(obj:*):GroupFightVo
		{
			var starVo:GroupFightVo=new GroupFightVo();
			starVo.name=obj.name;
			starVo.type=obj.type;
			starVo.x=obj.x;
			starVo.y=obj.y;
			starVo.total_warships=obj.total_warships;
			starVo.img_name=obj.img_name;
			if(obj.refresh_time||obj.type>=4)
			{
				starVo.refresh_time=obj.refresh_time;
				starVo.initTime();
				if(obj.type==5)
				{
					star5000.time=obj.refresh_time;
					star5000.initTime();
				}
			}
			if(obj.legion_name)
				starVo.legion_name=obj.legion_name;
			var list:Array=[];
			for(var i:int=0;i<obj.lines.length;i++)
			{
				var vo1:GroupFightVo=new GroupFightVo();
				var obj1:Object=obj.lines[i] as Object;
				vo1.name=obj1.toString();				
				list.push(vo1);
			}
			starVo.lines=list;
			if(starVo.legion_name==groupProxy.groupInfoVo.groupname)
				starVo.isMine=true;
			for(var k:int=0;k<myArmiesArr.length;k++)
			{
				var armiesVo:MyArmiesVo=myArmiesArr[k] as MyArmiesVo;
				if(armiesVo.name==starVo.name)
				{
					starVo.warship=armiesVo.warship;
					starVo.isMine=true;
				}
			}
			
			if(myStarVo.name!=null)
			{
				if(starVo.name==myStarVo.name)
				{
					starVo.legion_name=myStarVo.legion_name;
//					starVo.warship=myStarVo.warship;
					starVo.isMine=true;			
					
				}
			}
			
			return starVo;
		}
		
		/**
		 *星球移动
		 * 参数：from_star_id:星球移动的源头       to_star_id:星球移动的目的星球       warship_count:派兵多少 INt
		 */		
		public function move_to_star(from_star_id:String,to_star_id:String,warship_count:int,callBcakFun:Function=null,bool:Boolean=false):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.move_to_star, moveStarReputation))
				Protocol.registerProtocol(CommandEnum.move_to_star, moveStarReputation);
			var obj:Object = {player_id:userProxy.userInfoVO.player_id,from_star_id:from_star_id ,
				to_star_id:to_star_id,warship_count:warship_count};
			callBcakFunction=callBcakFun;
			isAttack=bool;
			ConnDebug.send(CommandEnum.move_to_star, obj);
		}
		
		public function moveStarReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.move_to_star, moveStarReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			get_star_map(callBcakFunction);	
			
			if(data.battle_index)
				get_battle_result(data.battle_index,callBcakFunction);
			
			if(callBcakFunction!=null)
				callBcakFunction();
			callBcakFunction=null;
		}		

		/**
		 *星球战斗
		 * 参数：battle_index
		 */		
		public function get_battle_result(battle_index:int,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.get_battle_result, battleReputation))
				Protocol.registerProtocol(CommandEnum.get_battle_result, battleReputation);
			var obj:Object = {battle_index:battle_index};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.get_battle_result, obj);
		}	
		
		public function battleReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.get_battle_result, battleReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			lossReportVo.send_warships=data.attacker_info.send_warships;
			lossReportVo.left_warships=data.attacker_info.left_warships;
			lossReportVo.total_warships=data.attacker_info.total_warships;
			lossReportVo.lost_warships=data.attacker_info.lost_warships;
			lossReportVo.lost_warships_1=data.defender_info.lost_warships;
			lossReportVo.left_warships_1=data.defender_info.left_warships;
			lossReportVo.send_warships_1=data.defender_info.send_warships;
			
			if(data.defender_info.left_warships==0)
			{
				num+=1;				
			}
			
			if(callBcakFunction!=null)
				callBcakFunction();
			callBcakFunction=null;
		}
		
	}
}