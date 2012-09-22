package net
{
    import com.zn.log.Log;
    import com.zn.net.Protocol;
    import com.zn.net.http.HttpRequest;
    
    import flash.net.URLRequestMethod;
    
    import mediator.prompt.PromptMediator;
    
    import mx.utils.ObjectUtil;
    
    import org.puremvc.as3.patterns.facade.Facade;

    public class NetHttpConn
    {
        protected static var _instance:NetHttpConn;

        public static var sendURL:String = "";

        private static var _requestCount:int=0;

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

            Log.debug(NetHttpConn, "serverToClientOne", "收到信息：\n" + ObjectUtil.toString(data));

            //执行方法
            var callFunctionList:Vector.<Function> = Protocol.getProtocolFunctionList(commandID);
            for each (var callFun:Function in callFunctionList)
            {
                //调用方法
                callFun(data);
            }
			_requestCount--;
			if(_requestCount==0)
				ApplicationFacade.getInstance().sendNotification(PromptMediator.HIDE_LOADWAITMC_NOTE);
        }

        public static function send(commandID:String, obj:Object = null, method:String = URLRequestMethod.POST):void
        {
			ApplicationFacade.getInstance().sendNotification(PromptMediator.SHOW_LOADWAITMC_NOTE);
			_requestCount++;
			
            var params:String = "";

            if (obj)
            {
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
