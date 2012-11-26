package enum.friendList
{
	/**
	 *好友列表及军官证 
	 * @author lw
	 * 
	 */	
	public class FriendListCardEnum
	{
		
		public static var friendListarr:Array=[];
		
		public function FriendListCardEnum()
		{
		}
		
		/**
		 * 根据科技时代等级获取   科技时代的名称
		 */
		public static function getKeJiShiDaiNameByKeJiShiDaiLevel(keJIShiDaiLv:int):String
		{
			var name:String = "";
			switch(keJIShiDaiLv)
			{
				case 1:
				{
					name = "机械时代";
					break;
				}
				case 2:
				{
					name = "激光时代";
					break;
				}
				case 3:
				{
					name = "电磁时代";
					break;
				}
				case 4:
				{
					name = "暗能时代";
					break;
				}
			}
			return name;
		}
		
		/**
		 *根据职务等级获取职务名称 
		 * @return 
		 * 
		 */		
		public static function getZhiWuNameByZHiWULevel(level:int):String
		{
			var name:String = "";
			if(level==1)
			{
				name="军团长"
			}else if(level==2)
			{
				name="副团长"
			}else if(level==3)
			{
				name="执政官"
			}else if(level==4)
			{
				name="高级指挥官"
			}else if(level==5)
			{
				name="指挥官"
			}else if(level==6)
			{
				name="普通成员"
			}
			return name;
		}
		
		/**
		 *根据军衔等级获取军衔名称 
		 * @return 
		 * 
		 */	
		public static function  getJunXianNameByJunXianLevel(militaryRrank:int):String
		{
			var junXianName:String = "";
			switch(militaryRrank)
			{
				case 0:
				{
					junXianName="准尉";
					break;
				}
				case 1:
				{
					junXianName="少尉";
					break;
				}
				case 2:
				{
					junXianName="中尉";
					break;
				}
				case 3:
				{
					junXianName="上尉";
					break;
				}
				case 4:
				{
					junXianName="少校";
					break;
				}
				case 5:
				{
					junXianName="中校";
					break;
				}
				case 6:
				{
					junXianName="上校";
					break;
				}
				case 7:
				{
					junXianName="少将";
					break;
				}
				case 8:
				{
					junXianName="中将";
					break;
				}
				case 9:
				{
					junXianName="上将";
					break;
				}
					
			}
			return junXianName;
		}
	}
}