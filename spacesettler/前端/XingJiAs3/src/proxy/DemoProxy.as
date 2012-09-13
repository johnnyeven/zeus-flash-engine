package proxy
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 *模板
	 * @author zn
	 *
	 */
	public class DemoProxy extends Proxy implements IProxy
	{
		public static const NAME:String="ValueProxy";

		public function DemoProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		
		/***********************************************************
		 * 
		 * 功能方法
		 * 
		 * ****************************************************/
		
	}
}