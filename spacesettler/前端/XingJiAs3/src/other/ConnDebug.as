package other
{
    import com.zn.net.http.HttpConn;
    
    import sim.SimHttpConn;

    public class ConnDebug
    {
		public static const HTTP:int=1;
		
        public static function send(commandID:int, obj:Object=null,type:int=HTTP):void
        {
			if(type==HTTP)
			{
	            if (!Main.sim)
	                HttpConn.send(commandID, obj);
	            else
	                SimHttpConn.send(commandID, obj);
			}
        }
    }
}
