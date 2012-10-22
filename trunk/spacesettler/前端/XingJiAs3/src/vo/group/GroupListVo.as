package vo.group
{
	import com.zn.utils.DateFormatter;
	
	import ui.vo.ValueObject;
	
	/**
	 *查询玩家所在军团的信息 和军团列表
	 * @author Administrator
	 * 
	 */	
	[Bindable]
	public class GroupListVo extends ValueObject
	{
		/**
		 *军团ID 
		 */		
		public var id:String;
		
		/**
		 *玩家ID 
		 */		
		public var player_id:String;
		
		/**
		 *排名  
		 */		
		public var rank:int;
		
		/**
		 *军团名称
		 */		
		public var groupname:String;
		
		/**
		 *军团长名称
		 */		
		public var username:String;
		
		/**
		 *军团介绍
		 */		
		public var desc:String;
		
		/**
		 *军团行星名称
		 */		
		public var star_name:String;
		
		/**
		 *军团长VIP等级 
		 */		
		public var vipLevel:int;
		
		/**
		 *军团人数
		 */		
		public var peopleNum:int;
		
		/**
		 *军团拥有战舰数 
		 */		
		public var warship:int;
		
		/**
		 *玩家当前拥有的战舰数
		 */		
		public var current_warship:int;
		
		/**
		 *最大能拥有的战舰数
		 */		
		public var max_warship:int;
		
		/**
		 *是否禁止所有人领取战舰 
		 */		
		public var forbid_getting_warship:Boolean;
		
		/**
		 *是否加入军团需要审核 
		 */		
		public var verification:Boolean;
		
		/**
		 * 当前时间
		 */		
		public var current_time:int;
		
		/**
		 *军团拥有的暗物资数量 
		 */		
		public var broken_crystal:int;
		
		/**
		 *军团拥有的暗能水晶数量 
		 */		
		public var dark_crystal:int;
		
		/**
		 *职务等级 
		 */		
		public var level:int;		
		
		/**
		 *玩家捐献的暗物质数
		 */		
		public var stadonate_dark_matter:int;
		
		/**
		 *EVENTID
		 */		
		public var eventId:String=null ;
		/**
		 *开始时间
		 */		
		public var start_time:int;
		/**
		 *结束时间
		 */		
		public var finish_time:int;
		/**
		 *当前时间
		 */		
		public var currenttime:int;
		/**
		 *制造数量
		 */		
		public var count:int;
		
		
		private var _job:String;
		public var endTime:int=0;
				
		public function GroupListVo()
		{
			super();
		}
		
		/**
		 *职务 
		 * @return 
		 * 
		 */		
		public function get job():String
		{
			if(level==1)
			{
				_job="军团长"
			}else if(level==2)
			{
				_job="副团长"
			}else if(level==3)
			{
				_job="执政官"
			}else if(level==4)
			{
				_job="高级指挥官"
			}else if(level==5)
			{
				_job="指挥官"
			}else if(level==6)
			{
				_job="普通成员"
			}
			return _job;
		}

		public function set job(value:String):void
		{
			_job = value;
		}		
		
		/**
		 *剩余时间 
		 * @return 
		 * 
		 */		
		public function get remainTime():Number
		{
			return Math.max(0,endTime-DateFormatter.currentTime);
		}
		public function initTime():void
		{
			endTime= DateFormatter.currentTime + (finish_time - currenttime) * 1000;
		}
	}
}