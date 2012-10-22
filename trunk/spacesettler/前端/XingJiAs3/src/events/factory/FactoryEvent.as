package events.factory
{
	import flash.events.Event;
	
	import view.factory.FactoryItem_1Component;
	
	import vo.cangKu.BaseItemVO;
	
	public class FactoryEvent extends Event
	{
		
		/**
		 *关闭 
		 */		
		public static const CLOSE_EVENT:String="close_event";
		
		/**
		 *维修 
		 */		
		public static const WEIXIU_EVENT:String="weixiu_event";
		
		/**
		 *回收 
		 */		
		public static const HUISHOU_EVENT:String="huishou_event";
		
		/**
		 *制造武器 
		 */		
		public static const MAKE_WUQI_EVENT:String="make_wuqi_event";
		
		/**
		 *制造战车 
		 */		
		public static const MAKE_ZHANCHE_EVENT:String="make_zhanche_event";
		
		/**
		 *制造挂件 
		 */		
		public static const MAKE_GUAJIAN_EVENT:String="make_guajian_event";
		
		/**
		 *显示info 
		 */		
		public static const SHOW_INFO_EVENT:String="show_info_event";
		
		/**
		 *制造 
		 */		
		public static const MAKE_EVENT:String="make_event";
		
		/**
		 *加速 
		 */		
		public static const SPEEDUP_EVENT:String="speedUp_event";		
		
		/**
		 *加载战车 
		 */		
		public static const LOAD_ZHANCHE_EVENT:String="load_zhanche_event";
		
		/**
		 *加载挂件 
		 */		
		public static const LOAD_GUAJIAN_EVENT:String="load_guajian_event";
		
		/**
		 *加载战车完成
		 */		
		public static const LOAD_ZHANCHE_COMPLETE_EVENT:String="load_zhanche_complete_event";
		
		/**
		 *加载挂件完成
		 */		
		public static const LOAD_GUAJIAN_COMPLETE_EVENT:String="load_guajian_complete_event";
		
		/**
		 *强化
		 */		
		public static const QIANGHUA_EVENT:String="qianghua_event";
		
		/**
		 *交换战车
		 */		
		public static const CHANGE_ZHANCHE_EVENT:String="change_zhanche_event";
		
		/**
		 *卸载所有装备
		 */		
		public static const XIEZAI_ALL_EVENT:String="xiezai_all_event";
		
		/**
		 *卸载单个装备
		 */		
		public static const XIEZAI_EVENT:String="xiezai_event";
		
		/**
		 *查看装备
		 */		
		public static const CHAKAN_GUAJIAN_EVENT:String="chakan_guajian_event";
		
		/**
		 *更换装备
		 */		
		public static const GENHUAN_GUAJIAN_EVENT:String="genhuan_guajian_event";
		
		/**
		 *能量超过上限
		 */		
		public static const NENGLIANG_MAX_EVENT:String="genhuan_guajian_event";
		
			
		
		private var _item:FactoryItem_1Component;

		private var _type:String;
		public function FactoryEvent(type:String,item:FactoryItem_1Component=null,qiangHuatype:String=null)
		{
			super(type,false,false);
			_item=item;
			_type=qiangHuatype;
		}
		
		public function get item():FactoryItem_1Component
		{
			return _item;
		}

		public function set item(value:FactoryItem_1Component):void
		{
			_item = value;
		}

		public function get qiangHuatype():String
		{
			return _type;
		}

		public function set qiangHuatype(value:String):void
		{
			_type = value;
		}

		
	}
}