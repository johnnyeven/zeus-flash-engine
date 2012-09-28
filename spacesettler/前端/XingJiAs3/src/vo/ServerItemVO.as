package vo
{
    import ui.vo.ValueObject;

    /**
     *服务器对象
     * @author zn
     *
     */
    public class ServerItemVO extends ValueObject
    {
        /**
         * 服务器ID A
         */
        public var account_server_id:String;

        /**
         * 服务器名称  晨曦
         */
        public var server_name:String;

        /**
         * 服务器IP 66.148.112.175
         */
        public var server_ip:String;

        /**
         *  服务器最大注册人数 10000
         */
        public var server_max_player:int;

        /**
         * 当前已经注册的人数
         */
        public var account_count:int;

        /**
         * 服务器语言 CN
         */
        public var server_language:String;

        /**
         * 推荐服务器
         * 1:推荐
         */
        public var server_recommend:int;

        /**
         * 聊天服务器地址
         */
        public var server_message_ip:String;
		
		public var server_message_port:int;

        /**
         *游戏服务器
         */
        public var server_game_id:String;

        public var server_game_port:int;
    }
}
