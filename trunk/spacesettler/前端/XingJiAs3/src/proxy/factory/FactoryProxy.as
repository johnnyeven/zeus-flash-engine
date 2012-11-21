package proxy.factory
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import controller.task.TaskCompleteCommand;
	
	import enum.TaskEnum;
	import enum.command.CommandEnum;
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.factory.FactoryChangeComponentMediator;
	import mediator.factory.FactoryMakeAndServiceComponentMediator;
	import mediator.factory.FactoryMakeComponentMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.battle.BattleProxy;
	import proxy.packageView.PackageViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.factory.DrawListVo;
	
	public class FactoryProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FactoryProxy";
		
		[Bindable]
		public var makeListArr:Array=[];
		
		[Bindable]
		public var drawVo:DrawListVo;
		
		private var callBcakFunction:Function;
		
		private var userProxy:UserInfoProxy;
		private var pageProxy:PackageViewProxy;
		
//		public  var allZhanCheList:Array;
		public function FactoryProxy( data:Object=null)
		{
			super(NAME, data);
			drawVo=new DrawListVo();
			userProxy=getProxy(UserInfoProxy);
			pageProxy=getProxy(PackageViewProxy);
		}
		
		/**
		 *查询玩家已学会图纸
		 * 
		 */		
		public function makeList(callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.makeFactoryList, makeListReputation))
				Protocol.registerProtocol(CommandEnum.makeFactoryList, makeListReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.makeFactoryList, obj);
		}
		
		private function makeListReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.makeFactoryList, makeListReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			makeListArr.length=0;
			
			var list:Array=[];
			for(var i:int=0;i<data.recipes.length;i++)
			{
				var drawListVo:DrawListVo=new DrawListVo();
				drawListVo.id=data.recipes[i].id;
				drawListVo.category=data.recipes[i].category;
				drawListVo.enhanced=data.recipes[i].enhanced;
				drawListVo.recipe_type=data.recipes[i].recipe_type;
				drawListVo.type=data.recipes[i].type;
				if(data.recipes[i].event!=null)
				{
					drawListVo.start_time=data.recipes[i].event.start_time;
					drawListVo.finish_time=data.recipes[i].event.finish_time;
					drawListVo.current_time=data.recipes[i].event.current_time;
					drawListVo.eventID=data.recipes[i].event.id;
					drawListVo.initTime();
				}
					
					
				
				if(data.recipes[i].tank_part_type)
					drawListVo.tank_part_type=data.recipes[i].tank_part_type;
				
				list.push(drawListVo);
			}
			makeListArr=list;
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		/**
		 *开始制造
		 * 
		 */		
		public function makeStar(recipes_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.makeStar, makeStarReputation))
				Protocol.registerProtocol(CommandEnum.makeStar, makeStarReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,recipe_id:recipes_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.makeStar, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		private function makeStarReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.makeStar, makeStarReputation);
			Protocol.deleteProtocolFunction(CommandEnum.update_produce, makeStarReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			if(data.event)
			{
				drawVo.current_time=data.event.current_time;
				drawVo.start_time=data.event.start_time;
				drawVo.finish_time=data.event.finish_time;
				drawVo.initTime();
				drawVo.eventID=data.event.id;				
			}
			drawVo.id=data.id;
			drawVo.recipe_type=data.recipe_type;
			drawVo.category=data.category;
			drawVo.enhanced=data.enhanced;
			drawVo.tank_part_type=data.tank_part_type;
			
			FactoryEnum.CURRENT_DRAWVO=drawVo;
			
			userProxy.userInfoVO.broken_crysta=data.resources.broken_crystal;
			userProxy.userInfoVO.crystal=data.resources.crystal;
			userProxy.userInfoVO.tritium=data.resources.tritium;
			
			if(userProxy.userInfoVO.index==TaskEnum.index19||userProxy.userInfoVO.index==TaskEnum.index20)
			{
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			}
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
			
		}
		
		/**
		 *加速制造
		 * produce_event_id制造事件ID
		 */		
		public function produce_speed_up(produce_event_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.produce_speed_up, speedUpReputation))
				Protocol.registerProtocol(CommandEnum.produce_speed_up, speedUpReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,produce_event_id:produce_event_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.produce_speed_up, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		/**
		 *制造完成
		 * recipe_id 图纸ID
		 */		
		public function update_produce(recipe_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.update_produce, makeStarReputation))
				Protocol.registerProtocol(CommandEnum.update_produce, makeStarReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,recipe_id:recipe_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.update_produce, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		private function speedUpReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.produce_speed_up, speedUpReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			userProxy.userInfoVO.dark_crystal-=BaseItemVO.MONEY;
			
			
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		/**
		 *维修
		 * 
		 */		
		public function repair(chariot_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.repair, repairReputation))
				Protocol.registerProtocol(CommandEnum.repair, repairReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,chariot_id:chariot_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.repair, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		private function repairReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.repair, repairReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			//TODU LE:此处有错。
			userProxy.userInfoVO.broken_crysta-=FactoryEnum.CURRENT_ZHANCHE_VO.repair_cost_broken_crystal;
			
			FactoryEnum.CURRENT_ZHANCHE_VO.current_endurance=data.current_endurance;
			FactoryEnum.CURRENT_ZHANCHE_VO.total_endurance=data.total_endurance;
			FactoryEnum.CURRENT_ZHANCHE_VO.repair_cost_broken_crystal=data.repair_cost;
			
			var battleProxy:BattleProxy=getProxy(BattleProxy);
			battleProxy.getAllZhanCheList(function():void
			{
				sendNotification(FactoryMakeAndServiceComponentMediator.WEIXIU_NOTE);
			});
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		/**
		 *回收
		 * 
		 */		
		public function recycle(chariot_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.recycle, recycleReputation))
				Protocol.registerProtocol(CommandEnum.recycle, recycleReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,chariot_id:chariot_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.recycle, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		private function recycleReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.recycle, recycleReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}
			
			var battleProxy:BattleProxy=getProxy(BattleProxy);
			battleProxy.getAllZhanCheList(function():void
			{
				sendNotification(FactoryMakeAndServiceComponentMediator.HUISHOU_NOTE);
			});
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		/**
		 *强化功能
		 * 
		 */		
		public function enhance_chariot(chariot_id:String,attribute:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.enhance_chariot,enhanceReputation))
				Protocol.registerProtocol(CommandEnum.enhance_chariot, enhanceReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,chariot_id:chariot_id ,attribute:attribute};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.enhance_chariot, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		private function enhanceReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.enhance_chariot, enhanceReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}			
			
			userProxy.userInfoVO.dark_crystal-=1;
			FactoryEnum.CURRENT_ZHANCHE_VO.total_attack_speed=data.total_attack_speed;
			FactoryEnum.CURRENT_ZHANCHE_VO.total_attack_area=data.total_attack_area;
			FactoryEnum.CURRENT_ZHANCHE_VO.total_endurance=data.total_endurance;
			FactoryEnum.CURRENT_ZHANCHE_VO.total_energy=data.total_energy;
			FactoryEnum.CURRENT_ZHANCHE_VO.total_speed=data.total_speed;
			FactoryEnum.CURRENT_ZHANCHE_VO.level=data.level;
			FactoryEnum.CURRENT_ZHANCHE_VO.value=data.value;
			
			sendNotification(FactoryChangeComponentMediator.CHANGE_NOTE);
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
		/**
		 *挂载挂件		 * 
		 */		
		public function mount(chariot_id:String,tank_part_id:String, position:int,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.mount,allMountReputation))
				Protocol.registerProtocol(CommandEnum.mount, allMountReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,chariot_id:chariot_id ,tank_part_id:tank_part_id,position:position};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.mount, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		/**
		 *卸载单个挂件		 * 
		 */		
		public function unmount(chariot_id:String,tank_part_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.unmount,allMountReputation))
				Protocol.registerProtocol(CommandEnum.unmount, allMountReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,chariot_id:chariot_id ,tank_part_id:tank_part_id};
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.unmount, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		/**
		 *卸载全部挂件		 * 
		 */		
		public function unmount_all(chariot_id:String,callBcakFun:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.unmount_all,allMountReputation))
				Protocol.registerProtocol(CommandEnum.unmount_all, allMountReputation);
			
			var obj:Object = {player_id:userProxy.userInfoVO.player_id ,chariot_id:chariot_id };
			callBcakFunction=callBcakFun;
			ConnDebug.send(CommandEnum.unmount_all, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		private function allMountReputation(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.mount, allMountReputation);
			Protocol.deleteProtocolFunction(CommandEnum.unmount, allMountReputation);
			Protocol.deleteProtocolFunction(CommandEnum.unmount_all, allMountReputation);
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				callBcakFunction=null;
				return;
			}	
			
			
			var packageProxy:PackageViewProxy = getProxy(PackageViewProxy);
			var zhanCheVO:ZhanCheInfoVO;				
			zhanCheVO = packageProxy.createZhanCheVO(data);
			zhanCheVO.item_type=ItemEnum.Chariot;
			packageProxy.setZhanCheInfo(zhanCheVO, data);
			zhanCheVO.total_shield=data.total_shield;				
			FactoryEnum.CURRENT_ZHANCHE_VO=zhanCheVO;			
			sendNotification(FactoryChangeComponentMediator.CHANGE_NOTE);			
			
			if(userProxy.userInfoVO.index==TaskEnum.index21)
			{
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			}
			
			/*var battleProxy:BattleProxy=getProxy(BattleProxy);
			battleProxy.getAllZhanCheList(function():void
			{
				for(var i:int;i<battleProxy.allZhanCheList.length;i++)
				{
					var zhancheVo:ZhanCheInfoVO=battleProxy.allZhanCheList[i] as ZhanCheInfoVO;
					if(FactoryEnum.CURRENT_ZHANCHE_VO.id==zhancheVo.id)
						FactoryEnum.CURRENT_ZHANCHE_VO=zhancheVo;
				}
				sendNotification(FactoryChangeComponentMediator.CHANGE_NOTE);
			});*/
			
			
			if(callBcakFunction!=null)
			{
				callBcakFunction();
				callBcakFunction=null;
			}
		}
		
	}
}