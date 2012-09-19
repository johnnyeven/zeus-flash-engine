package vo
{
	import flash.events.Event;
	
	import ui.vo.ValueObject;

	[Bindable]
	public class BuildInfoVo extends ValueObject
	{
		/**
		 *坑位 
		 */		
		public var anchor:int;
		
		/**
		 *建筑等级 
		 */		
		public var level:int;
		
		/**
		 *建筑ID
		 */		
		public var id:int;
		
		/**
		 *建筑类型
		 */		
		public var type:int;
		
		/**
		 * 建筑事件
		 */
		public var eventID:int=0;	
		
		/**
		 * 当前服务器时间
		 */		
		public var current_time:int;
		
		/**
		 * 事件完成时间
		 */		
		public var finish_time:int;
		
		/**
		 * 事件开始时间
		 */		
		public var start_time:int;
		
		/**
		 *建筑事件建筑的等级 
		 */		
		public var level_up:int;
		
		

	}
}