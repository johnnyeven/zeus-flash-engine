package Apollo.Objects
{
	import Apollo.Objects.Effects.CShadow;
	import Apollo.Scene.CBaseScene;
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public interface IRender 
	{
		function get scene(): CBaseScene;
		function get rendPos(): Point;
		function get colorPan(): ColorTransform;
		function get shadow(): CShadow;
		function get isOver(): Boolean;
	}
	
}