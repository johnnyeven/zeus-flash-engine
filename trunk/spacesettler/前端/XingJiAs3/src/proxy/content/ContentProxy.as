package proxy.content
{
    import com.zn.net.Protocol;
    import com.zn.net.http.HttpRequest;
    
    import enum.BuildTypeEnum;
    import enum.command.CommandEnum;
    import enum.science.ScienceEnum;
    
    import flash.net.URLRequestMethod;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import vo.cangKu.ItemVO;
    import vo.scienceResearch.ScienceResearchVO;
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
			
			if(buildObj.conditions.all_subjects_level)
				viewInfoVO.all_subjects_level=buildObj.conditions.all_subjects_level;
			if(buildObj.conditions.academy_level)
				viewInfoVO.limit=buildObj.conditions.academy_level;
			if(buildObj.conditions.command_center_level)
				viewInfoVO.command_center_level=buildObj.conditions.command_center_level;
			
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
		/**
		 *获取科研数据 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getScienceResearchInfo(type:int,level:int):ScienceResearchVO
		{
			var scienceResearchVO:ScienceResearchVO=new ScienceResearchVO();
			scienceResearchVO.science_type=type;
			scienceResearchVO.level=level;
			
			scienceResearchVO.scienceName=ScienceEnum.getResearchNameByResearchType(scienceResearchVO.science_type);
			scienceResearchVO.scienceIconURL = ScienceEnum.getResearchIconURLByResearchType(scienceResearchVO.science_type);
			
			var scienceResearchTypeDic:Object=contentData.sciences[type];
			var obj:Object=scienceResearchTypeDic[level];
			
			scienceResearchVO.command_center_level = obj.conditions.command_center_level;
			scienceResearchVO.academy_level = obj.conditions.academy_level;
			
			scienceResearchVO.time = obj.cost.time;
			scienceResearchVO.tritium = obj.cost.tritium;
			scienceResearchVO.crystal = obj.cost.crystal;
			scienceResearchVO.broken_crystal = obj.cost.broken_crystal;
			
//			scienceResearchVO.broken_crystal = obj.property.recipe.recipe_type;
//			scienceResearchVO.broken_crystal = obj.property.recipe.category;
//			scienceResearchVO.broken_crystal = obj.property.recipe.type;
			
//			scienceResearchVO.broken_crystal = obj.property.inc_power_supply;
			
			return scienceResearchVO;
		}
    }
}
