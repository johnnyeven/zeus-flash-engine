package Apollo.Network.Command.interfaces 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface INetPackageSending 
	{
		function fill(): void;
		function get byteArray(): ByteArray;
	}
	
}