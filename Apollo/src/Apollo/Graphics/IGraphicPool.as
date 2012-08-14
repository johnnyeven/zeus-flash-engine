package Apollo.Graphics 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.text.Font;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public interface IGraphicPool extends IEventDispatcher
	{
		function init(): void;
		function addResource(resourceId: String, content: BitmapData): void;
		function getResource(domainId: String, resourceId: String): BitmapData;
		function getCharacter(resourceId: String): BitmapData;
		function getFont(resourceId: String): Font;
	}
	
}