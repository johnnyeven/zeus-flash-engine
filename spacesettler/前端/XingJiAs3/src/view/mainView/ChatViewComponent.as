package view.mainView
{
    import com.greensock.TweenLite;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;
    
    import enum.FontEnum;
    import enum.chat.ChannelEnum;
    
    import events.friendList.FriendListEvent;
    import events.talk.ChatEvent;
    import events.talk.TalkEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.TextEvent;
    import flash.geom.Point;
    import flash.net.registerClassAlias;
    import flash.system.System;
    import flash.text.TextField;
    import flash.ui.Keyboard;
    import flash.utils.getDefinitionByName;
    
    import mediator.mainView.MainViewMediator;
    
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
    import ui.managers.SystemManager;
    import ui.utils.DisposeUtil;
    
    import vo.chat.ChatItemVO;
    import vo.chat.ChatVO;

    public class ChatViewComponent extends Component
    {
        //玩家VIP
        public static const VIP_COUNT:int = 3;
		
		/**
		 * 聊天显示的行距
		 */
		public static const DISTANCE_COUNT:int = 4;

        /**
         * 聊天输入框
         */
        public var chatText:TextInput;
		
		/**
		 * 私聊输入框
		 */
		public var privateSprivate:Component;
		public var nameLabel:Label;
		public var inforTxt:TextInput;

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
		 * 私聊提示元件
		 */
		public var privateChatTips:MovieClip;
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
		
        /**
         *显示部分聊天内容
         */
        public var partShowSprite:Component;

        /**
         *表情按钮
         */
        public var faceBtn:MovieClip;

        private var chatString:String = "";

        private var _channelSelected:String = ChannelEnum.CHANNEL_WORLD;
		/**
		 *当前选择显示的部分显示框
		 */
//		private var selectedPartContainer:Container;
		/**
		 *当前选择显示的全部显示框
		 */
//		private var selectedAllContainer:Container;

        private var chatProxy:ChatProxy;

        private var userInforProxy:UserInfoProxy;

        private var chatVO:ChatVO = new ChatVO();

        private var container_all_word:Container;
		private var container_all_camp:Container;
		private var container_all_group:Container;
		private var container_all_private:Container;

        private var container_part_word:Container;
		private var container_part_camp:Container;
		private var container_part_group:Container;
		private var container_part_private:Container;
		
		//记录数据条数
		private var _count:int;
		//不能多次点击已被选中的按钮
		private var wordBoolean:Boolean = true;
		private var campBoolean:Boolean = true;
		private var groupBoolean:Boolean = true;
		private var privateBoolean:Boolean = true;
		
		//选中的对象
		private var _currentTarget:ChatInforIten;
		
		//私聊对象的名字
		private var _privateChatName:String;

		private var mainMediater:MainViewMediator;
		private var shangBiaoSprivate:Sprite;
		private var seletedSkinSprite:Sprite;
		private var chatSelectedComponent:ChatSelectedComponent;
		//聊天框上遮罩
		private var shangSprite:Sprite;
		//聊天框下遮罩
		private var xiaSprite:Sprite;
		//聊天框右遮罩
//		private var rightSprite:Sprite;
		//举报按钮
		private var juBaoBtn:Sprite;
		/**
		 * 选中的表情
		 */		
		private var selectedFace:String;
        public function ChatViewComponent(skin:DisplayObjectContainer)
        {
            super(skin);
			
            var num:String;
            for (var i:int = 0; i < VIP_COUNT; i++)
            {
                num = String(i);
                registerClassAlias("/" + num, Class(getDefinitionByName("VIP_" + num)));
            }

            chatProxy = ApplicationFacade.getProxy(ChatProxy);
            userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);

            chatText = createUI(TextInput, "liaotian_tf");
			privateSprivate = createUI(Component,"privateSprivate");
			nameLabel = privateSprivate.createUI(Label,"nameLabel");
			inforTxt = privateSprivate.createUI(TextInput,"inforTxt");
			privateSprivate.sortChildIndex();
			
			
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
			faceBtn.mouseEnabled = true;
			faceBtn.buttonMode = true;
           
            allShowSprite = createUI(Component, "allShowSprite");
            vScrollBar = allShowSprite.createUI(VScrollBar, "vScrollBar");
            allShowSprite.sortChildIndex();

            partShowSprite = createUI(Component, "partShowSprite");
            partShowSprite.sortChildIndex();

			
			//私聊提示元件
			privateChatTips = ClassUtil.getObject("mainView.chat.PrivateChatTipsSkin") as MovieClip;
			privateChatTips.x = privateChatBtn.x+ privateChatBtn.width/2;
			privateChatTips.y = privateChatBtn.y - privateChatTips.height;
			this.addChild(privateChatTips);
			privateChatTips.visible = false;
			
            sortChildIndex();

            chatText.color = 0xFFFFFF;
            chatText.label.fontName = FontEnum.WEI_RUAN_YA_HEI;
            chatText.addEventListener(TextEvent.TEXT_INPUT, textChange_handler);
            chatText.addEventListener(KeyboardEvent.KEY_UP, keyUp_clickHandler);
			
			inforTxt.color = 0xFFFFFF;
			inforTxt.label.fontName = FontEnum.WEI_RUAN_YA_HEI;
			inforTxt.addEventListener(TextEvent.TEXT_INPUT, ptivateTextChange_handler);
			inforTxt.addEventListener(KeyboardEvent.KEY_UP, privateKeyUp_clickHandler);

			container_all_word = new Container(null);
			container_all_word.contentWidth = 364;
			container_all_word.contentHeight = 300;
			container_all_word.layout = new VLayout(container_all_word);
			container_all_word.x = 8;
			container_all_word.y = 5;
            allShowSprite.addChild(container_all_word);
			
			container_all_camp = new Container(null);
			container_all_camp.contentWidth = 364;
			container_all_camp.contentHeight = 300;
			container_all_camp.layout = new VLayout(container_all_camp);
			container_all_camp.x = 8;
			container_all_camp.y = 5;
			allShowSprite.addChild(container_all_camp);
			
			container_all_group = new Container(null);
			container_all_group.contentWidth = 364;
			container_all_group.contentHeight = 300;
			container_all_group.layout = new VLayout(container_all_group);
			container_all_group.x = 8;
			container_all_group.y = 5;
			allShowSprite.addChild(container_all_group);
			
			container_all_private = new Container(null);
			container_all_private.contentWidth = 364;
			container_all_private.contentHeight = 300;
			container_all_private.layout = new VLayout(container_all_private);
			container_all_private.x = 8;
			container_all_private.y = 5;
			allShowSprite.addChild(container_all_private);

            vScrollBar.autoScroll = true;

			container_part_word = new Container(null);
			container_part_word.contentWidth = 372;
			container_part_word.contentHeight = 60;
			container_part_word.layout = new VLayout(container_part_word);
			container_part_word.x = 0;
			container_part_word.y = 5;
            partShowSprite.addChild(container_part_word);
			
			container_part_camp = new Container(null);
			container_part_camp.contentWidth = 372;
			container_part_camp.contentHeight = 60;
			container_part_camp.layout = new VLayout(container_part_camp);
			container_part_camp.x = 0;
			container_part_camp.y = 5;
			partShowSprite.addChild(container_part_camp);
			
			container_part_group = new Container(null);
			container_part_group.contentWidth = 372;
			container_part_group.contentHeight = 60;
			container_part_group.layout = new VLayout(container_part_group);
			container_part_group.x = 0;
			container_part_group.y = 5;
			partShowSprite.addChild(container_part_group);
			
			container_part_private = new Container(null);
			container_part_private.contentWidth = 372;
			container_part_private.contentHeight = 60;
			container_part_private.layout = new VLayout(container_part_private);
			container_part_private.x = 0;
			container_part_private.y = 5;
			partShowSprite.addChild(container_part_private);

            downBtn.visible = allShowSprite.visible = false;
            upBtn.mouseEnabled = downBtn.mouseEnabled = true;
            chatText.mouseEnabled = true;
			faceBtn.addEventListener(MouseEvent.CLICK,faceBtn_clickHandler);
			
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
			  setDat(chatVO.wordList,ChannelEnum.CHANNEL_WORLD);
			  setDat(chatVO.campList,ChannelEnum.CHANNEL_CAMP);
			  setDat(chatVO.armyGroupList,ChannelEnum.CHANNEL_ARMY_GROUP);
			  setDat(chatVO.privateList,ChannelEnum.CHANNEL_PRIVATE);
            }
        }

        private function setDat(value:Array,channel:String):void
        {
            if (value.length > 0)
            {
				//私聊来信提示
				if(channel == ChannelEnum.CHANNEL_PRIVATE)
				{
					if((value[0] as ChatItemVO).myID == userInforProxy.userInfoVO.player_id)
					{
						privateChatTips.visible = false;
					}
					else
					{
						privateChatTips.visible = true;
					}
					
				}
                for (var i:int = 0; i < value.length; i++)
                {
                    var itemVo:ChatItemVO = (value[i] as ChatItemVO);
					var chatInforItem:ChatInforIten = new ChatInforIten();
					chatInforItem.mouseChildren = chatInforItem.mouseEnabled = chatInforItem.buttonMode = true;
//					chatInforItem._channel = channel;
					itemVo.mySetChannel = channel;
					chatInforItem.data = itemVo;
					allContainerAddData(chatInforItem,channel);
                    //选择条目
					chatInforItem.addEventListener(MouseEvent.CLICK, chatInforItem_ClickHandler);
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
					while(getContainerByChannel(channel).num >2)
					{
						DisposeUtil.dispose(getContainerByChannel(channel).removeAt(0));
					}
						
                    var chatItemVo:ChatItemVO = (arr[j] as ChatItemVO);
                    var partItem:ChatInforIten = new ChatInforIten();
					partItem.mouseChildren = partItem.mouseEnabled = buttonMode = true;
					chatItemVo.mySetChannel = channel;
					partItem.data = chatItemVo;
//					partItem.channel = channel;
					partContainerAddData(partItem,channel);
                    //选择条目
					partItem.addEventListener(MouseEvent.CLICK, chatInforItem_ClickHandler);
                }
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
            if (chatString == "" || chatString == "请在聊天框或好友列表中选择私聊对象！")
                return;
            dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT, chatString, channelSelected));
			chatText.clean();
			inforTxt.clean();
        }

        private function textChange_handler(event:TextEvent):void
        {
//            chatString = chatText.text;
			chatString = chatText.createXML(chatText.text);
        }
		
		private function ptivateTextChange_handler(event:TextEvent):void
		{
//			chatString = inforTxt.text;
			chatString = inforTxt.createXML(inforTxt.text);
		}
		
        private function keyUp_clickHandler(event:KeyboardEvent):void
        {
           if (event.charCode == Keyboard.ENTER && chatString != "")
			{
				dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT, chatString, channelSelected));
			    chatText.text = "";
			}
                
        }
		
		private function privateKeyUp_clickHandler(event:KeyboardEvent):void
		{
			if (event.charCode == Keyboard.ENTER && chatString != "")
			{
				dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT, chatString, channelSelected));
				inforTxt.text = "";
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
				getPanelByChannel(channelSelected);
			}
              
			//点击其他按钮恢复输如框
			privateChatName = "";
			chatText.text = "";
			chatText.visible = true;
			privateSprivate.visible = false;
			chatText.mouseEnabled = true;
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
	            channelSelected = ChannelEnum.CHANNEL_CAMP;
				getPanelByChannel(channelSelected);
			}
			
			//点击其他按钮恢复输如框
			privateChatName = "";
			chatText.text = "";
			chatText.visible = true;
			privateSprivate.visible = false;
			chatText.mouseEnabled = true;
                
        }

        private function armyGroupBtn_clickHandler(event:MouseEvent):void
        {
			if(StringUtil.isEmpty(userInforProxy.userInfoVO.legion_id))
			{
				dispatchEvent(new Event("tipsInChatArmyGroup"));
				armyGroupBtn.toggle=true;
				armyGroupBtn.selected=false;
				return;
			}
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
				getPanelByChannel(channelSelected);
			}
			
			//点击其他按钮恢复输如框
			privateChatName = "";
			chatText.text = "";
			chatText.visible = true;
			privateSprivate.visible = false;
			chatText.mouseEnabled = true;
        }

        private function privateChatBtn_clickHandler(event:MouseEvent):void
        {
			//查看私聊来信后提示消失
			privateChatTips.visible = false;
			privateChatBtn.selected=true;
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
				getPanelByChannel(channelSelected);
			}  
			
			//私聊通道的控制
			if(privateChatName)
			{
				chatText.visible = false;
				privateSprivate.visible = true;
				chatText.mouseEnabled = true;
			}
			else
			{
				chatText.text = "请在聊天框或好友列表中选择私聊对象！";
				chatText.mouseEnabled = false;
			}
        }

        private function chatInforItem_ClickHandler(event:MouseEvent):void
        {
			event.stopImmediatePropagation();
			if((event.currentTarget as ChatInforIten).isLink == true)
			{
				(event.currentTarget as ChatInforIten).isLink = false;
				return;
			}
				
			currentTarget = event.currentTarget as ChatInforIten;
        }

        private function hyperlinkBtn_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new TalkEvent(TalkEvent.SHOW_BAG_COMPONENT_EVENT, "", "0"));
        }

        public function setLabel(value:String):void
        {
            chatText.text += value;
        }

        public function get channelSelected():String
        {
            return _channelSelected;
        }

        public function set channelSelected(value:String):void
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
		
		public function get currentTarget():ChatInforIten
		{
			return _currentTarget;
		}
		
		public function set currentTarget(value:ChatInforIten):void
		{
			
			if(chatSelectedComponent)
				return;
			_currentTarget = value;
            //系统消息不容许选择
			if(_currentTarget.data.system)
				return;
			//动画的调用
			setMovieClip();
		}
		
		private function setMovieClip():void
		{
			mainMediater = ApplicationFacade.getInstance().getMediator(MainViewMediator);
			mainMediater.comp.mouseChildren = true;
			shangBiaoSprivate = ClassUtil.getObject("mainView.chat.shangBiaoSprivate") as Sprite;
			juBaoBtn = ClassUtil.getObject("view.mainView.chat.JuBaoBtnSkin") as Sprite;
			juBaoBtn.mouseEnabled = true;
			juBaoBtn.buttonMode = true;
			seletedSkinSprite = ClassUtil.getObject("mainView.chat.selectedSkin") as Sprite;
			chatSelectedComponent = new ChatSelectedComponent();
			//私聊的单独处理
			chatSelectedComponent.selectedChannel = channelSelected;
			//将选中元件的坐标原点转化为全局坐标
			var point:Point = new Point();
			point = currentTarget.localToGlobal(point);
			//将聊天框的坐标转化为全局坐标
			var thisPoint:Point = new Point();
			thisPoint = this.localToGlobal(thisPoint);
			seletedSkinSprite.x = point.x - 4;
			seletedSkinSprite.y = point.y - 4;
			//选择框自适应（根据信息内容）
			seletedSkinSprite.height = currentTarget.inforLabel.height +12;
			seletedSkinSprite.width=currentTarget.width;
			mainMediater.comp.addChild(seletedSkinSprite);
			
			juBaoBtn.x = seletedSkinSprite.x + seletedSkinSprite.width - juBaoBtn.width;
			juBaoBtn.y = seletedSkinSprite.y + seletedSkinSprite.height;
			//聊天框上遮罩
			shangSprite = new Sprite();
			shangSprite.graphics.beginFill(0x000000,0.5);
			shangSprite.graphics.drawRect(0,0,this.width,seletedSkinSprite.y-thisPoint.y);
			shangSprite.graphics.endFill();
			shangSprite.x = 0;
			shangSprite.y = this.y;
			shangSprite.mouseEnabled = true;
			//聊天框下遮罩
			xiaSprite = new Sprite();
			xiaSprite.graphics.beginFill(0x000000,0.5);
			xiaSprite.graphics.drawRect(0,0,this.width,(mainMediater.comp.height-seletedSkinSprite.y-seletedSkinSprite.height));
			xiaSprite.graphics.endFill();
			xiaSprite.x = 0;
			xiaSprite.y = point.y + currentTarget.height;
			xiaSprite.mouseEnabled = true;
			//聊天框右遮罩
//			rightSprite = new Sprite();
//			rightSprite.graphics.beginFill(0x999999,0.5);
//			rightSprite.graphics.drawRect(0,0,(mainMediater.comp.width - seletedSkinSprite.width),seletedSkinSprite.height-4.5);
//			rightSprite.graphics.endFill();
//			rightSprite.x = seletedSkinSprite.x + seletedSkinSprite.width;
//			rightSprite.y = seletedSkinSprite.y;
//			rightSprite.mouseEnabled = true;
			
			shangSprite.addEventListener(MouseEvent.CLICK,mainMediater_clickHandler);
			xiaSprite.addEventListener(MouseEvent.CLICK,mainMediater_clickHandler);
//			rightSprite.addEventListener(MouseEvent.CLICK,mainMediater_clickHandler);
			juBaoBtn.addEventListener(MouseEvent.CLICK,mainMediater_clickHandler);
			mainMediater.addEventListener(MouseEvent.CLICK,mainMediater_clickHandler);
			mainMediater.comp.addChild(shangSprite);
			mainMediater.comp.addChild(xiaSprite);
//			mainMediater.comp.addChild(rightSprite);
			//上标
			shangBiaoSprivate.x = seletedSkinSprite.x + 50;
			shangBiaoSprivate.y = seletedSkinSprite.y - shangBiaoSprivate.height;
			mainMediater.comp.addChild(shangBiaoSprivate);
			mainMediater.comp.addChild(chatSelectedComponent);
			mainMediater.comp.addChild(juBaoBtn);
			
			chatSelectedComponent.x = point.x;
			chatSelectedComponent.y = 150;
			var y:Number = seletedSkinSprite.y - chatSelectedComponent.height - shangBiaoSprivate.height;
			TweenLite.to(chatSelectedComponent,1,{y:y});
			chatSelectedComponent.data = currentTarget.data;
			//自己不能举报自己
			if(currentTarget.data.myID == userInforProxy.userInfoVO.player_id)
			{
				juBaoBtn.visible = false;
			}
			else
			{
				juBaoBtn.visible = true;
			}
			
		}
		
		public function mainMediater_clickHandler(event:MouseEvent):void
		{
			mainMediater.comp.removeChild(shangBiaoSprivate);
			mainMediater.comp.removeChild(chatSelectedComponent);
			chatSelectedComponent = null;
			mainMediater.comp.removeChild(shangSprite);
			mainMediater.comp.removeChild(xiaSprite);
//			mainMediater.comp.removeChild(rightSprite);
			mainMediater.comp.removeChild(seletedSkinSprite);
			mainMediater.comp.removeChild(juBaoBtn);
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
			nameLabel.text = _privateChatName;
		}

		//根据选择的频道显示对应频道界面
		private function getPanelByChannel(channel:String):void
		{
			container_all_word.visible = false;
			container_all_camp.visible = false;
			container_all_group.visible = false;
			container_all_private.visible = false;
			
			container_part_word.visible = false;
			container_part_camp.visible = false;
			container_part_group.visible = false;
			container_part_private.visible = false;
			switch(channel)
			{
				case ChannelEnum.CHANNEL_WORLD:
				{
					container_all_word.visible = true;
					container_part_word.visible = true;
					vScrollBar.viewport = container_all_word;
					break;
				}
				case ChannelEnum.CHANNEL_CAMP:
				{
					container_all_camp.visible = true;
					container_part_camp.visible = true;
					vScrollBar.viewport = container_all_camp;
					break;
				}
				case ChannelEnum.CHANNEL_ARMY_GROUP:
				{
					container_all_group.visible = true;
					container_part_group.visible = true;
					vScrollBar.viewport = container_all_group;
					break;
				}
				case ChannelEnum.CHANNEL_PRIVATE:
				{
					container_all_private.visible = true;
					container_part_private.visible = true;
					vScrollBar.viewport = container_all_private;
					break;
				}
			}
		}
		
		//向对应的显示框中添加数据
		private function allContainerAddData(item:ChatInforIten,channel:String):void
		{
			switch(channel)
			{
				case ChannelEnum.CHANNEL_WORLD:
				{
					container_all_word.add(item);
					container_all_word.layout.update();
					container_all_word.layout.vGap = DISTANCE_COUNT;
					break;
				}
				case ChannelEnum.CHANNEL_CAMP:
				{
					container_all_camp.add(item);
					container_all_camp.layout.update();
					container_all_camp.layout.vGap = DISTANCE_COUNT;
					break;
				}
				case ChannelEnum.CHANNEL_ARMY_GROUP:
				{
					container_all_group.add(item);
					container_all_group.layout.update();
					container_all_group.layout.vGap = DISTANCE_COUNT;
					break;
				}
				case ChannelEnum.CHANNEL_PRIVATE:
				{
					container_all_private.add(item);
					container_all_private.layout.update();
					container_all_private.layout.vGap = DISTANCE_COUNT;
					break;
				}
			}
		}
		
		//向对应的显示框中添加数据
		private function partContainerAddData(partItem:ChatInforIten,channel:String):void
		{
			switch(channel)
			{
				case ChannelEnum.CHANNEL_WORLD:
				{
					container_part_word.add(partItem);
					container_part_word.layout.update();
					container_part_word.layout.vGap = DISTANCE_COUNT;
					break;
				}
				case ChannelEnum.CHANNEL_CAMP:
				{
					container_part_camp.add(partItem);
					container_part_camp.layout.update();
					container_part_camp.layout.vGap = DISTANCE_COUNT;
					break;
				}
				case ChannelEnum.CHANNEL_ARMY_GROUP:
				{
					container_part_group.add(partItem);
					container_part_group.layout.update();
					container_part_group.layout.vGap = DISTANCE_COUNT;
					break;
				}
				case ChannelEnum.CHANNEL_PRIVATE:
				{
					container_part_private.add(partItem);
					container_part_private.layout.update();
					container_part_private.layout.vGap = DISTANCE_COUNT;
					break;
				}
			}
		}
		
		//当数据改变后，对相应的部分显示框进行处理
		private function getContainerByChannel(channel:String):Container
		{
			var container:Container;
			switch(channel)
			{
				case ChannelEnum.CHANNEL_WORLD:
				{
					container = container_part_word;
					break;
				}
				case ChannelEnum.CHANNEL_CAMP:
				{
					container = container_part_camp;
					break;
				}
				case ChannelEnum.CHANNEL_ARMY_GROUP:
				{
					container = container_part_group;
					break;
				}
				case ChannelEnum.CHANNEL_PRIVATE:
				{
					container = container_part_private;
					break;
				}
			}
			return container;
		}
		
		//加入军团或退出军团时都要清理聊天数据
		public function deletedData():void
		{
			while(container_all_word.num >0)
			{
				DisposeUtil.dispose(container_all_word.removeAt(0));
			}
			while(container_all_camp.num >0)
			{
				DisposeUtil.dispose(container_all_camp.removeAt(0));
			}
			while(container_all_group.num >0)
			{
				DisposeUtil.dispose(container_all_group.removeAt(0));
			}
			while(container_all_private.num >0)
			{
				DisposeUtil.dispose(container_all_private.removeAt(0));
			}
			
			while(container_part_word.num >0)
			{
				DisposeUtil.dispose(container_part_word.removeAt(0));
			}
			while(container_part_camp.num >0)
			{
				DisposeUtil.dispose(container_part_camp.removeAt(0));
			}while(container_part_group.num >0)
			{
				DisposeUtil.dispose(container_part_group.removeAt(0));
			}while(container_part_private.num >0)
			{
				DisposeUtil.dispose(container_part_private.removeAt(0));
			}
		}
		
		//退出军团后聊天按钮的切换
		public function changeArmyGroupBtn():void
		{
			wordBtn_clickHandler(null);
		}

		private var chatFaceComponent:ChatFaceComponent;
		//聊天表情选择面板
		private function faceBtn_clickHandler(event:MouseEvent):void
		{
			if(chatFaceComponent)
			{
				chatFaceComponent.visible = true;
			}
			else
			{
				chatFaceComponent = new ChatFaceComponent();
				chatFaceComponent.mouseEnabled = chatFaceComponent.mouseChildren = true;
				chatFaceComponent.x = event.target.x - 95;
				chatFaceComponent.y = event.target.y - chatFaceComponent.height -40;
	//			SystemManager.instance.addInfo(chatFaceComponent);
				addChild(chatFaceComponent);
			}
				 
			chatFaceComponent.addEventListener(ChatEvent.SELECTED_CHAT_FACE,chatFaceHandler);
			chatFaceComponent.addEventListener("closeBtnInChatFace",closeBtnInChatFaceHandler);
		}
		
		private function chatFaceHandler(event:ChatEvent):void
		{
			selectedFace = event.obj as String;
			if(_channelSelected == ChannelEnum.CHANNEL_PRIVATE)
			{
				inforTxt.insertGraphics("FACE_"+selectedFace);
			}
			else
			{
				chatText.insertGraphics("FACE_"+selectedFace);
			}
			chatFaceComponent.visible = false;
		}
		private function closeBtnInChatFaceHandler(event:Event):void
		{
			chatFaceComponent.visible = false;
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
			}
			
            var timeStr:String;
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
                timeStr = DateFormatter.formatterTime(data.timeStamp / 1000);
                str = "<p color = '{0}'><s>{1}</s><s></s><s>{2}</s><s>[</s><s>{3}</s><s>]</s></p>";
                str = StringUtil.formatString(str, color, "系统广播:", data.str, timeStr);
            }
            else
            {
                if (int(data.channel) > 10)
                {
                    if (dataObj.myID == userInforProxy.userInfoVO.player_id)
                    {
						var obj1:Object = {playerVIP:dataObj.otherVIP,playerID:dataObj.otherID,playerName:dataObj.otherName};
						var str1:String=JSON.stringify(obj1);
						var t1:String = String.fromCharCode(11);
						str1 = str1.replace(/\"/g,t1);
						//发送者的显示设置
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0xd1e4ff'><s>我对</s><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s><s>说：</s><s>{3}</s><s>[{4}]</s></p>";
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
                        str = "<p color = '0x22afe5'><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s><s>对我说：</s><s>{3}</s><s>[{4}]</s></p>";
                        str = StringUtil.formatString(str, dataObj.myVIP,str2,dataObj.myName,dataObj.textStr,timeStr);
                    }

                }
                else
                {
                    if (data.myID == userInforProxy.userInfoVO.player_id)
                    {
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0xd1e4ff'><s>{0}</s><s>[</s><s>{1}</s><s>]</s></p>";
                        str = StringUtil.formatString(str,data.str, timeStr);
                    }
                    else
                    {
                        timeStr = DateFormatter.formatterTime(data.timeStamp/1000);
                        str = "<p color = '0x22afe5'><s>{0}</s><s>[</s><s>{1}</s><s>]</s></p>";
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
