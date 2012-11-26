package utils
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.StringUtil;

	import enum.command.CommandEnum;

	import other.ConnDebug;

	import proxy.login.LoginProxy;
	import proxy.userInfo.UserInfoProxy;

	import ui.components.Label;

	import vo.GlobalData;

	public class GlobalUtil
	{
		/**
		 *改变资源
		 * @param label
		 * @param toValue
		 *
		 */
		public static function resLabelChange(label:Label, toValue:int, valve:int=1):void
		{
			TweenLite.killTweensOf(label,true);

			if (StringUtil.isEmpty(label.text))
			{
				label.text=toValue + "";
				return;
			}

			var oldNum:int=int(label.text);
			var dis:int=Math.abs(toValue - oldNum);
			if (dis >= valve)
			{
				var oldColor:Number=label.color;

				if (toValue > oldNum)
					label.color=0x00FF00;
				else
					label.color=0xFF0000;

				label.dyData=oldNum;

				TweenLite.to(label, 1.5, {dyData: toValue, ease: Linear.easeNone,
						onComplete: function():void
						{
							label.color=oldColor;
						},
						onUpdate: function():void
						{
							label.text=int(label.dyData) + "";
						}});
			}
			else
				label.text=toValue + "";
		}


		public static var userInfoProxy:UserInfoProxy;

		/**
		 *向服务器发送步骤记录
		 */
		public static function recordLog(id:int, data:String=null):void
		{
			if (StringUtil.isEmpty(CommandEnum.recordURL))
				return;

			if (!userInfoProxy)
				userInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);

			var game_id:String="B";
			//区
			var server_section:String="B";
			var server_id:String=LoginProxy.selectedServerVO.account_server_id;

			var userName:String;
			var nickName:String;

			userName=nickName="guest";

			if (userInfoProxy)
			{
				userName=userInfoProxy.userInfoVO.userName;
				nickName=userInfoProxy.userInfoVO.nickname;
			}

			var obj:Object={game_id: game_id, server_section: server_section, server_id: server_id,
					account_name: userName,
					nick_name: nickName,
					id: id, data: data};

			ConnDebug.send(CommandEnum.recordURL, obj);

		}
	}
}
