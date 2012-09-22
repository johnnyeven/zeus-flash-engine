package other
{
    import com.zn.net.http.HttpConn;
    
    import flash.net.URLRequestMethod;
    
    import mediator.prompt.PromptMediator;
    
    import net.NetHttpConn;

    public class ConnDebug
    {
		public static const HTTP:int=1;
		
        public static function send(commandID:String, obj:Object=null,type:int=HTTP,method:String=URLRequestMethod.POST):void
        {
			if(type==HTTP)
                NetHttpConn.send(commandID, obj,method);
        }
    }
}
