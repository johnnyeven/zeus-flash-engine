package view.mainView
{
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;
    
    import enum.chat.ChannelEnum;
    
    import events.friendList.FriendListEvent;
    import events.talk.TalkEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.TextEvent;
    import flash.net.registerClassAlias;
    import flash.text.TextField;
    import flash.ui.Keyboard;
    import flash.utils.getDefinitionByName;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.chat.ChatProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.components.Button;
    import ui.components.Container;
    import ui.components.Label;
    import ui.components.TextInput;
    import ui.components.VScrollBar;
    import ui.core.Component;
    import ui.layouts.HTileLayout;
    import ui.layouts.VLayout;
    import ui.layouts.VTileLayout;
    import ui.utils.DisposeUtil;
    
    import vo.chat.ChatItemVO;
    import vo.chat.ChatVO;

    public class ChatViewComponent extends Component
    {
        //玩家VIP
        public static const VIP_COUNT:int = 3;

        /**
         * 聊天输入框
         */
        public var chatText:TextInput;
		
		/**
		 * 私聊输入框
		 */
//		public var privateSprivate:Component;
//		public var nameTxt:TextInput;
//		public var inforTxt:TextInput;

        /**
         * 发送按钮
         */
        public var sendBtn:Button;

        /**
         * 好友按钮
         */
        public var friendBtn:Button;

        /**
         * 世界按钮
         */
        public var wordBtn:Button;

        /**
         * 阵营按钮
         */
        public var campBtn:Button;

        /**
         * 军团按钮
         */
        public var armyGroupBtn:Button;

        /**
         * 私聊按钮
         */
        public var privateChatBtn:Button;

        /**
         * 超链接按钮
         */
        public var hyperlinkBtn:Button;

        /**
         *聊天窗口背景上升控制按钮
         */
        public var upBtn:MovieClip;

        /**
         * 聊天窗口背景下降控制按钮
         */
        public var downBtn:MovieClip;

        /**
         *显示全部聊天内容
         */
        public var allShowSprite:Component;

        public var vScrollBar:VScrollBar;

        public var allShowContainer:Container;

        /**
         *显示部分聊天内容
         */
        public var partShowSprite:Component;

//        public var partScrollBar:VScrollBar;

        public var partShowContainer:Container;

        /**
         *表情按钮
         */
        public var faceBtn:MovieClip;

        private var chatString:String = "";

        private var _channelSelected:int = ChannelEnum.CHANNEL_WORLD;

        private var chatProxy:ChatProxy;

        private var userInforProxy:UserInfoProxy;

        private var chatVO:ChatVO = new ChatVO();

        private var container_all:Container;

        private var container_part:Container;
		
		//记录数据条数
		private var _count:int;
		//不能多次点击已被选中的按钮
		private var wordBoolean:Boolean = true;
		private var campBoolean:Boolean = true;
		private var groupBoolean:Boolean = true;
		private var privateBoolean:Boolean = true;
		
		//超练接中点击的对象
		private var _currentTarget:Object;
		
		//私聊对象的名字
		private var _privateChatName:String;


        public function ChatViewComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            var num:String
            for (var i:int = 0; i < VIP_COUNT; i++)
            {
                num = String(i);
                registerClassAlias("/" + num, Class(getDefinitionByName("VIP_" + num)));
            }

            chatProxy = ApplicationFacade.getProxy(ChatProxy);
            userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);

            chatText = createUI(TextInput, "liaotian_tf");
			
            sendBtn = createUI(Button, "fasong_btn");
            friendBtn = createUI(Button, "haoyou_btn");
            wordBtn = createUI(Button, "shijie_btn");
            campBtn = createUI(Button, "zhenying_btn");
            armyGroupBtn = createUI(Button, "juntuan_btn");
            privateChatBtn = createUI(Button, "siliao_btn");
            hyperlinkBtn = createUI(Button, "chaolianjie_btn");

            upBtn = getSkin("up_btn");
            downBtn = getSkin("down_btn");
            faceBtn = getSkin("biaoqing_mc");
            var biaoqing_mc:Sprite = getSkin("biaoqing_mc");

            allShowSprite = createUI(Component, "allShowSprite");
            vScrollBar = allShowSprite.createUI(VScrollBar, "vScrollBar");
            allShowContainer = allShowSprite.createUI(Container, "allShowContainer");
            allShowSprite.sortChildIndex();

            partShowSprite = createUI(Component, "partShowSprite");
 //           partScrollBar = partShowSprite.createUI(VScrollBar, "partScrollBar");
            partShowContainer = partShowSprite.createUI(Container, "partShowContainer");
            partShowSprite.sortChildIndex();

            sortChildIndex();

            chatText.color = 0xFFFFFF;
            chatText.label.fontName = "微软雅黑";
            chatText.addEventListener(TextEvent.TEXT_INPUT, textChange_handler);
            chatText.addEventListener(KeyboardEvent.KEY_UP, keyUp_clickHandler);
//			allShowContainer.layout = new VTileLayout(allShowContainer);
//			partShowContainer.layout = new VTileLayout(partShowContainer);

            container_all = new Container(null);
            container_all.contentWidth = 364;
            container_all.contentHeight = 300;
            container_all.layout = new VLayout(container_all);
            container_all.x = 8;
            container_all.y = 5;
            allShowSprite.addChild(container_all);

            vScrollBar.viewport = container_all;
            vScrollBar.autoScroll = true;

            container_part = new Container(null);
            container_part.contentWidth = 372;
            container_part.contentHeight = 60;
            container_part.layout = new VLayout(container_part);
            container_part.x = 0;
            container_part.y = 5;
            partShowSprite.addChild(container_part);

//			partScrollBar.height = 60;
//           partScrollBar.viewport = container_part;
//            partScrollBar.autoScroll = true;
//			partScrollBar.visible = false;

            biaoqing_mc.visible = downBtn.visible = allShowSprite.visible = false;
            upBtn.mouseEnabled = downBtn.mouseEnabled = true;
            chatText.mouseEnabled = true;

            upBtn.addEventListener(MouseEvent.CLICK, upBtn_clickHandler);
            downBtn.addEventListener(MouseEvent.CLICK, downBtn_clickHandler);
            friendBtn.addEventListener(MouseEvent.CLICK, friendBtn_clickHandler);
            sendBtn.addEventListener(MouseEvent.CLICK, send_clickHandler);
            hyperlinkBtn.addEventListener(MouseEvent.CLICK, hyperlinkBtn_clickHandler);

            //通道控制
            wordBtn.addEventListener(MouseEvent.CLICK, wordBtn_clickHandler);
            campBtn.addEventListener(MouseEvent.CLICK, campBtn_clickHandler);
            armyGroupBtn.addEventListener(MouseEvent.CLICK, armyGroupBtn_clickHandler);
            privateChatBtn.addEventListener(MouseEvent.CLICK, privateChatBtn_clickHandler);

			//默认世界频道选中
			wordBtn_clickHandler(null);

        }

        public function dataChange(data:ChatVO):void
        {
            chatVO = data as ChatVO;
            if (chatVO)
            {
				if(channelSelected == ChannelEnum.CHANNEL_WORLD)
				{
					setDat(chatVO.wordList);
				}
				else if(channelSelected == ChannelEnum.CHANNEL_NB)
				{
					setDat(chatVO.wordList);
				}
				else if(channelSelected == ChannelEnum.CHANNEL_ARMY_GROUP)
				{
					setDat(chatVO.armyGroupList);
				}
				else if(channelSelected == ChannelEnum.CHANNEL_PRIVATE)
				{
					setDat(chatVO.privateList);
				}
               
            }

        }

        private function setDat(value:Array):void
        {
			//选择频道后，第一次进来都把原来的数据全部删了
		   if(count == 1)
		   {
			  while(allShowContainer.num)
				DisposeUtil.dispose(allShowContainer.removeAt(0));
			  while(partShowContainer.num)
				DisposeUtil.dispose(partShowContainer.removeAt(0));
			  
			  count = count+1;
		   }
		   
			

            if (value.length > 0)
            {
                for (var i:int = 0; i < value.length; i++)
                {
                    var itemVo:ChatItemVO = (value[i] as ChatItemVO);
                    var itemLabel:Label = new Label();
					itemLabel.color = 0xFFFFFF;
					itemLabel.fontName = "微软雅黑";
					itemLabel.mouseChildren = itemLabel.mouseEnabled = true;
                    itemLabel.textWidth = allShowContainer.width;
                    itemLabel.textHeight = 12
                    itemLabel.text = setString(itemVo);

                    container_all.add(itemLabel);
                    //超链接
                    itemLabel.addEventListener(TextEvent.LINK, itemLabel_linkClickHandler);
                }
                var arr:Array = [];
                if (value.length < 5)
                {
                    arr = value;
                }
                else
                {
                    arr = value.slice(value.length - 5, value.length);
                }

                for (var j:int = 0; j < arr.length; j++)
                {
					while(container_part.num >3)
					{
						DisposeUtil.dispose(container_part.removeAt(0));
//						container_part.num
					}
						
                    var chatItemVo:ChatItemVO = (arr[j] as ChatItemVO);
                    var partItemLabel:Label = new Label();
					partItemLabel.color = 0xFFFFFF;
					partItemLabel.fontName = "微软雅黑";
					partItemLabel.mouseChildren = partItemLabel.mouseEnabled = true;
                    partItemLabel.textWidth = partShowContainer.width;
                    partItemLabel.textHeight = 12;
                    partItemLabel.text = setString(chatItemVo);
                    container_part.add(partItemLabel);

                    //超链接
                    partItemLabel.addEventListener(TextEvent.LINK, itemLabel_linkClickHandler);
                }

                container_all.layout.update();
				container_all.layout.vGap = 4;
                container_part.layout.update();
				container_part.layout.vGap = 4;

            }

        }

        protected function friendBtn_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new FriendListEvent(FriendListEvent.FRIEND_LIST_EVENT));
        }

        private function upBtn_clickHandler(event:MouseEvent):void
        {
            upBtn.visible = partShowSprite.visible = false;
            downBtn.visible = allShowSprite.visible = true;
        }

        private function downBtn_clickHandler(event:MouseEvent):void
        {
            downBtn.visible = allShowSprite.visible = false;
            upBtn.visible = partShowSprite.visible = true;
        }

        private function send_clickHandler(event:MouseEvent):void
        {
            if (chatString == "")
                return;
            dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT, chatString, channelSelected));
			chatText.text = "";
        }

        private function textChange_handler(event:TextEvent):void
        {
            chatString = chatText.text;
        }

        private function keyUp_clickHandler(event:KeyboardEvent):void
        {
            if (event.charCode == Keyboard.ENTER && chatString != "")
			{
				dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT, chatString, channelSelected));
			    chatText.text = "";
			}
                
        }

        private function wordBtn_clickHandler(event:MouseEvent):void
        {
			if(wordBoolean)
			{
				wordBoolean = false;
				campBoolean = true;
				groupBoolean = true;
				privateBoolean = true;
				addChildAt(wordBtn,3);
				addChildAt(campBtn,2);
				addChildAt(armyGroupBtn,1);
				addChildAt(privateChatBtn,0);
				
				wordBtn.toggle=true;
				campBtn.toggle=true;
				armyGroupBtn.toggle=true;
				privateChatBtn.toggle=true;
				
				wordBtn.selected=true;
				campBtn.selected=false;
				armyGroupBtn.selected=false;
				privateChatBtn.selected=false;
				
				count=1;
	            channelSelected = ChannelEnum.CHANNEL_WORLD;
			}
                
        }

        private function campBtn_clickHandler(event:MouseEvent):void
        {
			if(campBoolean)
			{
				wordBoolean = true;
				campBoolean = false;
				groupBoolean = true;
				privateBoolean = true;
				addChildAt(wordBtn,2);
				addChildAt(campBtn,3);
				addChildAt(armyGroupBtn,1);
				addChildAt(privateChatBtn,0);
				
				wordBtn.toggle=true;
				campBtn.toggle=true;
				armyGroupBtn.toggle=true;
				privateChatBtn.toggle=true;
				
				wordBtn.selected=false;
				campBtn.selected=true;
				armyGroupBtn.selected=false;
				privateChatBtn.selected=false;
				
				count=1;
	            channelSelected = ChannelEnum.CHANNEL_NB;
			}
                
        }

        private function armyGroupBtn_clickHandler(event:MouseEvent):void
        {
			if(groupBoolean)
			{
				wordBoolean = true;
				campBoolean = true;
				groupBoolean = false;
				privateBoolean = true;
				addChildAt(wordBtn,2);
				addChildAt(campBtn,1);
				addChildAt(armyGroupBtn,3);
				addChildAt(privateChatBtn,0);
				
				wordBtn.toggle=true;
				campBtn.toggle=true;
				armyGroupBtn.toggle=true;
				privateChatBtn.toggle=true;
				
				wordBtn.selected=false;
				campBtn.selected=false;
				armyGroupBtn.selected=true;
				privateChatBtn.selected=false;
				count = 1;
	            channelSelected = ChannelEnum.CHANNEL_ARMY_GROUP;
			}
			
			//点击其他按钮恢复输如框
			privateChatName = "";
			chatText.text = "";
			chatText.mouseEnabled = true;
                
        }

        private function privateChatBtn_clickHandler(event:MouseEvent):void
        {
			if(privateBoolean)
			{
				wordBoolean = true;
				campBoolean = true;
				groupBoolean = true;
				privateBoolean = false;
				
				addChildAt(wordBtn,2);
				addChildAt(campBtn,1);
				addChildAt(armyGroupBtn,0);
				addChildAt(privateChatBtn,3);
				
				wordBtn.toggle=true;
				campBtn.toggle=true;
				armyGroupBtn.toggle=true;
				privateChatBtn.toggle=true;
				
				wordBtn.selected=false;
				campBtn.selected=false;
				armyGroupBtn.selected=false;
				privateChatBtn.selected=true;
				
				count=1;
	            channelSelected = ChannelEnum.CHANNEL_PRIVATE;
			}  
			
			//私聊通道的控制
			if(privateChatName)
			{
				chatText.text = "";
				chatText.mouseEnabled = true;
			}
			else
			{
				chatText.text = "请在聊天框或好友列表中选择私聊对象！";
				chatText.mouseEnabled = false;
			}
        }

        private function itemLabel_linkClickHandler(event:TextEvent):void
        {
			currentTarget = event.currentTarget as Label;
            dispatchEvent(new TextEvent(TextEvent.LINK, true, true, event.text));
        }

        private function hyperlinkBtn_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new TalkEvent(TalkEvent.SHOW_BAG_COMPONENT_EVENT, "", 0));
        }

        public function setLabel(value:String):void
        {
            chatText.text += value;
        }

        public function get channelSelected():int
        {
            return _channelSelected;
        }

        public function set channelSelected(value:int):void
        {
            _channelSelected = value;
        }
		
		public function get count():int
		{
			return _count;
		}
		
		public function set count(value:int):void
		{
			_count = value;
		}
		
		public function get currentTarget():Object
		{
			return _currentTarget;
		}
		
		public function set currentTarget(value:Object):void
		{
			_currentTarget = value;
		}
		
		/**
		 * 外部控制私聊
		 * 
		 */		
		public function privateChatHandler():void
		{
			privateChatBtn_clickHandler(null);
		}
		
		public function get privateChatName():String
		{
			return _privateChatName;
		}
		
		public function set privateChatName(value:String):void
		{
			_privateChatName = value;
		}


        /***********************************************************
         *
         * 功能方法
         *
         * ****************************************************/
        private function setString(data:ChatItemVO):String
        {
			if(channelSelected == ChannelEnum.CHANNEL_PRIVATE)
			{
//				if(data.str.indexOf("PRIVATE_") != -1)
//			    {
				var strXml:String = StringUtil.formatString("<p><s>{0}</s></p>",data.str);
				var xml:XML = new XML(strXml);
				var userData:String = xml.a.@value[0];
//			    }
				var dataObj:Object = JSON.parse(userData);
			}
			
            var timeStr:String;
            var str:String
            if (data.system)
            {
                timeStr = DateFormatter.formatterTime(data.timeStamp / 1000);
                str = "<p color = '0xdcbd7a'><s>{0}</s><s></s><s>{1}</s><s>[</s><s>{2}</s><s>]</s></p>";
                str = StringUtil.formatString(str, "系统广播:", data.str, timeStr);
            }
            else
            {
                if (data.channel > 10)
                {
                    if (dataObj.myID == userInforProxy.userInfoVO.player_id)
                    {
						var obj1:Object = {playerVIP:dataObj.otherVIP,playerID:dataObj.otherID,playerName:dataObj.otherName};
						var str1:String=JSON.stringify(obj1);
						var t1:String = String.fromCharCode(11);
						str1 = str1.replace(/\"/g,t1);
						//发送者的显示设置
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0xc3d4e8'><s>我对</s><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s><s>说：</s><s>{3}</s><s>[{4}]</s></p>";
                        str = StringUtil.formatString(str,dataObj.otherVIP,str1,dataObj.otherName,dataObj.textStr,timeStr);
				
                    }
                    else if(dataObj.otherID == userInforProxy.userInfoVO.player_id)
                    {
						var obj2:Object = {playerVIP:dataObj.myVIP,playerID:dataObj.myID,playerName:dataObj.myName};
						var str2:String=JSON.stringify(obj2);
						var t2:String = String.fromCharCode(11);
						str2 = str2.replace(/\"/g,t2);
						//接收者的显示设置
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0x5283ae'><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s><s>对我说：</s><s>{3}</s><s>[{4}]</s></p>";
                        str = StringUtil.formatString(str, dataObj.myVIP,str2,dataObj.myName,dataObj.textStr,timeStr);
                    }

                }
                else
                {
                    if (data.playerID == userInforProxy.userInfoVO.player_id)
                    {
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0xc3d4e8'><s>{0}</s><s>[</s><s>{1}</s><s>]</s></p>";
                        str = StringUtil.formatString(str,data.str, timeStr);
                    }
                    else
                    {
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0x5283ae'><s>{0}</s><s>[</s><s>{1}</s><s>]</s></p>";
                        str = StringUtil.formatString(str,data.str, timeStr);
                    }

                }
            }
			
            return str;
        }
		
		private function setTime(time:Number):String
		{
			var timeStr:String ="";
			
			return timeStr;
		}
    }
}
