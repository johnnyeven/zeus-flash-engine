package proxy.errorProxy
{
    import com.zn.utils.XMLUtil;

    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;

    /**
     *错误
     * @author zn
     *
     */
    public class ErrorProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "ErrorProxy";

        public var errorXML:XML;

        public function ErrorProxy(data:Object = null)
        {
            super(NAME, data);
            errorXML = XMLUtil.getXML("error.xml");
        }

        /***********************************************************
         *
         * 功能方法
         *
         * ****************************************************/
        public function getErrorInfoByID(id:int):String
        {
            var xmlList:XMLList = errorXML.error.(@id == id);
            if (xmlList.length() == 0)
                return "";
            else
                return xmlList[0].toString();
        }
    }
}
