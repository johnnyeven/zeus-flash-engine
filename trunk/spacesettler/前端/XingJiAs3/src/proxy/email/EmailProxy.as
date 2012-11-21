package proxy.email
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.command.CommandEnum;
	import enum.item.ItemEnum;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mediator.email.ViewEmailComponentMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.prompt.PromptMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.packageView.PackageViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.email.EmailItemVO;
	
	/**
	 *邮件
	 * @author lw
	 *
	 */
	public class EmailProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "EmailProxy";
		[Bindable]
		public var emailList:Array = [];
		
		[Bindable]
		public var emailCount:int;
		private var _getEmailListCallBack:Function;
		//定时刷邮件列表，看看是否有新邮件。
		private var timer:Timer = new Timer(30000);
		//当前邮件条数
		private var emailCurrentCount:int = emailList.length;
		private var userInforProxy:UserInfoProxy;
		private var packageViewProxy:PackageViewProxy;
		public function EmailProxy(data:Object=null)
		{
			super(NAME, data);
			userInforProxy = getProxy(UserInfoProxy);
			packageViewProxy = getProxy(PackageViewProxy);
			Protocol.registerProtocol(CommandEnum.emailList,getEmailListResult);
			Protocol.registerProtocol(CommandEnum.sendEmail,sendEmailResult);
			Protocol.registerProtocol(CommandEnum.isRead,isReadResult);
			Protocol.registerProtocol(CommandEnum.deleteEmail,deleteEmailResult);
			Protocol.registerProtocol(CommandEnum.receiveEmailSource,getSourceResult);
			timer.addEventListener(TimerEvent.TIMER,timer_handler);
//			timer.start();
		}
		
		private function timer_handler(event:TimerEvent):void
		{
			getEmailList();
		}
		
		/**
		 * 获取邮件列表
		 * @param callBack
		 * 
		 */		
		public function getEmailList(callBack:Function=null):void
		{
			_getEmailListCallBack = callBack;
			var playerID:String = userInforProxy.userInfoVO.player_id;
			var pageCount:int = 0;
			var obj:Object = {player_id:playerID,page:pageCount};
			ConnDebug.send(CommandEnum.emailList,obj);
		}
		
		private function getEmailListResult(data:Object):void
		{
			if(data)
			{
				var arr:Array = [];
				var emailArr:Array = [];
				var emailItemVO:EmailItemVO;
				arr = data.mails;
				if(emailCurrentCount<arr.length)
				{
				   //向外发送新邮件提示消息
			       sendNotification(MainViewMediator.SHOW_NEW_EMAIL_TIPS_NOTE);
				}
				emailCount = arr.length;
				emailCurrentCount = emailCount;
				for(var i:int = 0;i<arr.length;i++)
				{
					emailItemVO = new EmailItemVO();
					
					emailItemVO.mails_count = emailCount;
					emailItemVO.id = arr[i].id;
					emailItemVO.created_at = arr[i].created_at;
					emailItemVO.type = arr[i].type;
					emailItemVO.sender = arr[i].sender;
					emailItemVO.receiver = arr[i].receiver;
					emailItemVO.title = arr[i].title;
					emailItemVO.content = arr[i].content;
					emailItemVO.is_read = arr[i].is_read;
					emailItemVO.attachment = arr[i].attachment;
					if(emailItemVO.attachment)
					{
						emailItemVO.attachment_type = arr[i].attachment.attachment_type;
						emailItemVO.category = arr[i].attachment.category;
						emailItemVO.attachment_id = arr[i].attachment.attachment_id;
						emailItemVO.attachment_count = arr[i].attachment.attachment_count;
						emailItemVO.receive_attachment = arr[i].attachment.receive_attachment;
					}
					emailArr.push(emailItemVO);
				}
				
				emailList = emailArr;
				
				if(_getEmailListCallBack != null)
					_getEmailListCallBack();
				_getEmailListCallBack = null;
			}
		}
		/**
		 *发送邮件 
		 * 
		 */		
		public function sendEmail(obj:Object):void
		{
			/*if(obj.attachment_type == ItemEnum.Chariot)
			{
				//转换类型
				obj.attachment_type = ItemEnum.chariot;
			}
			else if(obj.attachment_type == ItemEnum.TankPart)
			{
				obj.attachment_type = ItemEnum.tankPart;
			}*/
			ConnDebug.send(CommandEnum.sendEmail,obj);
		}
		
		private function sendEmailResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			if(data.message == "success")
			{
				var obj:Object = {infoLable:MultilanguageManager.getString("successSendEmailTitle"),showLable:MultilanguageManager.getString("successSendEmailInfor")};
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
				//更新服务器数据
				userInforProxy.updateServerData();
				//更新背包数据
				packageViewProxy.packageViewView();
			}
			
		}
		
		/**
		 *标记已读邮件
		 * 
		 */
		public function isRead(emailID:String):void
		{
			var obj:Object = {mail_ids:emailID};
			ConnDebug.send(CommandEnum.isRead,obj);
		}
		
		private function isReadResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			if(data.message == "OK")
			{
				getEmailList();
			}
		}
		
		/**
		 *删除邮件
		 * 
		 */
		public function deleteEmail(arr:Object):void
		{
			var strJson:String = JSON.stringify(arr);
			var playerID:String = userInforProxy.userInfoVO.player_id;
			var obj:Object = {player_id:playerID,mail_ids:strJson};
			ConnDebug.send(CommandEnum.deleteEmail,obj);
		}
		
		private function deleteEmailResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			getEmailListResult(data);
		}
		
		/**
		 *收取邮件附件
		 * 
		 */
		public function getSource(emailID:String):void
		{
			var obj:Object = {mail_id:emailID,player_id:userInforProxy.userInfoVO.player_id};
			ConnDebug.send(CommandEnum.receiveEmailSource,obj);
		}
		
		private function getSourceResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			if(data.message_type == "receive_attachment")
			{
				sendNotification(ViewEmailComponentMediator.receive_attachment);
				//更新服务器数据
				userInforProxy.updateServerData();
				//更新背包数据
				packageViewProxy.packageViewView();
			}
			
		}
	}
}