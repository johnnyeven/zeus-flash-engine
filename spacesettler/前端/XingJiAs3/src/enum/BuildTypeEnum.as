package enum
{

    public class BuildTypeEnum
    {
        public static const CENTER:int = 1;

        public static const JUNGONGCHANG:int = 2;

        public static const KEJI:int = 3;

        public static const DIANCHANG:int = 4;

        public static const CANGKU:int = 5;

        public static const KUANGCHANG:int = 6;

        public static const CHUANQIN:int = 7;

        public static const SHIJINMAC:int = 8;

        //坑位

        public static const ANCHOR_CENTER:int = 1;

        public static const ANCHOR_CHUANQI:int = 2;

        public static const ANCHOR_DIANNENG:int = 3;

        public static const ANCHOR_CANGKU:int = 4;

        public static const ANCHOR_KUANGCHANG:int = 5;

        public static const ANCHOR_KEJI:int = 6;

        public static const ANCHOR_JUNGONGCHANG:int = 7;

        public static const ANCHOR_SHIJIANMAC:int = 8;

        public static function getAnchorByType(type:int):int
        {
            switch (type)
            {
                case CENTER:
                {
                    return ANCHOR_CENTER;
                    break;
                }
				case JUNGONGCHANG:
				{
					return ANCHOR_JUNGONGCHANG;
					break;
				}
				case KEJI:
				{
					return ANCHOR_KEJI;
					break;
				}
				case DIANCHANG:
				{
					return ANCHOR_DIANNENG;
					break;
				}
				case CANGKU:
				{
					return ANCHOR_CANGKU;
					break;
				}
				case KUANGCHANG:
				{
					return ANCHOR_KUANGCHANG;
					break;
				}
				case CHUANQIN:
				{
					return ANCHOR_CHUANQI;
					break;
				}
				case SHIJINMAC:
				{
					return ANCHOR_SHIJIANMAC;
					break;
				}
            }
			
			return 0;
        }
    }
}
