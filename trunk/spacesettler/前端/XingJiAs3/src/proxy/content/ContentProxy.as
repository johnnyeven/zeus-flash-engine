package proxy.content
{
    import com.zn.net.Protocol;
    import com.zn.net.http.HttpRequest;
    
    import enum.command.CommandEnum;
    
    import flash.net.URLRequestMethod;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import vo.viewInfo.ViewInfoVO;

    /**
     *常量信息
     * @author zn
     *
     */
    public class ContentProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "ContentProxy";

        private var _getContentInfoResultCallBack:Function;

        public var contentData:Object;
		
        public function ContentProxy(data:Object = null)
        {
            super(NAME, data);
			
			Protocol.registerProtocol(CommandEnum.getContentInfo,getContentInfoResult);
        }

		/**
		 *获取常量信息 
		 * @param callBack
		 * 
		 */
		public function getContentInfo(callBack:Function):void
		{
			_getContentInfoResultCallBack=callBack;
			ConnDebug.send(CommandEnum.getContentInfo,null,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		public function getContentInfoResult(data:*):void
		{
			contentData=data;
			
			if(_getContentInfoResultCallBack!=null)
				_getContentInfoResultCallBack();
			_getContentInfoResultCallBack=null;
		}

    /***********************************************************
     *
     * 功能方法
     *
     * ****************************************************/
		
		public function getCreateBuildInfo(type:int):ViewInfoVO
		{
			var viewInfoVO:ViewInfoVO=new ViewInfoVO();
			
			var buildLevelDic:Object=contentData.buildings[type];
			var buildObj:Object=buildLevelDic[1];
			
			viewInfoVO.time=buildObj.cost.time;
			viewInfoVO.anWuZhiXH=buildObj.cost.broken_crystal;
			viewInfoVO.chuanQinXH=buildObj.cost.tritium;
			viewInfoVO.shuiJinXH=buildObj.cost.crystal;
			
			return viewInfoVO;
		}
		
		public function getUpBuildInfo(type:int,level:int):ViewInfoVO
		{
			
			var viewInfoVO:ViewInfoVO=new ViewInfoVO();
			
			var buildLevelDic:Object=contentData.buildings[type];
			var buildObj:Object=buildLevelDic[level];
			
			viewInfoVO.limit=buildObj.conditions.academy_level;
			viewInfoVO.time=buildObj.cost.time;
			viewInfoVO.anWuZhiXH=buildObj.cost.broken_crystal;
			viewInfoVO.anWuZhiCL=buildObj.cost.broken_crystal_output;
			viewInfoVO.chuanQinXH=buildObj.cost.tritium;
			viewInfoVO.shuiJinXH=buildObj.cost.crystal;
			viewInfoVO.shuiJinCL=buildObj.property.crystal_output;
			viewInfoVO.DianNengXH=buildObj.property.power_consume;
			viewInfoVO.DianNengTG=buildObj.property.power_supply;
			viewInfoVO.shuiJinRL=buildObj.property.crystal_volume;
			viewInfoVO.chuanQinRL=buildObj.property.tritium_volume;
			viewInfoVO.chuanQinCL=buildObj.property.tritium_output;
			
			return viewInfoVO;
		}
    }
}
