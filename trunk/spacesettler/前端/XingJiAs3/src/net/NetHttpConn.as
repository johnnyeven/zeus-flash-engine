package net
{
    import com.zn.log.Log;
    import com.zn.net.Protocol;
    import com.zn.net.http.HttpRequest;

    import flash.net.URLRequestMethod;

    import mx.utils.ObjectUtil;

    import org.puremvc.as3.patterns.facade.Facade;

    public class NetHttpConn
    {
        protected static var _instance:NetHttpConn;

        public static var sendURL:String = "";

        public static function getInstance():NetHttpConn
        {
            if (_instance == null)
                _instance = new NetHttpConn();

            return _instance as NetHttpConn;
        }

        public function NetHttpConn()
        {
        }

        private function serverToClientOne(commandID:String, data:*):void
        {
            data = JSON.parse(data);
//			if (!obj.hasOwnProperty("commandID") || !obj.hasOwnProperty("type"))
//				return;

            Log.debug(NetHttpConn, "serverToClientOne", "收到信息：\n" + ObjectUtil.toString(data));

//            var type:int = obj.type;
//            if (type != 0)
//            {
//                var errorID:int = obj.errorID;
//                Facade.getInstance().sendNotification("showErrorNote", errorID);
//                return;
//            }

            //执行方法
            var callFunctionList:Vector.<Function> = Protocol.getProtocolFunctionList(commandID);
            for each (var callFun:Function in callFunctionList)
            {
                //调用方法
                callFun(data);
            }
        }

        public static function send(commandID:String, obj:Object = null, method:String = URLRequestMethod.POST):void
        {
            var params:String = "";

            if (obj)
            {
//                params = "data=" + JSON.stringify(obj);
                params = "";

                for (var key:String in obj)
                {
                    if (params != "")
                        params += "&";
                    params += key + "=" + obj[key];
                }

            }

            var httpRequest:HttpRequest = new HttpRequest(commandID, function(data:*):void
            {
                NetHttpConn.getInstance().serverToClientOne(commandID, data);
            });
            httpRequest.load(params,method);
        }

    }
}
