package enum.science
{
	import enum.ResEnum;
	
	import view.buildingView.AnNengDianChangUpComponent;

	/**
	 *科技 
	 * @author zn
	 * 
	 */	
	public class ScienceEnum
	{
		/**
		 * 能源科技
		 */		
		public static const NENG_YUAN_KE_JI:int = 1;
		/**
		 * 机械科技
		 */		
		public static const JI_XIE_KE_JI:int = 2;
		/**
		 * 采集科技
		 */		
		public static const CAI_JI_KE_JI:int = 3;
		/**
		 * 激光科技
		 */		
		public static const JI_GUANG_KE_JI:int = 4;
		/**
		 *星际探索科技
		 */		
		public static const XING_JI_TAN_SUO_KE_JI:int = 5;
		/**
		 * 星域通讯科技
		 */		
		public static const XING_YU_TONG_XUN_KE_JI:int = 6;
		/**
		 * 电磁科技
		 */		
		public static const DIAN_CHI_KE_JI:int = 7;
		/**
		 *曲率引擎科技
		 */		
		public static const QU_LV_YIN_QING_KE_JI:int = 8;
		/**
		 * 纳米工程科技
		 */		
		public static const NA_MI_GONG_CHENG_KE_JI:int = 9;
		/**
		 *暗能科技
		 */		
		public static const AN_NENG_KE_JI:int = 10;
		/**
		 * 重力引导科技
		 */		
		public static const ZHONG_LI_YIN_DAO_KE_JI:int = 11;
		/**
		 * 空间射击科技
		 */		
		public static const KONG_JIAN_SHE_JI_KE_JI:int = 12;
		
		public static const MONEY:int=1;
		
		/**
		 * 根据研究类型获取 科技名称
		 */	
		public static function getResearchNameByResearchType(type:int):String
		{
			var researchName:String = "";
			switch(type)
			{
				case NENG_YUAN_KE_JI:
				{
					researchName = "能源科技";
					break;
				}
				case JI_XIE_KE_JI:
				{
					researchName = "机械科技";
					break;
				}
				case CAI_JI_KE_JI:
				{
					researchName = "采集科技";
					break;
				}
				case JI_GUANG_KE_JI:
				{
					researchName = "激光科技";
					break;
				}
				case XING_JI_TAN_SUO_KE_JI:
				{
					researchName = "星际探索科技";
					break;
				}
				case XING_YU_TONG_XUN_KE_JI:
				{
					researchName = "星域通讯科技";
					break;
				}
				case DIAN_CHI_KE_JI:
				{
					researchName = "电磁科技";
					break;
				}
				case QU_LV_YIN_QING_KE_JI:
				{
					researchName = "曲率引擎科技";
					break;
				}
				case NA_MI_GONG_CHENG_KE_JI:
				{
					researchName = "纳米工程科技";
					break;
				}
				case AN_NENG_KE_JI:
				{
					researchName = "暗能科技";
					break;
				}
				case ZHONG_LI_YIN_DAO_KE_JI:
				{
					researchName = "重力引导科技";
					break;
				}
				case KONG_JIAN_SHE_JI_KE_JI:
				{
					researchName = "空间射击科技";
					break;
				}
					
			}
			return researchName
		}
		
		/**
		 *  根据研究类型获取  科技的描述
		 */	
		public static function getInforByResearchType(type:int):String
		{
			var infor:String = "";
			switch(type)
			{
				case NENG_YUAN_KE_JI:
				{
					infor = "能源科技是提升基地、要塞的能量产出。每提升一级暗能电厂产量增加1%";
					break;
				}
				case JI_XIE_KE_JI:
				{
					infor = "机械科技是研究提升战车制造速度以及战车性能优化的科技。每提升一级机械炮塔防御增加1%";
					break;
				}
				case CAI_JI_KE_JI:
				{
					infor = "采集科技主要应用于从晶体矿当中冶炼出高纯度金晶矿，把金晶矿熔炼为暗物质，并研发新型材质制造新型战车。每提升一级金晶矿产量增加1%";
					break;
				}
				case JI_GUANG_KE_JI:
				{
					infor = "激光科技主要针对光能进行研究。从而研制出新型的激光战车、武器、炮塔等。每提升一级增加激光炮塔防御1%";
					break;
				}
				case XING_JI_TAN_SUO_KE_JI:
				{
					infor = "星际探索科技主要针对目标的要塞拥有情况、具体数量等进行分析。同而增加相应战车防御力。每提升一级增加要塞可查看数1个。";
					break;
				}
				case XING_YU_TONG_XUN_KE_JI:
				{
					infor = "星域通讯科技用于提升要塞最大拥有数以及作战指挥的执行率.每提升一级增加要塞最大拥有数至31个";
					break;
				}
				case DIAN_CHI_KE_JI:
				{
					infor = "电磁科技是利用电磁能量制造出更具攻击性的战车、炮塔等武器。每提升一级电磁炮塔攻击增加1%";
					break;
				}
				case QU_LV_YIN_QING_KE_JI:
				{
					infor = "曲率引擎科技是根据不同能量相关特性，研制出不同的战车引擎提升战车速度。每提升一级将增加运输舰在宇宙中的稳定性。";
					break;
				}
				case NA_MI_GONG_CHENG_KE_JI:
				{
					infor = "纳米工程科技是提升要塞建筑建造效率、质量、提升战车防御值。每提升一级建筑、战车质量将有所提升。";
					break;
				}
				case AN_NENG_KE_JI:
				{
					infor = "暗能科技主要是研究战车、炮塔等武器的暗能量攻击，提升暗能攻击的学科。每提升一级暗能炮塔攻击提升1%";
					break;
				}
				case ZHONG_LI_YIN_DAO_KE_JI:
				{
					infor = "重力引导科技主要是研究如何增加战车本身防御、减少战车磨损。每提升一级降低战斗中战车磨损。";
					break;
				}
				case KONG_JIAN_SHE_JI_KE_JI:
				{
					infor = "空间射击科技主要用于武器挂件的研制等级越高所研制的挂件等级及副加功能越高。每提升一级将提升武器精准度、有效射程。";
					break;
				}
					
			}
			return infor;
		}
		
		/**
		 * 根据研究类型获取 科技图标
		 */	
		public static function getResearchIconURLByResearchType(type:int):String
		{
			var researchIconURL:String = "";
			researchIconURL = ResEnum.parentURL+"scienceIcon/"+type+".png";
			return researchIconURL
		}
	}
}