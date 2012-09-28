package proxy.packageView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import vo.cangKu.WuPingInfoVO;

	/**
	 *模板
	 * @author zn
	 *
	 */
	public class PackageViewProxy extends Proxy implements IProxy
	{
		public static const NAME:String="ValueProxy";

		[Bindable]
		public var wuPingInfoVO:WuPingInfoVO;
		
		public function PackageViewProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		
		/***********************************************************
		 * 
		 * 仓库
		 * 
		 * ****************************************************/
		public function allView(id:String):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.updateInfo, packageViewResult))
				Protocol.registerProtocol(CommandEnum.updateInfo, packageViewResult);
			ConnDebug.send(CommandEnum.updateInfo,id,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function packageViewResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
			wuPingInfoVO = new WuPingInfoVO();
			wuPingInfoVO.id=data["package"].id;
			wuPingInfoVO.category=data["package"].category;
			wuPingInfoVO.enhanced=data.enhanced;
			wuPingInfoVO.type=data.type;
			wuPingInfoVO.level=data.level;
			wuPingInfoVO.value=data.value;
			wuPingInfoVO.enhanced=data.enhanced;
			wuPingInfoVO.enhanced=data.enhanced;
			wuPingInfoVO.enhanced=data.enhanced;
		}
	}
}