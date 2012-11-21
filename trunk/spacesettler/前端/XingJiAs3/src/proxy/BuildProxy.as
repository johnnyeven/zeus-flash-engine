package proxy
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    import com.zn.utils.ObjectUtil;
    
    import controller.task.TaskCommand;
    import controller.task.TaskCompleteCommand;
    
    import enum.BuildTypeEnum;
    import enum.TaskEnum;
    import enum.command.CommandEnum;
    
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
    import flash.utils.setTimeout;
    
    import mediator.prompt.PromptMediator;
    import mediator.task.taskGideComponentMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.login.LoginProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.components.Alert;
    
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
		
		private var _type:int;
		
		[Bindable]
		public  var isBuild:Boolean;

        public function BuildProxy(data:Object = null)
        {
            super(NAME, data);

            var loginProxy:LoginProxy = getProxy(LoginProxy);

            getBuildInfoResult(loginProxy.serverData);

            Protocol.registerProtocol(CommandEnum.buildBuild, buildRrsult);
			Protocol.registerProtocol(CommandEnum.speedUpBuild, buildRrsult);
			Protocol.registerProtocol(CommandEnum.upBuild, buildRrsult);
			Protocol.registerProtocol(CommandEnum.create_time_machine, buildRrsult);
			
        }

        public function getBuildInfoResult(data:Object):void
        {
			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString(data.errors));
				
				return;
			}
			
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
					else
					{
						buildInfoVo.eventID ="";
						buildInfoVo.stopTime();
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
			_type=building_type;
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
			var eventID:String=buildVO.eventID;
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
			
			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			if(userInfoProxy.userInfoVO.index==TaskEnum.index11&&_type==BuildTypeEnum.JUNGONGCHANG||
				userInfoProxy.userInfoVO.index==TaskEnum.index13)
			{
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			}
			
			isBuild=true;
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
		
		public function updateBuilder(type:int):void
		{
			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			userInfoProxy.updateInfo();
			if(userInfoProxy.userInfoVO.index==TaskEnum.index2&&_type==BuildTypeEnum.CHUANQIN||
				userInfoProxy.userInfoVO.index==TaskEnum.index3&&_type==BuildTypeEnum.DIANCHANG||
				userInfoProxy.userInfoVO.index==TaskEnum.index4&&_type==BuildTypeEnum.KUANGCHANG||
				userInfoProxy.userInfoVO.index==TaskEnum.index6&&_type==BuildTypeEnum.CANGKU||
				userInfoProxy.userInfoVO.index==TaskEnum.index10&&_type==BuildTypeEnum.KEJI)
			{
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			}
			if(userInfoProxy.userInfoVO.index==TaskEnum.index7&&type==BuildTypeEnum.CHUANQIN||
				userInfoProxy.userInfoVO.index==TaskEnum.index8&&type==BuildTypeEnum.DIANCHANG||
				userInfoProxy.userInfoVO.index==TaskEnum.index9&&type==BuildTypeEnum.KUANGCHANG||
				userInfoProxy.userInfoVO.index==TaskEnum.index22&&type==BuildTypeEnum.DIANCHANG)
			{
				sendNotification(taskGideComponentMediator.DESTROY_NOTE);
				setTimeout(sendNot,250);
			}
		}
		/**
		 *请求时间机器 
		 * @param base_id：基地ID
		 * 
		 */		
		public function create_time_machine(callFun:Function=null):void
		{
			var userInfoProxy:UserInfoProxy=getProxy(UserInfoProxy);
			var obj:Object = {base_id: userInfoProxy.userInfoVO.id };
			_buildCallBack=callFun;
			ConnDebug.send(CommandEnum.create_time_machine, obj);
		}
		
		private function sendNot():void
		{
			sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
		}
	}
}
