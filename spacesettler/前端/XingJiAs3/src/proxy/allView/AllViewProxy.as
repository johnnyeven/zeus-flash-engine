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
	
	import vo.allView.AllViewVO;

	/**
	 * 总览
	 * @author lw
	 *
	 */
	public class AllViewProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "AllViewProxy";
		
		[Bindable]
		public var allViewVO:AllViewVO;
		
		public function AllViewProxy(data:Object = null)
		{
			super(NAME,data);
		}
		
		/**
		 * 总览
		 * @param id
		 * 
		 */		
		public function allView(id:String):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.allView, allViewResult))
				Protocol.registerProtocol(CommandEnum.allView, allViewResult);
			ConnDebug.send(CommandEnum.allView,id,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function allViewResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
			allViewVO = new AllViewVO();
			allViewVO.playerNameTxt = data.nickname;
			allViewVO.rongYuTxt = data.prestige;
			allViewVO.keJiShiDaiTxt = data.level;
			allViewVO.junTuanTxt = data.name
			allViewVO.startCountTxt = data.fort_count;
//			allViewVO.junXianTxt = data.
			allViewVO.junXianLvTxt = data.military_rank;
			allViewVO.jinJingCountTxt = data.crystal_output;
			allViewVO.chuanQiCountTxt = data.tritium_output;
			allViewVO.anWuZhiCountTxt = data.broken_crystal_output;
			allViewVO.powerCountTxt = data.current_power_supply;
			allViewVO.usePowerCountTxt = data.current_power_consume;
		}
	}
}