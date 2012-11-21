package vo.task
{
	import ui.vo.ValueObject;
	
	/**
	 *任务
	 * @author rl
	 *
	 */
	public class TaskInfoVO extends ValueObject
	{
		/**
		 *索引
		 */
		public var index:int;
		/**
		 *是否完成
		 */
		public var is_finished:Boolean;
		/**
		 *是否领取奖励
		 */
		public var is_rewarded:Boolean;
		/**
		 *标题
		 */
		public var title:String="";
		/**
		 *任务名
		 */
		public var name:String="";
		/**
		 *暗物质
		 */
		public var broken_crystal:int;
		/**
		 *水晶
		 */
		public var crystal:int;
		/**
		 *氚氢
		 */
		public var tritium:int;
		/**
		 *暗晶
		 */
		public var dark_crystal:int;
		/**
		 *任务描述
		 */
		public var des:String="";
		/**
		 *目标
		 */
		public var goalDes:String="";
		/**
		 *完成描述
		 */
		public var completeDes:String="";
		/**
		 *指引ID数组
		 */		
		public var idArr:Array=[];
		/**
		 *type 为1 则是建筑事件 2升级事件 此时不能点击其他建筑
		 */		
		public var type:int;
		
		
		
		public function TaskInfoVO()
		{
			super();
		}
	}
}