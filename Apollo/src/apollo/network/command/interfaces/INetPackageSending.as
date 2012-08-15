package apollo.network.command.interfaces 
{
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface INetPackageSending 
	{
		function fill(): void;
		function get urlVariables(): URLVariables;
	}
	
}