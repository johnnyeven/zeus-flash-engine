package enum.command
{
	/**
	 *请求服务器返回的状态类型 
	 * @author zn
	 * 
	 */	
	public class CommandResultTypeEnum
	{
		/************************************************************************************
		 * 获取服务器列表 
		 ************************************************************************************/
		
		/**
		 * 请求成功
		 */		
		public static const SERVER_LIST_SUCCESS:String="SERVER_LIST_SUCCESS";
		
		/**
		 * 参数不完整，必须的game_id参数没有传递
		 */
		public static const SERVER_ERROR_NO_PARAM:String="SERVER_ERROR_NO_PARAM";
	}
}