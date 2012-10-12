package enum.item
{
    import com.zn.multilanguage.MultilanguageManager;

    /**
     *抗性和伤害类型
     * @author zn
     *
     */
    public class AttackTypeEnum
    {
        //1是实弹，2是激光，3是电磁，4是暗能
        public static const SHI_DAN:int = 1;

        public static const JI_GUANG:int = 2;

        public static const DIAN_CI:int = 3;

        public static const AN_NENG:int = 4;

        public static function getAttckTypeStr(type:int):String
        {
            switch (type)
            {
                case SHI_DAN:
                {
                    return MultilanguageManager.getString("guanJianShiDan");
                    break;
                }
                case DIAN_CI:
                {
                    return MultilanguageManager.getString("guanJianDianCi");
                    break;
                }
                case JI_GUANG:
                {
                    return MultilanguageManager.getString("guanJianJiguang");
                    break;
                }
                case AN_NENG:
                {
                    return MultilanguageManager.getString("guanJianAnNeng");
                    break;
                }
            }

            return "";
        }
    }
}
