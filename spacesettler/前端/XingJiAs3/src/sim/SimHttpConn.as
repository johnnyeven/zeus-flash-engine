package sim
{
    import com.zn.net.Protocol;
    import com.zn.utils.StringUtil;
    
    import enum.CommandEnum;
    
    import org.puremvc.as3.patterns.facade.Facade;

    public class SimHttpConn
    {
        public static function serverToClient(commandID:int, data:Object = null, type:int = 0, errorID:int = 0):void
        {
            var str:String = "";
            if (data != null)
                str = JSON.stringify(data);

            var obj:Object = { commandID: commandID, type: type, errorID: errorID, data: str };
            str = JSON.stringify(obj);
            serverToClientOne(str);
        }

        private static function serverToClientOne(data:*):void
        {
            var obj:Object = JSON.parse(data);
            if (!obj.hasOwnProperty("commandID") || !obj.hasOwnProperty("type"))
                return;

            var type:int = obj.type;
            if (type != 0)
            {
                var errorID:int = obj.errorID;
                Facade.getInstance().sendNotification("showErrorNote", errorID);
                return;
            }

            var command:int = obj.commandID;
            var data:*;
            if (!StringUtil.isEmpty(obj.data))
                data = JSON.parse(obj.data);

            //执行方法
            var callFunctionList:Vector.<Function> = Protocol.getProtocolFunctionList(command);
            for each (var callFun:Function in callFunctionList)
            {
                //调用方法
                callFun(data);
            }
        }

        public static function send(commandID:int, obj:Object):void
        {
            switch (commandID)
            {
                case CommandEnum.LOGIN:
                {
                    SimLogin.login(obj);
                    break;
                }
                case CommandEnum.USER_INFO_GET:
                {
                    SimUserInfo.getUserInfo();
                    break;
                }
            }
        }
    }
}
