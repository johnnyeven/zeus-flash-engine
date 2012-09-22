package events.buildEvent
{
	import flash.events.Event;
	
	public class BuildCompleteEvent extends Event
	{
		//建筑升级事件
		
		/**
		 *基地升级 
		 */		
		public static const CENTER_BUILD_UP:String="center_build_up";
		
		/**
		 *时间机器查看 
		 */		
		public static const TIMEMACHINE_BUILD_UP:String="timemachine_build_up";
		
		/**
		 *氚气升级 
		 */		
		public static const CHUANQI_BUILD_UP:String="chuanqi_build_up";
		
		/**
		 *暗能电厂升级 
		 */		
		public static const ANNEEGDIANCHANG_BUILD_UP:String="anneng_build_up";
		
		/**
		 *仓库升级 
		 */		
		public static const CANGKU_BUILD_UP:String="cangku_build_up";
		
		/**
		 *矿场升级 
		 */		
		public static const KUANGCHANG_BUILD_UP:String="kuangchuang_build_up";
		
		/**
		 *科技院升级 
		 */		
		public static const KEJI_BUILD_UP:String="keji_build_up";
		
		/**
		 *军工厂点击
		 */		
		public static const JUNGONGCHANG_BUILD_UP:String="jungongchang_build_up";
		
		//建筑建造事件
		
		
		/**
		 *氚气建造 
		 */		
		public static const CHUANQI_BUILD:String="chuanqi_build";
		
		/**
		 *暗能电厂建造 
		 */		
		public static const ANNEEGDIANCHANG_BUILD:String="anneng_build";
		
		
		/**
		 *仓库建造 
		 */		
		public static const CANGKU_BUILD:String="cangku_build";
		
		/**
		 *矿场建造	 
		 */		
		public static const KUANGCHANG_BUILD:String="kuangchuang_build";
		
		/**
		 *科技院建造 
		 */		
		public static const KEJI_BUILD:String="keji_build";
		
		/**
		 *军工厂建造 
		 */		
		public static const JUNGONGCHANG_BUILD:String="jungongchang_build";
		
		public function BuildCompleteEvent(type:String)
		{
			super(type, false,false);
		}
	}
}