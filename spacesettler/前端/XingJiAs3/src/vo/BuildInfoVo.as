package vo
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    
    import flash.events.Event;
    
    import ui.vo.ValueObject;

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
        public var eventID:int;

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
				startTimeComplete=true;
			}});
        }

        public function stopTime():void
        {
            if (_timeTweenLite)
                _timeTweenLite.kill();
            _timeTweenLite = null;
        }

        public var startTimeComplete:Boolean = false;

        public function get remainTime():int
        {
            return finish_time - current_time;
        }

        public function get isBuild():Boolean
        {
            return level == 0 && eventID != 0;
        }

        public function get isUp():Boolean
        {
            return level > 0 && eventID != 0;
        }

        public function get isNormal():Boolean
        {
            return eventID == 0;
        }

        /**
         *加速建造或升级需要花费
         */
        public var speedCount:int = 2;
    }
}
