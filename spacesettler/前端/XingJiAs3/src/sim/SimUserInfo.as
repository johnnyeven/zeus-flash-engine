package sim
{
    import enum.CommandEnum;
    
    import sim.vo.SimUserVO;

    /**
     *用户信息
     * @author zn
     *
     */
    public class SimUserInfo
    {
        public static function getUserInfo():void
        {
			if(SimLogin.simVO.userVO==null)
			{
				var userVO:SimUserVO=new SimUserVO();
				userVO.userName = SimLogin.userName;
				userVO.level = 1;
				userVO.exp = 1;
				userVO.nextExp = 100;
				userVO.gold = 100;
				userVO.rmb = 100;
				userVO.headURL = "http://qlogo3.store.qq.com/qzone/441398/441398/30";
				
				SimLogin.simVO.userVO=userVO;
			}
			
			SimLogin.save();
            SimHttpConn.serverToClient(CommandEnum.USER_INFO_GET,SimLogin.simVO.userVO);
        }
    }
}
