package view.mainView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.chat.ChannelEnum;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.net.registerClassAlias;
	import flash.utils.getDefinitionByName;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.chat.ChatItemVO;
	
	public class ChatInforIten extends Component
	{
		//玩家VIP
		public static const VIP_COUNT:int = 4;
		public static const FACE_COUNT:int = 24;
		public var inforLabel:Label;
		
		public var timeLabel:Label;
		
		public var bgSprite:Sprite;
		
		private var _data:ChatItemVO;
		public  var _channel:String;
		private var _isLink:Boolean = false;
		private var userInforProxy:UserInfoProxy;
		public function ChatInforIten()
		{
			super(ClassUtil.getObject("mainView.chat.InforItemSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			var num:String
			for (var i:int = 0; i < VIP_COUNT; i++)
			{
				num = String(i);
				registerClassAlias("/" + num,Class(getDefinitionByName("VIP_" + num)));
			}
			var num1:String;
			for(var j:int = 1;j<=FACE_COUNT;j++)
			{
				num1 = String(j);
				registerClassAlias("FACE_"+num1,Class(getDefinitionByName("FACE_"+num1)));
			
			}
			inforLabel = createUI(Label,"inforLabel");
			timeLabel = createUI(Label,"timeLabel");
			bgSprite = getSkin("bgSprite");
			sortChildIndex();
			inforLabel.mouseChildren = inforLabel.mouseEnabled = true;
			inforLabel.addEventListener(TextEvent.LINK,inforLabel_linkClickHandler);
			inforLabel.graphHeight=inforLabel.textHeight;
			inforLabel.autoHeight=true;
		}

		public function get channel():String
		{
			return _channel;
		}
		
		public function set channel(value:String):void
		{
			_channel = value;
		}
		
		public function get data():ChatItemVO
		{
			return _data;
		}

		public function set data(value:ChatItemVO):void
		{
			_data = value;
			if(_data)
			{
				inforLabel.text = setString(_data,_data.mySetChannel);
				var timeStr:String = "<p><s>[{0}]</s></p>";
				timeStr = StringUtil.formatString(timeStr,DateFormatter.gFormatterSF(data.timeStamp));
//				timeStr = StringUtil.formatString(timeStr,setTime(data.timeStamp));
//				timeLabel.text = setTime(data.timeStamp);
				timeLabel.text = timeStr;
				timeLabel.y = inforLabel.y+inforLabel.height - timeLabel.height;
				bgSprite.height = inforLabel.height;
			}
		}
		
		private function inforLabel_linkClickHandler(event:TextEvent):void
		{
			event.stopImmediatePropagation();
			_isLink = true;
           dispatchEvent(new TextEvent(TextEvent.LINK, true, false, event.text));
		}
		/***********************************************************
		 *
		 * 功能方法
		 *
		 * ****************************************************/
		private function setString(data:ChatItemVO,channel:String):String
		{
			if(channel == ChannelEnum.CHANNEL_PRIVATE)
			{
				//				if(data.str.indexOf("PRIVATE_") != -1)
				//			    {
				var strXml:String = StringUtil.formatString("<p><s>{0}</s></p>",data.str);
				var xml:XML = new XML(strXml);
				var userData:String = xml.a.@value[0];
				//			    }
				var dataObj:Object = JSON.parse(userData);
				//将特殊字符转换回来
				//用特殊字符替换规定：< - &lt; > - &gt;
				var re1:RegExp=new RegExp('&lt;',"g");
				dataObj.textStr = dataObj.textStr.replace(re1,'<');
				var re2:RegExp=new RegExp('&gt;',"g");
				dataObj.textStr = dataObj.textStr.replace(re2,'>');
			}
			
			var str:String
			if (data.system)
			{
				var color:uint = 0;
				if(data.type == "0")
				{
					color = 0xffb02e;
				}
				else if(data.type == "1")
				{
					color = 0x90ff00;
				}
				str = "<p color = '{0}'><s>{1}</s><s></s><s>{2}</s></p>";
				str = StringUtil.formatString(str, color, "系统广播:", data.str);
			}
			else
			{
				if (int(data.channel) > 10)
				{
					if (dataObj.myID == userInforProxy.userInfoVO.player_id)
					{
						var obj1:Object = {otherVIP:dataObj.otherVIP,otherID:dataObj.otherID,otherName:dataObj.otherName};
						var str1:String=JSON.stringify(obj1);
						var t1:String = String.fromCharCode(11);
						str1 = str1.replace(/\"/g,t1);
						//发送者的显示设置
						str = "<p color = '0xd1e4ff'><s>我对</s><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s><s>说：</s>{3}</p>";
						str = StringUtil.formatString(str,dataObj.otherVIP,str1,dataObj.otherName,dataObj.textStr);
						
					}
					else if(dataObj.otherID == userInforProxy.userInfoVO.player_id)
					{
						var obj2:Object = {myVIP:dataObj.myVIP,myID:dataObj.myID,myName:dataObj.myName};
						var str2:String=JSON.stringify(obj2);
						var t2:String = String.fromCharCode(11);
						str2 = str2.replace(/\"/g,t2);
						//接收者的显示设置
						str = "<p color = '0x22afe5'><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s><s>对我说：</s>{3}</p>";
						str = StringUtil.formatString(str, dataObj.myVIP,str2,dataObj.myName,dataObj.textStr);
					}
					
				}
				else
				{
					if (data.myID == userInforProxy.userInfoVO.player_id)
					{
						str = "<p color = '0xd1e4ff'><s>{0}</s></p>";
//						str = "<s>{0}</s>";
						str = StringUtil.formatString(str,data.str);
					}
					else
					{
						str = "<p color = '0x22afe5'><s>{0}</s></p>";
//						str = "<s>{0}</s>";
						str = StringUtil.formatString(str,data.str);
					}
					
				}
			}
			
			return str;
		}
		
		/**
		 * 时间的处理
		 * @param time
		 * @return 
		 * 
		 */		
		private function setTime(time:Number):String
		{
			var date:Date = new Date();
			var currentTime:Date;
			date.setTime(time);
			var timeStr:String ="";
			var sec:int = time%60;
			var min:int = int(time/60)%60;
			var hour:int = int(time/3600)%23 +12;
			var day:int = int(time/(60*60*24))%32;
//			var sec:Number = date.seconds;
//			var min:Number = date.minutes;
//			var hour:Number = date.hours;
//			var day:Number = date.date;
//			timeStr =  (day < 10 ? "0" + day : "" + day)+":"+(hour < 10 ? "0" + hour : "" + hour)+":"+ (min < 10 ? "0" + min : "" + min)+":"+(sec < 10 ? "0" + sec : "" + sec);
			timeStr =  (hour < 10 ? "0" + hour : "" + hour)+":"+ (min < 10 ? "0" + min : "" + min);
			return timeStr;
		}

		/**
		 * 标记是否为超链接
		 */
		public function get isLink():Boolean
		{
			return _isLink;
		}

		/**
		 * @private
		 */
		public function set isLink(value:Boolean):void
		{
			_isLink = value;
		}


	}
}