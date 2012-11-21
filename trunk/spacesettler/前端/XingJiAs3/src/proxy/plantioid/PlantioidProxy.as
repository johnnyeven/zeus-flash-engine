package proxy.plantioid
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    import com.zn.utils.ObjectUtil;
    import com.zn.utils.XMLUtil;
    
    import enum.battle.BattleBuildStateEnum;
    import enum.battle.BattleBuildTypeEnum;
    import enum.command.CommandEnum;
    
    import flash.geom.Point;
    import flash.net.URLRequestMethod;
    
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.userInfo.UserInfoProxy;
    
    import vo.battle.BattleBuildVO;
    import vo.plantioid.FortsInforVO;

    /**
     *小行星带
     * @author zn
     *
     */
    public class PlantioidProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "PlantioidProxy";

        public var editPointXML:XML;

        private var _getPlantioidListByXYCallBack:Function;

        /*
        小行星带列表
        value:FortsInforVO
        */
        [Bindable]
        public var plantioidList:Array = [];

        [Bindable]
        public var currentX:int = 0;

        [Bindable]
        public var currentY:int = 0;

		public var maxX:int=1;
		public var maxY:int=1;
		
        private var _tempPoint:Point;

        /**
         * 选择的行星
         */
        public static var selectedVO:FortsInforVO;

        private var _getPlantioidInfoCallBack:Function;

        /**
         *修建显示的需求
         */
        public var buildConentVODic:Object = {};

        private var _buildPaoTaCallBack:Function;

        private var _destroyPaoTaCallBack:Function;

		private var _contentBuildData:Object;
		
        public function PlantioidProxy(data:Object = null)
        {
            super(NAME, data);

            editPointXML = XMLUtil.getXML("battleEditPoint.xml");

            Protocol.registerProtocol(CommandEnum.getPlantioidList, getPlantioidListByXYResult);
        }

        /**
         *获取小行星带
         * @param x
         * @param y
         * @param callBack
         *
         */
        public function getPlantioidListByXY(x:int, y:int, callBack:Function = null):void
        {
            _getPlantioidListByXYCallBack = callBack;

            _tempPoint = new Point(x, y);
            var obj:Object = { x: x, y: y };
            ConnDebug.send(CommandEnum.getPlantioidList, obj, ConnDebug.HTTP, URLRequestMethod.GET);
        }

        private function getPlantioidListByXYResult(data:*):void
        {
            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
                _getPlantioidListByXYCallBack = null;
                return;
            }

            currentX = _tempPoint.x;
            currentY = _tempPoint.y;

			maxX=data.max_x;
			maxY=data.max_y;
			
            var list:Array = [];
            var obj:Object;
            var fortVO:FortsInforVO;

            for (var i:int = 0; i < data.forts.length; i++)
            {
                obj = data.forts[i];

                fortVO = new FortsInforVO();
                fortVO.id = obj.id;
                fortVO.level = obj.level;
                fortVO.z = obj.z;

                fortVO.x = currentX;
                fortVO.y = currentY;

                fortVO.current_time = data.current_time;
                fortVO.protected_until = obj.protected_until;
                fortVO.initProtectedUntil();

                fortVO.fort_type = obj.fort_type;
                fortVO.player_id = obj.player_id;
                fortVO.fort_name = obj.fort_name;
                fortVO.resources = obj.resources;
                fortVO.age_level = obj.age_level;
                fortVO.campID = obj.campID;
                fortVO.updateType();

                list.push(fortVO);
            }

            plantioidList = list;

            if (_getPlantioidListByXYCallBack != null)
                _getPlantioidListByXYCallBack();
            _getPlantioidListByXYCallBack = null;
        }

        /**
         *获取单个要塞信息
         *
         */
        public function getPlantioidInfo(plantioidID:String, callBack:Function=null):void
        {
            if (!Protocol.hasProtocolFunction(CommandEnum.getPlantioidInfo, getPlantioidInfoResult))
                Protocol.registerProtocol(CommandEnum.getPlantioidInfo, getPlantioidInfoResult);

            _getPlantioidInfoCallBack = callBack;

            var obj:Object = { fort_id: plantioidID };
            ConnDebug.send(CommandEnum.getPlantioidInfo, obj);
        }

        private function getPlantioidInfoResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.getPlantioidInfo, getPlantioidInfoResult);

            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString(data.errors));
                _getPlantioidInfoCallBack = null;
                return;
            }

			_contentBuildData=data.fort_buildings;
			
            var dic:Object = ObjectUtil.CreateDic(plantioidList, FortsInforVO.FIELD_ID);
            var itemVO:FortsInforVO = dic[data.id];
            if (itemVO)
            {
                itemVO.level = data.level;
                itemVO.x = data.x;
                itemVO.y = data.y;
                itemVO.z = data.z;
                itemVO.protected_until = data.protected_until;
                itemVO.fort_type = data.fort_type;
				itemVO.map_type =  data.map_type;
                itemVO.player_id = data.player_id;
                itemVO.fort_name = data.fort_name;
                itemVO.age_level = data.age_level;

                itemVO.updateType();

                //建筑
                itemVO.buildVOList = [];
                var buildVO:BattleBuildVO;

                dic = {};
                if (itemVO.isEdit)
                {
                    var xmlPointList:XMLList = editPointXML.point.(mapID == itemVO.mapID);
                    var length:int = xmlPointList.length();
                    for (var j:int = 0; j < length; j++)
                    {
                        buildVO = new BattleBuildVO();
                        buildVO.x = xmlPointList[j].x;
                        buildVO.y = xmlPointList[j].y;
                        buildVO.isEdit = itemVO.isEdit;
                        dic[buildVO.x + "." + buildVO.y] = buildVO;
                        itemVO.buildVOList.push(buildVO);
                    }
                }

                for (var i:int = 0; i < data.buildings.length; i++)
                {
                    buildVO = dic[data.buildings[i].x + "." + data.buildings[i].y];
                    if (!buildVO)
                    {
                        buildVO = new BattleBuildVO();
                        itemVO.buildVOList.push(buildVO);
                    }
                    setBattleContentInfo(buildVO, data.buildings[i].type);
                    buildVO.id = data.buildings[i].id;
                    buildVO.type = data.buildings[i].type;
                    buildVO.level = data.buildings[i].level;
                    buildVO.x = data.buildings[i].x;
                    buildVO.y = data.buildings[i].y;
                    buildVO.isEdit = itemVO.isEdit;
                }
            }

            //修建常量信息
            buildConentVODic = {};
            for (var type:String in data.fort_buildings)
            {
                buildVO = new BattleBuildVO();
                buildVO.type = int(type);
                setBattleContentInfo(buildVO, type);
                buildConentVODic[buildVO.type] = buildVO;
            }

            if (_getPlantioidInfoCallBack != null)
                _getPlantioidInfoCallBack();
            _getPlantioidInfoCallBack = null;
        }


        /**
         *修建要塞建筑
         * @param buildType
         * @param callBack
         *
         */
        public function buildPaoTa(buildType:int, x:Number, y:Number, callBack:Function = null):void
        {
            if (!Protocol.hasProtocolFunction(CommandEnum.buildPaoTa, buildPaoTaResult))
                Protocol.registerProtocol(CommandEnum.buildPaoTa, buildPaoTaResult);

            _buildPaoTaCallBack = callBack;

            var obj:Object = { fort_id: selectedVO.id, type: buildType, x: x, y: y };
            ConnDebug.send(CommandEnum.buildPaoTa, obj);
        }

        private function buildPaoTaResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.buildPaoTa, buildPaoTaResult);

            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
                _buildPaoTaCallBack = null;
                return;
            }

            var userProxy:UserInfoProxy = getProxy(UserInfoProxy);
            userProxy.updateInfo();

            var buildDIC:Object = ObjectUtil.CreateDic(selectedVO.buildVOList, BattleBuildVO.FIELD_XY);
            var buildVO:BattleBuildVO = buildDIC[data.x + "." + data.y];

            if (buildVO)
            {
                buildVO.id = data.id;
				setBattleContentInfo(buildVO, data.type);
                buildVO.initTime();
                buildVO.type = data.type;
                buildVO.state = BattleBuildStateEnum.build;
                buildVO.level = data.level;
            }
        }

        /**
         *强制攻打小行星
		 * fort_id:要塞ID
         * @param callBack
         *
         */
        public function break_into_fort(fort_id :String, callBack:Function = null):void
        {
            if (!Protocol.hasProtocolFunction(CommandEnum.break_into_fort, breakIntoFortResult))
                Protocol.registerProtocol(CommandEnum.break_into_fort, breakIntoFortResult);

            _destroyPaoTaCallBack = callBack;
			var userProxy:UserInfoProxy = getProxy(UserInfoProxy);

            var obj:Object = { fort_id : fort_id , player_id :userProxy.userInfoVO.player_id};
            ConnDebug.send(CommandEnum.break_into_fort, obj);
        }
		
        private function breakIntoFortResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.break_into_fort, breakIntoFortResult);

            if (data.message!="SUCCESS")
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.message));
                _destroyPaoTaCallBack = null;
                return;
            }
			
			var userProxy:UserInfoProxy = getProxy(UserInfoProxy);
			userProxy.userInfoVO.dark_crystal=data.dark_crystal;
			
			if(_destroyPaoTaCallBack!=null)
				_destroyPaoTaCallBack();
			_destroyPaoTaCallBack=null
		}
		
        /**
         *摧毁要塞建筑
         * @param buildType
         * @param callBack
         *
         */
        public function destroyPaoTa(buildID:String, callBack:Function = null):void
        {
            if (!Protocol.hasProtocolFunction(CommandEnum.destroyPaoTa, destroyPaoTaResult))
                Protocol.registerProtocol(CommandEnum.destroyPaoTa, destroyPaoTaResult);

            _destroyPaoTaCallBack = callBack;

            var obj:Object = { fort_building_id: buildID };
            ConnDebug.send(CommandEnum.destroyPaoTa, obj);
        }

        private function destroyPaoTaResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.destroyPaoTa, destroyPaoTaResult);

            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
                _destroyPaoTaCallBack = null;
                return;
            }

            var buildDIC:Object = ObjectUtil.CreateDic(selectedVO.buildVOList, BattleBuildVO.FIELD_XY);
            var buildVO:BattleBuildVO = buildDIC[data.x + "." + data.y];
            if (buildVO)
            {
                buildVO.state = BattleBuildStateEnum.normal;
                buildVO.type = BattleBuildTypeEnum.EMPTY;
            }
        }

        /***********************************************************
         *
         * 功能方法
         *
         * ****************************************************/
        public function getPlantioidVOByID(id:String):FortsInforVO
        {
            var dic:Object = ObjectUtil.CreateDic(plantioidList, FortsInforVO.FIELD_ID);
            return dic[id];
        }

        public function setSelectedPlantioid(id:String):void
        {
            selectedVO = getPlantioidVOByID(id);
        }
		
		private function setBattleContentInfo(buildVO:BattleBuildVO, type:String):void
		{
			if(_contentBuildData[type])
			{
				buildVO.time =_contentBuildData[type].cost.time;
				buildVO.crystal =_contentBuildData[type].cost.crystal;
				buildVO.tritium =_contentBuildData[type].cost.tritium;
				buildVO.broken_crystal =_contentBuildData[type].cost.broken_crystal;
				buildVO.endurance =_contentBuildData[type].property.endurance;
				buildVO.min_attack =_contentBuildData[type].property.min_attack;
				buildVO.max_attack =_contentBuildData[type].property.max_attack;
				buildVO.attack_range =_contentBuildData[type].property.attack_range;
				buildVO.attack_area =_contentBuildData[type].property.attack_area;
				buildVO.attack_type =_contentBuildData[type].property.attack_type;
				buildVO.attack_cool_down =_contentBuildData[type].property.attack_cool_down;
				buildVO.attack = (buildVO.max_attack + buildVO.min_attack) * 0.5;
			}
		}
    }
}
