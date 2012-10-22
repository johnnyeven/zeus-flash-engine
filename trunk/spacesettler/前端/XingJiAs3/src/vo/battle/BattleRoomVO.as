package vo.battle
{
    import com.zn.utils.StringUtil;
    
    import ui.vo.ValueObject;

    /**
     *战场房间信息
     * @author zn
     *
     */
    public class BattleRoomVO extends ValueObject
    {
        /**
         *分组id
         */
        public var gid:int;

        /**
         * 房间所在的大厅服务器
         */
        public var hall_server_index:int;

        /**
         * 房间类型
         */
        public var room_type:int;

        /**
         * 房间序号
         */
        public var room_index:int;

        private var _server_address_ipv4:int;

        /**
         * 端口
         */
        public var server_listen_port:int;

        /**
         * 临时通行证号码
         */
        public var passport:int;

        public var serverAddress:String;

        /**
         * 大厅服务器地址
         */
        public function get server_address_ipv4():int
        {
            return _server_address_ipv4;
        }

        /**
         * @private
         */
        public function set server_address_ipv4(value:int):void
        {
            _server_address_ipv4 = value;
			
			serverAddress=StringUtil.formatString("{3}.{2}.{1}.{0}",(value&0xFF000000)>>24,(value&0xFF0000)>>16,(value&0xFF00)>>8,value&0xFF);
        }

		/**
		 *当前时间 
		 */		
		public var room_startup:int;
		
		/**
		 *房间预计超时时间 
		 */		
		public var room_will_shutdown_at:int;
		
    }
}
