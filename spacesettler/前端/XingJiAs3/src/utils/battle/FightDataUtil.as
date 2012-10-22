package utils.battle
{
    import com.zn.utils.DateFormatter;
    
    import proxy.battle.BattleProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import vo.GlobalData;

    /**
     *战斗数据
     * @author zn
     *
     */
    public class FightDataUtil
    {
        public static function getUseData():USER_DATA
        {
            return BattleProxy(ApplicationFacade.getProxy(BattleProxy)).userData;
        }

        /**
         *当前玩家
         * @return
         *
         */
        public static function getMyPlayer1():PLAYER1
        {
            var playerID:String = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO.player_id;
            return getPlayer1(playerID);
        }

        /**
         *获取玩家数据
         * @param playerID
         * @return
         *
         */
        public static function getPlayer1(playerID:String):PLAYER1
        {
            var userData:USER_DATA = getUseData();
            for (var i:int = 0; i < userData.player1s.length; i++)
            {
                if (userData.player1s[i].players[0].id == playerID)
                    return userData.player1s[i];
            }
            return null;
        }

        /**
         *要塞数据
         * @return
         *
         */
        public static function getFortPlayer1():PLAYER1
        {
            var userData:USER_DATA = getUseData();
            for (var i:int = 0; i < userData.player1s.length; i++)
            {
                if (userData.player1s[i].forts.length > 0)
                    return userData.player1s[i];
            }
            return null;
        }

        /**
         *我的战车
         * @return
         *
         */
        public static function getMyChariot():CHARIOT
        {
            return getMyPlayer1().chariots[0];
        }

        /**
         *可以攻击的挂件
         * @return
         *
         */
        public static function getMyCanAttackTankPart():TANKPART
        {
            var chariotVO:CHARIOT = getMyChariot();
            var tankpartVO:TANKPART;
            for (var i:int = 0; i < chariotVO.tankparts.length; i++)
            {
                tankpartVO = chariotVO.tankparts[i];
				if(tankpartVO.attackCoolEndTime==null)
					tankpartVO.attackCoolEndTime=0;
				
                if ((tankpartVO.attackCoolEndTime - DateFormatter.currentTimeM) <= 0)
                    return tankpartVO;
            }

            return null;
        }
		
		/**
		 *获取挂件 
		 * @param id
		 * @return 
		 * 
		 */
		public static function getTankPart(id:String):TANKPART
		{
			var useData:USER_DATA=getUseData();
			var player1:PLAYER1;
			var chariot:CHARIOT;
			
			for (var i:int = 0; i < useData.player1s.length; i++) 
			{
				player1=useData.player1s[i];
				for (var j:int = 0; j < player1.chariots.length; j++) 
				{
					chariot=player1.chariots[j];
					for (var k:int = 0; k < chariot.tankparts.length; k++) 
					{
						if(chariot.tankparts[k].id==id)
							return chariot.tankparts[k];
					}
					
				}
			}
			
			return null;
		}
		
		/**
		 *获取战车 
		 * @param id
		 * @return 
		 * 
		 */
		public static function getChariot(id:String):CHARIOT
		{
			var useData:USER_DATA=getUseData();
			var player1:PLAYER1;
			
			for (var i:int = 0; i < useData.player1s.length; i++) 
			{
				player1=useData.player1s[i];
				for (var j:int = 0; j < player1.chariots.length; j++) 
				{
					if(player1.chariots[j].id==id)
						return player1.chariots[j];
				}
			}
			
			return null;
		}
	}
}
