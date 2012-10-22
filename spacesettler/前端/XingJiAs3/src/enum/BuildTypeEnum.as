package enum
{
    import proxy.userInfo.UserInfoProxy;

    import vo.userInfo.UserInfoVO;

    /**
     * 建造类型及与之有关的方法
     * @author lw
     *
     */
    public class BuildTypeEnum
    {

        /**
         * 基地中心
         */
        public static const CENTER:int = 1;

        /**
         * 军工厂
         */
        public static const JUNGONGCHANG:int = 2;

        /**
         * 科技中心
         */
        public static const KEJI:int = 3;

        /**
         * 暗能电厂
         */
        public static const DIANCHANG:int = 4;

        /**
         * 物质仓库
         */
        public static const CANGKU:int = 5;

        /**
         * 晶体冶炼厂
         */
        public static const KUANGCHANG:int = 6;

        /**
         * 氚氢分离厂
         */
        public static const CHUANQIN:int = 7;

        /**
         * 时间机器
         */
        public static const SHIJINMAC:int = 8;

        //坑位

        public static const ANCHOR_CENTER:int = 8;

        public static const ANCHOR_CHUANQI:int = 9;

        public static const ANCHOR_DIANNENG:int = 3;

        public static const ANCHOR_CANGKU:int = 1;

        public static const ANCHOR_KUANGCHANG:int = 2;

        public static const ANCHOR_KEJI:int = 4;

        public static const ANCHOR_JUNGONGCHANG:int = 7;

        public static const ANCHOR_SHIJIANMAC:int = 5;

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

        /**
         * 根据建筑类型获取建筑名称
         */
        public static function getBuildNameByBuildType(type:int):String
        {
            var buildName:String = "";
            switch (type)
            {
                case 1:
                {
                    buildName = "基地中心";
                    break;
                }
                case 2:
                {
                    buildName = "军工厂";
                    break;
                }
                case 3:
                {
                    buildName = "科技中心";
                    break;
                }
                case 4:
                {
                    buildName = "暗能电厂";
                    break;
                }
                case 5:
                {
                    buildName = "物质仓库";
                    break;
                }
                case 6:
                {
                    buildName = "晶体冶炼厂";
                    break;
                }
                case 7:
                {
                    buildName = "氚氢分离厂";
                    break;
                }
                case 8:
                {
                    buildName = "时间机器";
                    break;
                }

            }
            return buildName
        }


        /**
         * 根据建筑类型获取 建筑小图标
         */
        public static function getSmallImageByBuildType(type:int):String
        {
            var smallImage:String = "";
            smallImage = ResEnum.parentURL + "smallBuildIcon/" + type + ".png";
            return smallImage
        }

        /**
         * 根据建筑类型获取 建筑图标
         */
        public static function getBuildIconURLByBuildType(type:int):String
        {
            var buildIconURL:String = "";
            buildIconURL = ResEnum.parentURL + "buildIcon/" + type + ".png";
            return buildIconURL
        }

        /**
         * 根据制造类型获取 物品图标
         */
        public static function getProduceIconURLByProduceType(type:int):String
        {
            var produceIconURL:String = "";
            produceIconURL = ResEnum.parentURL + "buildIcon/" + type + ".png";
            return produceIconURL
        }

        /**
         * 根据建筑等级获取 消耗暗能水晶数
         */
        public static function getCrystalCountByBuildLevel(level:int):int
        {
            var crystalCount:int;
            var userInfoVo:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;

            if (level >= 0 && level < 10 || userInfoVo.level == 1)
            {
                crystalCount = 2
            }
            else if (level >= 10 && level < 30 || userInfoVo.level == 2)
            {
                crystalCount = 4

            }
            else if (level >= 30 && level < 40 || userInfoVo.level == 3)
            {
                crystalCount = 8
            }
            return crystalCount;
        }
    }
}
