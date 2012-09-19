package proxy
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import proxy.login.LoginProxy;
	
	import vo.BuildInfoVo;
	
	public class BuildProxy extends Proxy implements IProxy
	{		
		public static const NAME:String="BuildProxy";
		
		[Bindable]
		public var buildArr:Array=[];
		
		private var _getUserInfoCallBack:Function;		
		
		public function BuildProxy(data:Object=null)
		{
			super(NAME, data);
			
			var loginProxy:LoginProxy=getProxy(LoginProxy);
			
			getBuildInfoResult(loginProxy.serverData);
			
		}
		
		public function getBuildInfoResult(data:Object):void
		{
			if(data.buildings)
			{
				var buildInfoArr:Array=data.buildings;			
				var buildInfoVo:BuildInfoVo;
				var list:Array=[];
				 
				for(var i:int;i<buildInfoArr.length;i++)
				{
					buildInfoVo=new BuildInfoVo();
					buildInfoVo.id=buildInfoArr[i].id;
					buildInfoVo.type=buildInfoArr[i].type;
					buildInfoVo.level=buildInfoArr[i].level;
					buildInfoVo.anchor=buildInfoArr[i].anchor;
					buildInfoVo.eventID=buildInfoArr[i].event;
					buildInfoVo.current_time=buildInfoArr[i].current_time;
					buildInfoVo.finish_time=buildInfoArr[i].finish_time;
					buildInfoVo.level_up=buildInfoArr[i].level;
					buildInfoVo.start_time=buildInfoArr[i].start_time;
					list.push(buildInfoVo);
				}		
			
				buildArr=list;
			}
			
			
			 
			
		}
		
		/***********************************************************
		 * 
		 * 功能方法
		 * 
		 * ****************************************************/
	}
}