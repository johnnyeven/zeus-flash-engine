package vo.factory
{
	import com.zn.utils.DateFormatter;
	
	import enum.item.ItemEnum;
	
	import ui.vo.ValueObject;
	
	public class DrawListVo extends ValueObject
	{
		
		public var id:String;
		
		/**
		 *图纸类型 
		 */		
		public var recipe_type:int;
		
		/**
		 *图纸分类 
		 */		
		public var category:int;
		
		/**
		 *强化类型 
		 */		
		public var enhanced:int;
		
		/**
		 *型号 
		 */		
		public var type:int;
		
		/**
		 *挂件类型 1为武器 2为其他挂件
		 */		
		public var tank_part_type:int=0;
		
		/**
		 *开始时间 
		 */		
		public var start_time:int=0;
		
		/**
		 *结束时间 
		 */		
		public var finish_time:int=0;
		
		/**
		 *当前时间 
		 */		
		public var current_time:int=0;
		
		/**
		 *制造事件ID 
		 */		
		public var eventId:String;
		
		public var endTime:int=0;
		public var is_mounted:Boolean=false;
		
		/**
		 *制造事件ID
		 */		
		public var eventID:String=null;
		
		
		private var _item_type:String;

		public function get item_type():String
		{
			if(recipe_type==1)
			{
				_item_type=ItemEnum.Chariot;
			}else
			{
				_item_type=ItemEnum.TankPart;
			}
			
			return _item_type;
		}

		public function set item_type(value:String):void
		{
			_item_type = value;
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

		public function DrawListVo()
		{
			super();
		}
		
		public function initTime():void
		{
			endTime= DateFormatter.currentTime + (finish_time - current_time) * 1000;
		}
	}
}