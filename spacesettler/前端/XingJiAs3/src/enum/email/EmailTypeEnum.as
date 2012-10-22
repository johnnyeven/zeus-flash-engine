package enum.email
{
	import enum.ResEnum;

	/**
	 * 邮件类型
	 * @author lw
	 *
	 */
	public class EmailTypeEnum
	{
		/**
		 *系统邮件
		 */
		public static const SYSTEM_TYPE:int = 1;
		
		/**
		 * 军团邮件
		 */
		public static const GROUP_TYPE:int = 2;
		
		/**
		 * 个人邮件
		 */
		public static const PERSONEL_TYPE:int = 3;

		
		
		public function EmailTypeEnum()
		{
		}
		
		/**
		 * 根据邮件类型获取  头部小图标
		 */
		public static function getHeadImageByEmailType(type:int):String
		{
			var headImage:String = "";
			headImage = ResEnum.parentURL + "email/headIcon/" + type + ".png";
			return headImage;
		}
		
		/**
		 * 根据邮件类型获取  类型小图标
		 */
		public static function getTypeImageByEmailType(type:int):String
		{
			var typeImage:String = "";
			typeImage = ResEnum.parentURL + "email/typeIcon/" + type + ".png";
			return typeImage;
		}
		
		/**
		 * 根据资源类型获取   Crystal=水晶  Tritium=氢氚  BrokenCrystal=暗物质 类型小图标
		 */
		public static function getSourceImageByEmailType(type:String):String
		{
			var sourcrImage:String = "";
			sourcrImage = ResEnum.parentURL + "email/sourceImage/" + type + ".png";
			return sourcrImage;
		}
		
		/**
		 * 根据附件类型获取   recipe=图纸  item = 商品 类型小图标
		 */
		public static function getItemImageByEmailType(type:String):String
		{
			var itemImage:String = "";
			itemImage = ResEnum.parentURL + "email/equipSmallImage/" + type + ".png";
			return itemImage;
		}
		
		/**
		 * 根据附件类型和分类 获取   Chariot=战车  TankPart = 挂件  类型小图标
		 */
		public static function getEquipImageByEmailType(type:String,category:int):String
		{
			var equipImage:String = "";
			equipImage = ResEnum.parentURL + "email/equipSmallImage/" + type +"_"+ category + ".png";
			return equipImage;
		}
	}
}