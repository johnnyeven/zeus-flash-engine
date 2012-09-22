package proxy
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    import com.zn.utils.ObjectUtil;
    
    import enum.BuildTypeEnum;
    import enum.command.CommandEnum;
    
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.login.LoginProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import vo.BuildInfoVo;

    public class BuildProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "BuildProxy";

        [Bindable]
        public var buildArr:Array = [];

        private var _getUserInfoCallBack:Function;

        private var _base_id:String;

        private var _building_type:int;

        private var _anchor:int;

        private var _building_id:String;

        private var _building_event_id:String;

        private var _buildCallBack:Function;

        private var _upCallBack:Function;

        public function BuildProxy(data:Object = null)
        {
            super(NAME, data);

            var loginProxy:LoginProxy = getProxy(LoginProxy);

            getBuildInfoResult(loginProxy.serverData);

			ceshiHandler();

            Protocol.registerProtocol(CommandEnum.buildBuild, buildRrsult);
			Protocol.registerProtocol(CommandEnum.speedUpBuild, buildRrsult);
			Protocol.registerProtocol(CommandEnum.upBuild, buildRrsult);
        }

        public function ceshiHandler():void
        {
            var list:Array = [];
            var buildInfoVo:BuildInfoVo = new BuildInfoVo();
            buildInfoVo.id = "1";
            buildInfoVo.type = BuildTypeEnum.KUANGCHANG;
            buildInfoVo.level = 3;
            buildInfoVo.anchor = 1;
            buildInfoVo.eventID = 1;
            buildInfoVo.current_time = 13000;
            buildInfoVo.finish_time = 13010;
            buildInfoVo.level_up = 2;
            buildInfoVo.start_time = 13000;
            list.push(buildInfoVo);

            buildArr = list;
        }

        public function getBuildInfoResult(data:Object):void
        {
            if (data.base.buildings)
            {
                var hasBuildDic:Object = ObjectUtil.CreateDic(buildArr, BuildInfoVo.TYPE_FIELD);

                var buildInfoArr:Array = data.base.buildings;
                var buildInfoVo:BuildInfoVo;
                var list:Array = [];

                for (var i:int; i < buildInfoArr.length; i++)
                {
                    buildInfoVo = hasBuildDic[buildInfoArr[i].type];
                    if (buildInfoVo == null)
                        buildInfoVo = new BuildInfoVo();

                    buildInfoVo.id = buildInfoArr[i].id;
                    buildInfoVo.type = buildInfoArr[i].type;
                    buildInfoVo.level = buildInfoArr[i].level;
                    buildInfoVo.anchor = buildInfoArr[i].anchor;
					if(buildInfoArr[i].event)
					{
	                    buildInfoVo.eventID = buildInfoArr[i].event.id;
	                    buildInfoVo.current_time = buildInfoArr[i].event.current_time;
	                    buildInfoVo.finish_time = buildInfoArr[i].event.finish_time;
	                    buildInfoVo.level_up = buildInfoArr[i].event.level;
	                    buildInfoVo.start_time = buildInfoArr[i].event.start_time;
	                    buildInfoVo.startTime();
					}
					
                    list.push(buildInfoVo);
                }

                buildArr = list;
            }
        }

        /**
         * 建造建筑
         * 需要传人 基地ID  建筑TYPE 坑位（0——1）
         */
        public function buildBuild(building_type:int, callBack:Function = null):void
        {
            _buildCallBack = callBack;
            var base_id:String = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.id;
            var anchor:int = BuildTypeEnum.getAnchorByType(building_type);

            var obj:Object = { base_id: base_id, building_type: building_type, anchor: anchor };

            ConnDebug.send(CommandEnum.buildBuild, obj);
        }

        /**
         * 升级建筑
         * 需要传人建筑ID
         */
        public function upBuild(type:int,upCallBack:Function):void
        {
			_upCallBack=upCallBack;
			var buildVO:BuildInfoVo=getBuild(type);
            var obj:Object = { building_id: buildVO.id };

            ConnDebug.send(CommandEnum.upBuild, obj);
        }

        /**
         * 加快升级
         * 建筑事件的ID
         */
        public function speedUpBuild(type:int):void
        {
			var buildVO:BuildInfoVo=getBuild(type);
			var eventID:int=buildVO.eventID;
            var obj:Object = { building_event_id:eventID };

            ConnDebug.send(CommandEnum.speedUpBuild, obj);
        }

        private function buildRrsult(data:*):void
        {
            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				_buildCallBack=null;
				_upCallBack=null;
				
                return;
            }

            getBuildInfoResult(data);
			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.updateServerData(data);
            if (_buildCallBack != null)
                _buildCallBack();
            _buildCallBack = null;
			
			if (_upCallBack != null)
				_upCallBack();
			_upCallBack = null;
			
        }

        /***********************************************************
         *
         * 功能方法
         *
         * ****************************************************/

        public function hasBuild(type:int):Boolean
        {
            return getBuild(type)==null?false:true;
        }
		
		public function getBuild(type:int):BuildInfoVo
		{
			var obj:Object = ObjectUtil.CreateDic(buildArr, BuildInfoVo.TYPE_FIELD);
			return  obj[type];
		}
    }
}
