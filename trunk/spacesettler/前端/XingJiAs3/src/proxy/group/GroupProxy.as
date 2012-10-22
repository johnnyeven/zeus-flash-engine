package proxy.group
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import mediator.prompt.PromptMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.userInfo.UserInfoProxy;
	
	import vo.group.GroupListVo;
	import vo.group.GroupMemberListVo;
	
	public class GroupProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "GroupProxy";
		
		private var callBcakFunction:Function;
		
		/**
		 *军团列表数组 
		 */		
		[Bindable]
		public var groupArr:Array=[];
		
		/**
		 *成员列表数组 
		 */		
		[Bindable]
		public var memberArr:Array=[];
		
		/**
		 *用户所在军团信息 
		 */		
		[Bindable]
		public var groupInfoVo:GroupListVo;
		
		/**
		 *审核列表 
		 */		
		[Bindable]
		public var auditArr:Array=[]
			
		private var userProxy:UserInfoProxy
		public function GroupProxy( data:Object=null)
		{
			super(NAME, data);
			groupInfoVo=new GroupListVo();
			userProxy=getProxy(UserInfoProxy);
		}
		
		/**
		 *查询玩家所在军团信息
		 * 参数：玩家ID 
		 */		
		public function refreshGroup(playerId:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.refreshGroup, refreshGroupReputation))
				Protocol.registerProtocol(CommandEnum.refreshGroup, refreshGroupReputation);
			var obj:Object = {player_id:playerId };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.refreshGroup, obj);
		}
		
		/**
		 *获取申请加入军团列表
		 * 参数：玩家ID 军团ID
		 */		
		public function groupApplyList(playerId:String,legionId:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.groupApplyList, groupApplyListReputation))
				Protocol.registerProtocol(CommandEnum.groupApplyList, groupApplyListReputation);
			var obj:Object = {player_id:playerId,legion_id:legionId };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.groupApplyList, obj);
		}
		
		/**
		 *获取军团成员列表
		 *  参数：军团ID
		 */		
		public function groupMemberList(legionId:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.groupMemberList, groupMemberListReputation))
				Protocol.registerProtocol(CommandEnum.groupMemberList, groupMemberListReputation);
			var obj:Object = {legion_id:legionId };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.groupMemberList, obj);
		}
			
		/**
		 *创建军团
		 * 参数：玩家id 军团名  军团介绍
		 */		
		public function createGroup(playerId:String,name:String,desc:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.createGroup, refreshGroupReputation))
				Protocol.registerProtocol(CommandEnum.createGroup, refreshGroupReputation);
			var obj:Object = {player_id:playerId,name:name,desc:desc };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.createGroup, obj);
		}
		
		/**
		 *允许加入军团
		 * 参数：玩家id 申请ID
		 */		
		public function allowJoinGroup(playerId:String,apply_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.allowJoinGroup, allowOrRefresJoinGroupReputation))
				Protocol.registerProtocol(CommandEnum.allowJoinGroup, allowOrRefresJoinGroupReputation);
			var obj:Object = {player_id:playerId,apply_id:apply_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.allowJoinGroup, obj);
		}
			
		/**
		 *拒绝加入军团
		 * 参数：玩家id 申请ID
		 */		
		public function refresJoinGroup(playerId:String,apply_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.refresJoinGroup, allowOrRefresJoinGroupReputation))
				Protocol.registerProtocol(CommandEnum.refresJoinGroup, allowOrRefresJoinGroupReputation);
			var obj:Object = {player_id:playerId,apply_id:apply_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.refresJoinGroup, obj);
		}
			
		/**
		 *军团管理
		 * 参数：玩家id 军团Id   可选verification是否需要审核验证0否 1 是  forbid_getting_warship是否禁止领舰队  0允许 1 禁止 desc公告
		 */		
		public function legion_manage(verification:int,forbid_getting_warship:int,desc:String=null,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.legion_manage, refreshGroupReputation))
				Protocol.registerProtocol(CommandEnum.legion_manage, refreshGroupReputation);
			var obj:Object = {player_id:userProxy.userInfoVO.player_id,legion_id:userProxy.userInfoVO.legion_id,
				verification:verification,forbid_getting_warship:forbid_getting_warship,desc:desc};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.legion_manage, obj);
		}
		
		/**
		 *军团成员管理
		 * 参数：玩家id 军团Id 0否1是  member_id成员ID  kick_member是否提出军团  member_leve设置成员职务1=军团长（表示转让军团）2=副团长3=执政官4=高级指挥官5=指挥官6=普通成员
		 * member_warship_capacity：成员可指挥战舰数
		 */		
		public function legion_member_manage(member_level:int,member_warship_capacity:int,member_id:String,kick_member:int=0,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.legion_member_manage, groupMemberListReputation))
				Protocol.registerProtocol(CommandEnum.legion_member_manage, groupMemberListReputation);
			var obj:Object = {player_id:userProxy.userInfoVO.player_id,legion_id:userProxy.userInfoVO.legion_id,
				member_id:member_id,kick_member:kick_member,member_level:member_level,member_warship_capacity:member_warship_capacity};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.legion_member_manage, obj);
		}
			
		/**
		 *申请加入军团
		 * 参数：玩家id 军团ID
		 */		
		public function applyjoinGroup(playerId:String,legion_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.applyjoinGroup, inviteOrapplyjoinGroupReputation))
				Protocol.registerProtocol(CommandEnum.applyjoinGroup, inviteOrapplyjoinGroupReputation);
			var obj:Object = {player_id:playerId,legion_id:legion_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.applyjoinGroup, obj);
		}
		
		/**
		 *退出军团
		 * 参数 军团ID 玩家ID  和查询玩家军团信息共用一个数据处理
		 */		
		public function quitGroup(playerId:String,legion_id:String,callBcakFun:Function=null):void
		{			
			if(!Protocol.hasProtocolFunction(CommandEnum.quitGroup, dissMissAndQuitGroupReputation))
				Protocol.registerProtocol(CommandEnum.quitGroup, dissMissAndQuitGroupReputation);
			var obj:Object = {player_id:playerId,legion_id:legion_id};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.quitGroup, obj);
		}
			
		/**
		 *搜索军团
		 * 参数 军团名称关键词
		 */		
		public function searchGroup(keyword:String=null,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.searchGroup, searchGroupReputation))
				Protocol.registerProtocol(CommandEnum.searchGroup, searchGroupReputation);
			var obj:Object = {keyword:keyword};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.searchGroup, obj);
		}
			
		/**
		 *建造战舰
		 * 参数 数量
		 */		
		public function produce_warship(count:int,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.produce_warship, refreshGroupReputation))
				Protocol.registerProtocol(CommandEnum.produce_warship, refreshGroupReputation);
			var obj:Object = {player_id:userProxy.userInfoVO.player_id,legion_id:userProxy.userInfoVO.legion_id,count:count};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.produce_warship, obj);
		}
		
		/**
		 *建造战舰完成
		 * 参数 无
		 */		
		public function update_produce_warship(callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.update_produce_warship, refreshGroupReputation))
				Protocol.registerProtocol(CommandEnum.update_produce_warship, refreshGroupReputation);
			var obj:Object = {player_id:userProxy.userInfoVO.player_id,legion_id:userProxy.userInfoVO.legion_id};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.update_produce_warship, obj);
		}
			
		//*****************************************************************处理数据
		//获取申请加入列表数据处理
		private function groupApplyListReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.groupApplyList, groupApplyListReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			auditArr.length=0;
			var list:Array=[];
			//TODO:  gx
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		//获取军团成员列表数据处理
		private function groupMemberListReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.groupMemberList, groupMemberListReputation);
			Protocol.deleteProtocolFunction(CommandEnum.legion_member_manage, groupMemberListReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			var list:Array=[];
			memberArr.length=0;
			for(var i:int=0;i<data.member_list.length;i++)
			{
				var memberVo:GroupMemberListVo=new GroupMemberListVo();
				memberVo.player_id=data.member_list[i].player_id;
				memberVo.controlledNum=data.member_list[i].max_warship;
				memberVo.donate_dark_matter=data.member_list[i].donate_dark_matter;
				memberVo.level=data.member_list[i].level;
				memberVo.rank=data.member_list[i].prestige_rank;
				memberVo.username=data.member_list[i].nickname;
				memberVo.vipLevel=data.member_list[i].vip_level;
				
				list.push(memberVo);
			}
			
			memberArr=list;
			
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		//获取玩家军团信息数据处理 和 创建军团
		private function refreshGroupReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.refreshGroup, refreshGroupReputation);
			Protocol.deleteProtocolFunction(CommandEnum.createGroup, refreshGroupReputation);
			Protocol.deleteProtocolFunction(CommandEnum.legion_manage, refreshGroupReputation);
			Protocol.deleteProtocolFunction(CommandEnum.update_produce_warship, refreshGroupReputation);
			Protocol.deleteProtocolFunction(CommandEnum.produce_warship, refreshGroupReputation);
			
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			groupInfoVo.current_time=data.current_time;
			groupInfoVo.broken_crystal=data.legion.broken_crystal;
			groupInfoVo.current_warship=data.legion.current_warship;
			groupInfoVo.desc=data.legion.desc;
			groupInfoVo.forbid_getting_warship=data.legion.forbid_getting_warship;
			groupInfoVo.groupname=data.legion.name;
			groupInfoVo.id=data.legion.id;
			groupInfoVo.max_warship=data.legion.max_warship;
			groupInfoVo.peopleNum=data.legion.members_count;
			groupInfoVo.rank=data.legion.prestige_rank;
			groupInfoVo.star_name=data.legion.star_name;
			groupInfoVo.username=data.legion.president;
			groupInfoVo.verification=data.legion.verification;
			groupInfoVo.vipLevel=data.legion.vip_level;
			groupInfoVo.warship=data.legion.warship;
			groupInfoVo.player_id=data.legion.player_id;
			groupInfoVo.level=data.legion.level;
			groupInfoVo.dark_crystal=data.legion.dark_crystal;
			groupInfoVo.stadonate_dark_matter=data.legion.stadonate_dark_matter;
			
			if(data.legion.event)
			{
				groupInfoVo.eventId=data.legion.event.id;
				groupInfoVo.start_time=data.legion.event.start_time;
				groupInfoVo.finish_time=data.legion.event.finish_time;
				groupInfoVo.currenttime=data.legion.event.current_time;
				groupInfoVo.count=data.legion.event.count;
				groupInfoVo.initTime();
			}
				
			var userProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userProxy.userInfoVO.legion_id=data.legion.id;
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
			
		}
		//搜索返回数据
		private function searchGroupReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.searchGroup, searchGroupReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			var list:Array=[];
			groupArr.length=0;
			var length:int=data.legions.length;
			for(var i:int=0;i<length;i++)
			{
				var grouplistvo:GroupListVo=new GroupListVo();
				
				grouplistvo.groupname=data.legions[i].legion_name;
				grouplistvo.username=data.legions[i].president;
				grouplistvo.vipLevel=data.legions[i].president_vip_level;
				grouplistvo.rank=data.legions[i].rank;
				grouplistvo.peopleNum=data.legions[i].members_count;
				grouplistvo.id=data.legions[i].id
				list.push(grouplistvo);
			}
			
			groupArr=list;
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		//同意和拒绝加入的邀请数据处理
		private function allowOrRefresJoinGroupReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.allowJoinGroup, allowOrRefresJoinGroupReputation);
			Protocol.deleteProtocolFunction(CommandEnum.refresJoinGroup, allowOrRefresJoinGroupReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
		}
		//申请和邀请加入军团 数据处理
		private function inviteOrapplyjoinGroupReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.applyjoinGroup, inviteOrapplyjoinGroupReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			var obj:Object={};
			if(data.my_apply_list)
			{				
				obj.infoLable=MultilanguageManager.getString("dengdai");
				obj.showLable=MultilanguageManager.getString("dengdaishenhe");
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
				callBcakFunction=null;
			}else
			{				
				obj.infoLable=MultilanguageManager.getString("chenggong");
				obj.showLable=MultilanguageManager.getString("jiaruchenggong");
				refreshGroupReputation(data);
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			}
		}
		//解散和退出军团 数据处理
		private function dissMissAndQuitGroupReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.quitGroup, dissMissAndQuitGroupReputation);
			
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			var userProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userProxy.userInfoVO.legion_id=null;
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
	}
}