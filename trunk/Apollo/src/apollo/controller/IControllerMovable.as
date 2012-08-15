package apollo.controller 
{
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface IControllerMovable 
	{
		function moveTo(x: Number, y: Number): void;
		function moveKeepDistance(x: Number, y: Number, distance: Number = -1): void
	}
	
}