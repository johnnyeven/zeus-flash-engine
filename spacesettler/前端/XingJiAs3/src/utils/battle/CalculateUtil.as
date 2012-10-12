package utils.battle
{
    import enum.item.AttackTypeEnum;
    import enum.item.SlotEnum;
    
    import vo.cangKu.GuaJianInfoVO;
    import vo.cangKu.ZhanCheInfoVO;

    /**
     *公式计算
     * @author zn
     *
     */
    public class CalculateUtil
    {
		public static function zhanChe(itemVO:ZhanCheInfoVO):void
		{
			zhanCheAttack(itemVO);
			zhanCheKangXing(itemVO);
		}
		
		
        /**
         *战车攻击力
         * @param zhanChe
         * @return
         * 武器攻击力=武器伤害/攻击速度*3*power(1.01,武器挂件伤害类型+战车时代等级)
            伤害类型：1是实弹，2是激光，3是电磁，4是暗能
            时代等级:机械=1 激光=2 电磁=3 暗能=4

         */
        public static function zhanCheAttack(itemVO:ZhanCheInfoVO):void
        {
            var total:Number = 0;
            var attack:Number;

            var guaJianVO:GuaJianInfoVO;
            for (var i:int = 0; i < itemVO.guaJianItemVOList.length; i++)
            {
                guaJianVO = itemVO.guaJianItemVOList[i];
                if (guaJianVO.slot_type == SlotEnum.BIG)
                {
                    attack = guaJianVO.attack / guaJianVO.attack_speed * 3 * Math.pow(1.01, guaJianVO.attack_type + itemVO.age_level);
                    total += attack;
                }
            }

            itemVO.attack = total;
        }

        /**
         *战车抗性
         * @param itemVO
         *
         */
        public static function zhanCheKangXing(itemVO:ZhanCheInfoVO):void
        {
            itemVO.damageDescShiDan = 0;
            itemVO.damageDescDianCi = 0;
            itemVO.damageDescJiGuang = 0;
            itemVO.damageDescAnNeng = 0;

            var guaJianVO:GuaJianInfoVO;
            for (var i:int = 0; i < itemVO.guaJianItemVOList.length; i++)
            {
                guaJianVO = itemVO.guaJianItemVOList[i];
                if (guaJianVO.slot_type == SlotEnum.MID)
                {
                    switch (guaJianVO.damage_desc_type)
                    {
                        case AttackTypeEnum.SHI_DAN:
                        {
                            itemVO.damageDescShiDan += guaJianVO.damage_desc;
                            break;
                        }
                        case AttackTypeEnum.DIAN_CI:
                        {
                            itemVO.damageDescDianCi += guaJianVO.damage_desc;
                            break;
                        }
                        case AttackTypeEnum.JI_GUANG:
                        {
                            itemVO.damageDescJiGuang += guaJianVO.damage_desc;
                            break;
                        }
                        case AttackTypeEnum.AN_NENG:
                        {
                            itemVO.damageDescAnNeng += guaJianVO.damage_desc;
                            break;
                        }
                    }
                }
            }
        }
    }
}