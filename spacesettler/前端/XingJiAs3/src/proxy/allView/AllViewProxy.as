package proxy.allView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.userInfo.UserInfoProxy;
	
	import vo.allView.AllViewVO;
	import vo.plantioid.FortsInforVO;

	/**
	 * 总览
	 * @author lw
	 *
	 */
	public class AllViewProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "AllViewProxy";
		private var _allViewCallBack:Function;
		private var _viewXingXingCallBack:Function;
		
		[Bindable]
		public var allViewVO:AllViewVO;
		
		[Bindable]
		public var myFortsList:Array = [];
		
		private var userInforProxy:UserInfoProxy;
		
		public function AllViewProxy(data:Object = null)
		{
			super(NAME,data);
			
			userInforProxy = getProxy(UserInfoProxy);
			Protocol.registerProtocol(CommandEnum.xingXing,viewXingXingResult);
		}
		
		/**
		 * 总览和荣誉
		 * @param id
		 * 
		 */		
		public function allView(callBack:Function=null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.allView, allViewResult))
			        Protocol.registerProtocol(CommandEnum.allView, allViewResult);
			//基地ID
			  var id:String = userInforProxy.userInfoVO.id;
			_allViewCallBack=callBack;
			var obj:Object = {id:id};
			ConnDebug.send(CommandEnum.allView,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function allViewResult(data:Object):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.allView, allViewResult);
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				_allViewCallBack=null;
				return ;
			}
			
			var allViewVO:AllViewVO = new AllViewVO();
			allViewVO.playerNameTxt = data.nickname;
			allViewVO.rongYuTxt = data.prestige;
			allViewVO.keJiShiDaiTxt = data.age_level;
			allViewVO.junTuanTxt = data.name
			allViewVO.startCountTxt = data.fort_count;
//			allViewVO.junXianTxt = data.
			allViewVO.junXianLvTxt = data.military_rank;
			allViewVO.jinJingCountTxt = data.base.crystal_output;
			allViewVO.chuanQiCountTxt = data.base.tritium_output;
			allViewVO.anWuZhiCountTxt = data.base.broken_crystal_output;
			allViewVO.powerCountTxt = data.base.current_power_supply;
			allViewVO.usePowerCountTxt = data.base.current_power_consume;
			
			this.allViewVO = allViewVO;
			
			if(_allViewCallBack!=null)
				_allViewCallBack();
			_allViewCallBack=null;
		}
		
		public function viewXingXing(callBack:Function = null):void
		{
			_viewXingXingCallBack = callBack;
			var playID:String = userInforProxy.userInfoVO.player_id;
			var obj:Object = {player_id:playID};
			ConnDebug.send(CommandEnum.xingXing,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function viewXingXingResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				_viewXingXingCallBack = null;
				return ;
			}
			var fortsList:Array = [];
			var arr:Array = [];
			fortsList = data.forts;
			var myFortsInforVO:FortsInforVO;
			for(var i:int = 0;i<fortsList.length;i++)
			{
				myFortsInforVO = new FortsInforVO();
				myFortsInforVO.id = fortsList[i].id;
				myFortsInforVO.level = fortsList[i].level;
				myFortsInforVO.x = fortsList[i].x;
				myFortsInforVO.y = fortsList[i].y;
				myFortsInforVO.protected_until = fortsList[i].protected_until;
				myFortsInforVO.fort_type = fortsList[i].fort_type;
				myFortsInforVO.player_id = fortsList[i].player_id;
				myFortsInforVO.fort_name = fortsList[i].fort_name;
				myFortsInforVO.resources = fortsList[i].resources;
				myFortsInforVO.age_level = fortsList[i].age_level;
				
				arr.push(myFortsInforVO);
			}
			
			myFortsList = arr;
			
			if(_viewXingXingCallBack!=null)
				_viewXingXingCallBack();
			_viewXingXingCallBack=null;
		}
	}
}