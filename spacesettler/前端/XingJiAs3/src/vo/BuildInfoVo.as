package vo
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.StringUtil;
    
    import flash.events.Event;
    
    import proxy.BuildProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.vo.ValueObject;
    
    import vo.userInfo.UserInfoVO;

    [Bindable]
    public class BuildInfoVo extends ValueObject
    {
        public static const TYPE_FIELD:String = "type";

        /**
         *坑位
         */
        public var anchor:int;

        /**
         *建筑等级
         */
        public var level:int; 

        /**
         *建筑ID
         */
        public var id:String;

        /**
         *建筑类型
         */
        public var type:int;

        /**
         * 建筑事件
         */
        public var eventID:String;

        /**
         * 当前服务器时间
         */
        public var current_time:int;

        /**
         * 事件完成时间
         */
        public var finish_time:int;

        /**
         * 事件开始时间
         */
        public var start_time:int;

        /**
         *建筑事件建筑的等级
         */
        public var level_up:int;

        private var _timeTweenLite:TweenLite;

        public function startTime():void
        {
            stopTime();

            var disTime:int = remainTime;
            _timeTweenLite = TweenLite.to(this, disTime, { current_time: finish_time, ease: Linear.easeNone, onComplete: function():void
			{
				var buildProxy:BuildProxy=ApplicationFacade.getProxy(BuildProxy);
				buildProxy.updateBuilder();
			}});
        }

        public function stopTime():void
        {
            if (_timeTweenLite)
                _timeTweenLite.kill();
            _timeTweenLite = null;
        }

        public function get remainTime():int
        {
            return finish_time - current_time;
        }

        public function get isBuild():Boolean
        {
            return level == 0 && !StringUtil.isEmpty(eventID);
        }

        public function get isUp():Boolean
        {
            return level > 0 && !StringUtil.isEmpty(eventID);
        }

        public function get isNormal():Boolean
        {
            return StringUtil.isEmpty(eventID);
        }
		
		/**
		 *加速建造或升级需要花费
		 */
		  private var _speedCount:int;
		 
		public function get speedCount():int
		{
			var userInfoVo:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			
			if(level>=0&&level<10||userInfoVo.level==1)
			{
				_speedCount=2
			}else if(level>=10&&level<30||userInfoVo.level==2)
			{
				_speedCount=4
			
			}else if(level>=30&&level<40||userInfoVo.level==3)
			{
				_speedCount=8
			}
			return _speedCount;
		}
    }
}
