package enum.factory
{
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.factory.DrawListVo;
	
	
	public class FactoryEnum
	{
		public static const WEIXIU_FACTORY:String="weixiu_factory";
		
		public static const GAIZHUANG_FACTORY:String="gaizhuang_factory";
		
		public static const ZHIZAO_FACTORY:String="zhizao_factory";
		
		public static const MAKE_WUQI:String="make_wuqi";
		
		public static const MAKE_ZHANCHE:String="make_zhanche";
		
		public static const MAKE_GUAJIAN:String="make_guajian";
		
		/**
		 * 能量转换
		 */		
		public static const ATTACK_SPEED:String="attack_speed";
		
		/**
		 * 攻击范围
		 */		
		public static const ARRACK_AREA:String="attack_area";
		
		/**
		 * 耐久
		 */		
		public static const ENDURANCE:String="endurance";
		
		/**
		 * 能量
		 */		
		public static const ENERGY:String="energy";
		
		/**
		 * 推进力
		 */		
		public static const SPEED:String="speed";
		
		
		/**
		 *当前baseVO 
		 */		
		public static var CURRENT_VO:BaseItemVO;
		
		/**
		 *当前战车VO 
		 */		
		public static var CURRENT_ZHANCHE_VO:ZhanCheInfoVO;
		
		/**
		 *当前制造的那个战车VO 
		 */		
		public static var CURRENT_ZHIZAO_VO:ZhanCheInfoVO;
		
		/**
		 *当前挂件VO 
		 */		
		public static var CURRENT_GUAJIAN_VO:GuaJianInfoVO;
		
		/**
		 *当前挂件type
		 */		
		public static var CURRENT_TYPE:int;
		
		/**
		 *当前挂件插槽
		 */		
		public static var CURRENT_POSITION:int;
		
		/**
		 *当前图纸DrawVo
		 */		
		public static var CURRENT_DRAWVO:DrawListVo;
		
		
		
		
		public function FactoryEnum()
		{
		}
		
	}
}