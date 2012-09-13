package other
{
	import com.zn.log.Log;
	
	import ui.managers.GCManager;

	public class DebugInfo
	{
		public function DebugInfo()
		{
			if(Main.debug)
			{
//				GCManager.startGcTimers();
				Log.printInfo=true;
			}
			else
			{
				Log.printInfo=false;
			}
		}
	}
}