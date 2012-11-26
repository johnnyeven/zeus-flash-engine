package proxy.taskGift
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.utils.DateFormatter;
	
	import enum.command.CommandEnum;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mediator.giftBag.GiftBagViewComponentMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.core.Component;
	
	import view.giftBag.GiftBagViewComponent;
	import view.giftBag.GiftDetileInfoViewComponent;
	
	import vo.giftBag.GiftBagVO;

	/**
	 *礼包
	 * @author rl
	 *
	 */
	public class GiftBagProxy extends Proxy implements IProxy
	{
		public static const NAME:String="GiftBagProxy";
		
		public var giftBagArr:Array=[];
		
		public var giftInfoArr:Array=[];

		public var giftObj:Object;
		
		private var _callBackFunction:Function;
		
		public function GiftBagProxy(data:Object=null)
		{
			super(NAME, data);
			
			Protocol.registerProtocol(CommandEnum.getRewardInfo,checkRewardResult);
			Protocol.registerProtocol(CommandEnum.getReceiveReward,receiveRewardResult);
			Protocol.registerProtocol(CommandEnum.getOnlineRewardInfo,OnlineRewardResult);
		}
		
		/**
		 *查询奖励
		 */
		public function checkReward(callBack:Function=null):void
		{
			_callBackFunction=callBack;
			
			if(!Protocol.hasProtocolFunction(CommandEnum.getRewardInfo,checkRewardResult))
				Protocol.registerProtocol(CommandEnum.getRewardInfo,checkRewardResult);
			
			var userID:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			var obj:Object={player_id:userID};
			ConnDebug.send(CommandEnum.getRewardInfo,obj);
		}
		
		private function checkRewardResult(data:Object):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.getRewardInfo,checkRewardResult);
			
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return ;
			}
			
			updata(data.rewards);
			
			if(_callBackFunction != null)
				_callBackFunction();
			_callBackFunction = null;
		}
		
		/**
		 *领取奖励
		 */
		public function receiveReward(type:int,callBack:Function):void
		{
			_callBackFunction=callBack;
			
			if(!Protocol.hasProtocolFunction(CommandEnum.getReceiveReward,receiveRewardResult))
				Protocol.registerProtocol(CommandEnum.getReceiveReward,receiveRewardResult);
			
			var userID:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			var obj:Object={player_id:userID, type:type};
			
			ConnDebug.send(CommandEnum.getReceiveReward,obj);
		}
		private function receiveRewardResult(data:Object):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.getReceiveReward,receiveRewardResult);
			
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return ;
			}
			
			var userInfoProxy:UserInfoProxy = getProxy(UserInfoProxy);
			userInfoProxy.updateInfo();
			
			updata(data.rewards);
			sendNotification(GiftBagViewComponentMediator.UPDATE_NOTE,giftBagArr);
			
			if(_callBackFunction != null)
				_callBackFunction();
			_callBackFunction = null;
		}
		
		/**
		 *在线礼包奖品查询
		 */
		public function checkOnlineReward(type:int,callBack:Function):void
		{
			_callBackFunction=callBack;
			
			if(!Protocol.hasProtocolFunction(CommandEnum.getOnlineRewardInfo,OnlineRewardResult))
				Protocol.registerProtocol(CommandEnum.getOnlineRewardInfo,OnlineRewardResult);
			
			var userID:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			var obj:Object={player_id:userID, type:type};
			
			ConnDebug.send(CommandEnum.getOnlineRewardInfo,obj);
		}
		private function OnlineRewardResult(data:Object):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.getOnlineRewardInfo,OnlineRewardResult);
			
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				return ;
			}
			
			giftObj=null;
			giftObj=data;
			
//			var comp:GiftDetileInfoViewComponent=new GiftDetileInfoViewComponent();
//			comp.updateValue(data.type,data.rewards);
			
			if(_callBackFunction != null)
				_callBackFunction();
			_callBackFunction = null;
		}
		/******************************************************
		 * 
		 * 功能方法
		 * 
		 * ****************************************************/
		private function updata(rewardArr:Array):void
		{
			giftBagArr=[];
			for(var i:int=0;i<rewardArr.length;i++)
			{
				var giftBagVO:GiftBagVO=new GiftBagVO();
				giftBagVO.begin_time=rewardArr[i].activities_time.begin_time;
				giftBagVO.countdown=rewardArr[i].activities_time.countdown;
				giftBagVO.end_time=rewardArr[i].activities_time.end_time;
				giftBagVO.dark_crystal=rewardArr[i].dark_crystal;
				giftBagVO.status=rewardArr[i].status;
				giftBagVO.type=rewardArr[i].type;
				if(rewardArr[i].broken_crystal)
					giftBagVO.broken_crystal=rewardArr[i].broken_crystal;
				if(rewardArr[i].crystal)
					giftBagVO.crystal=rewardArr[i].crystal;
				if(rewardArr[i].tritium)
					giftBagVO.tritium=rewardArr[i].tritium;
				if(rewardArr[i].days)
					giftBagVO.days=rewardArr[i].days;
				if(rewardArr[i].last_time)
					giftBagVO.last_time=rewardArr[i].last_time;
				if(rewardArr[i].level)
					giftBagVO.level=rewardArr[i].level;
				if(rewardArr[i].now_time)
					giftBagVO.now_time=rewardArr[i].now_time;
				if(rewardArr[i].item)
				{
					giftBagVO.itemList=rewardArr[i].item;
					giftBagVO.category=rewardArr[i].item[0].category;
					giftBagVO.enhanced=rewardArr[i].item[0].enhanced;
					if(rewardArr[i].item[0].r_type==1)
						giftBagVO.r_type="Chariot";
					else
						giftBagVO.r_type="TankPart";
					giftBagVO.item_type=rewardArr[i].item[0].type;
				}
				if(rewardArr[i].rank)
					giftBagVO.rank=rewardArr[i].rank;
				if(rewardArr[i].time)
					giftBagVO.time=rewardArr[i].time;
				if(rewardArr[i].consumer_count)
					giftBagVO.consumer_count=rewardArr[i].consumer_count;
				if(rewardArr[i].back)
					giftBagVO.back=rewardArr[i].back;
				
				giftBagArr.push(giftBagVO);
			}
		}
		
		public function setTime(time:Number):String
		{
			var date:Date=new Date(time*1000);
			var str:String=(date.month+1)+"."+date.date;
			
			return str;
		}
	}
}