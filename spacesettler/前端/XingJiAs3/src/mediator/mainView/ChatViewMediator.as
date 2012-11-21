package mediator.mainView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.chat.ChannelEnum;
	import enum.item.ItemEnum;
	
	import events.friendList.FriendListEvent;
	import events.talk.TalkEvent;
	
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.setTimeout;
	
	import mediator.BaseMediator;
	import mediator.cangKu.ChaKanDaoJuViewComponentMediator;
	import mediator.cangKu.ChaKanGuaJianViewComponentMediator;
	import mediator.cangKu.ChaKanTuZhiViewComponentMediator;
	import mediator.cangKu.ChaKanZhanCheViewComponentMediator;
	import mediator.friendList.FriendListComponentMediator;
	import mediator.friendList.ViewIdCardComponentMediator;
	import mediator.prompt.PromptMediator;
	import mediator.prompt.PromptSureMediator;
	import mediator.showBag.ShowBagComponentMediator;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.UIComponent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.chat.ChatProxy;
	import proxy.friendList.FriendProxy;
	import proxy.packageView.PackageViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Label;
	
	import view.mainView.ChatSelectedComponent;
	import view.mainView.ChatViewComponent;
	
	import vo.allView.FriendInfoVo;
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ItemVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.chat.ChatItemVO;
	import vo.chat.ChatVO;

	/**
	 * 聊天
	 * @author lw
	 *
	 */
	public class ChatViewMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChatViewMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static const INFOR_NOTE:String="infor" + NAME + "Note";

		public static const SHOW_ZHANCHE:String="show" + NAME + "zhanChe";
		/**
		 * 查看军官证
		 */
		public static const SHOW_CHECKID:String="show" + NAME + "checkID";
		/**
		 * 通过聊天框选择的私聊
		 */
		public static const SHOW_PRIVATE_TALK:String="show" + NAME + "privateTalk";
		/**
		 * 复制聊天内容到剪切板
		 */
		public static const SHOW_COPY_INFOR:String="show" + NAME + "copyInfor";
		/**
		 * 通过好友列表选择的私聊
		 */
		public static const SHOW_PRIVATE_TALK_SELECTED_BY_FRIENDLIST:String="show" + NAME + "privateTalkSelectedByFriendList";

//		public static const SHOW_GUAJIAN:String = "show" + NAME + "guaJian";

//		public static const SHOW_TUZHI:String = "show" + NAME + "tuZhi";
		/**
		 * 加入军团时的数据处理
		 */
		public static const ADD_INTO_ARMY_GROUP:String="addInto" + NAME + "armyGroup";
		/**
		 * 退出军团时的数据处理
		 */
		public static const GO_OUT_ARMY_GROUP:String="goOut" + NAME + "armyGroup";

		private var chatProxy:ChatProxy;

		private var packageViewproxy:PackageViewProxy;

		private var userInforProxy:UserInfoProxy;

		private var friendProxy:FriendProxy;

		private var itemDic:Object={};

		private var key:String="";

		private var vip:String="";

		private var playerID:String="";

		private var playerName:String="";
		//选择玩家的数据
		private var obj:Object={};
		//是否存在选择弹出框
		private var isHave:Boolean;
		//是否是通过好友列表选择的私聊
		private var isFriendList:Boolean;
		private var chatSelectedComponent:ChatSelectedComponent;

		//再次发送时间已过，是否能发送信息
		private var _canChat:Boolean=true;

		public function ChatViewMediator(obj:ChatViewComponent)
		{
			super(NAME, obj);

			chatProxy=getProxy(ChatProxy);
			packageViewproxy=getProxy(PackageViewProxy);
			userInforProxy=getProxy(UserInfoProxy);
			friendProxy=getProxy(FriendProxy);

			comp.addEventListener(FriendListEvent.FRIEND_LIST_EVENT, showFriendListHAndler);
			comp.addEventListener(TalkEvent.TALK_EVENT, talkingHandler);
			comp.addEventListener(TextEvent.LINK, linkHandler);

			comp.addEventListener(TalkEvent.SHOW_BAG_COMPONENT_EVENT, showBagComponentHandler);
			comp.addEventListener("tipsInChatArmyGroup", tipsHandler);

		}

		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, DESTROY_NOTE, INFOR_NOTE, SHOW_ZHANCHE, SHOW_CHECKID, SHOW_PRIVATE_TALK, SHOW_PRIVATE_TALK_SELECTED_BY_FRIENDLIST, ADD_INTO_ARMY_GROUP, GO_OUT_ARMY_GROUP, SHOW_COPY_INFOR];
		}

		/**
		 *消息处理
		 * @param note
		 *
		 */
		override public function handleNotification(note:INotification):void
		{
			var name:String="";
			key=name;
			switch (note.getName())
			{
				case SHOW_NOTE:
				{
					show();
					break;
				}
				case DESTROY_NOTE:
				{
					//销毁对象
					destroy();
					break;
				}
				case INFOR_NOTE:
				{
					//信息处理
					var obj:Object=note.getBody();
					comp.dataChange(obj as ChatVO);

					break;
				}
				case SHOW_ZHANCHE:
				{
					//展示
					var baseItemVO:BaseItemVO=note.getBody() as BaseItemVO;
					name=baseItemVO.name;
					itemDic[name]=baseItemVO;
					comp.setLabel(("[" + name + "]"));
					break;
				}
				case SHOW_CHECKID:
				{
					//通过聊天框选择的查看军官证
					isFriendList=false;
					checkIdCardHandler(note.getBody() as String);
					comp.mainMediater_clickHandler(null);
					break;
				}
				case SHOW_PRIVATE_TALK:
				{
					//通过聊天框选择的私聊
					isFriendList=false;
					privateTalkHandler(note.getBody());
					comp.mainMediater_clickHandler(null);
					break;
				}
				case SHOW_COPY_INFOR:
				{
					//复制聊天内容
					isFriendList=false;
					System.setClipboard(note.getBody() as String);
					comp.mainMediater_clickHandler(null);
					break;
				}
				case SHOW_PRIVATE_TALK_SELECTED_BY_FRIENDLIST:
				{
					//通过好友列表选择的私聊
					isFriendList=true;
					privateTalkByFriendListHandler(note.getBody() as FriendInfoVo);
					break;
				}
				case ADD_INTO_ARMY_GROUP:
				{
					//加入军团时的数据处理
					comp.deletedData();
				}
				case GO_OUT_ARMY_GROUP:
				{
					//退出军团时的数据处理
					comp.deletedData();
					comp.changeArmyGroupBtn();
				}
				/*				case SHOW_GUAJIAN:
								{
									//挂件的展示
									var guaJianInfoVO:GuaJianInfoVO = note.getBody() as GuaJianInfoVO;
									name = guaJianInfoVO.name;
									itemDic[name] = guaJianInfoVO;
									itemDic[name].type = 2;

									comp.setLabel(("["+name+"]"));
									break;
								}
								case SHOW_TUZHI:
								{
									//图纸的展示
									var tuZhiVO:ItemVO = note.getBody() as ItemVO;
									name = tuZhiVO.name;
									itemDic[name] = tuZhiVO;
									itemDic[name].type = 3;

									comp.setLabel(("["+name+"]"));
									break;
								}*/
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():ChatViewComponent
		{
			return viewComponent as ChatViewComponent;
		}

		//数据处理
		private function setDat(text:String):String
		{
			for (key in itemDic)
			{
				var pattern:RegExp=new RegExp(key, "g");
				var item:BaseItemVO=itemDic[key];
				var arr:Array=[];
				arr=text.match(pattern);
				for (var i:int=0; i < arr.length; i++)
				{
					if (item.item_type == ItemEnum.Chariot)
					{

						text=text.replace(key, StringUtil.formatString("</s><a value = '{0}'><s color = '0x7d2df4'>{1}</s></a><s>", "ZhanChe_" + (item as ZhanCheInfoVO).id, (item as ZhanCheInfoVO).name));
					}
					else if (item.item_type == ItemEnum.TankPart)
					{
						text=text.replace(key, StringUtil.formatString("</s><a value = '{0}'><s color = '0x7d2df4'>{1}</s></a><s>", "GuaJian_" + (item as GuaJianInfoVO).id, (item as GuaJianInfoVO).name));
					}
					else if (item.item_type == ItemEnum.recipes)
					{
						text=text.replace(key, StringUtil.formatString("</s><a value = '{0}'><s color = '0x7d2df4'>{1}</s></a><s>", "TuZhi_" + (item as ItemVO).id, (item as ItemVO).name));
					}
					else if (item.item_type == ItemEnum.item)
					{
						text=text.replace(key, StringUtil.formatString("</s><a value = '{0}'><s color = '0x7d2df4'>{1}</s></a><s>", "Item_" + (item as ItemVO).category, (item as ItemVO).name));
					}
				}


			}


			var str:String="";
			if (comp.channelSelected == ChannelEnum.CHANNEL_PRIVATE)
			{
				//处理text内容
				var textXMl:XML=new XML(text);
				var tt:String=textXMl.children().toXMLString();
				//TODO LW:用特殊字符替换规定：< - @=64;s - #;> - $=36;/ - %=0;g - &=38
				//用特殊字符替换规定：< - &lt; > - &gt;
				tt=tt.replace(/\</g, '&lt;');
				tt=tt.replace(/\>/g, '&gt;');
				var privateObj:Object={};
				if (isFriendList == true)
				{
					//通过好友列表选择的私聊
					var friendInforVo:FriendInfoVo=obj as FriendInfoVo;
					privateObj={myVIP: userInforProxy.userInfoVO.vip_level, myID: userInforProxy.userInfoVO.player_id, myName: userInforProxy.userInfoVO.nickname,
							otherVIP: friendInforVo.vip_level, otherID: friendInforVo.id, otherName: friendInforVo.nickname, textStr: tt};
				}
				else
				{
					//通过聊天框选择的私聊
					privateObj={myVIP: userInforProxy.userInfoVO.vip_level, myID: userInforProxy.userInfoVO.player_id, myName: userInforProxy.userInfoVO.nickname,
							otherVIP: obj.otherVIP, otherID: obj.otherID, otherName: obj.otherName, textStr: tt};
				}
				var str2:String=JSON.stringify(privateObj);
				str=StringUtil.formatString("</s><a value = '{0}'></a><s>", str2);
			}
			else
			{
				var obj1:Object={};
				//是否加入了阵营
				if (comp.channelSelected == ChannelEnum.CHANNEL_CAMP)
				{
					obj1={myVIP: userInforProxy.userInfoVO.vip_level, myID: userInforProxy.userInfoVO.player_id, myName: userInforProxy.userInfoVO.nickname, campID: userInforProxy.userInfoVO.camp};
				}
				else
				{
					obj1={myVIP: userInforProxy.userInfoVO.vip_level, myID: userInforProxy.userInfoVO.player_id, myName: userInforProxy.userInfoVO.nickname};
				}

				var str1:String=JSON.stringify(obj1);
				var t:String=String.fromCharCode(11);
				str1=str1.replace(/\"/g, t);
//				var pattern1:RegExp = new RegExp(,"g");
//				str1 = str1.replace("/\"/g","*");
//		        obj=JSON.parse(str);
				//添加玩家名字和VIP
				var textXMl1:XML=new XML(text);
				var tt1:String=textXMl1.children().toXMLString();
				str="</s><g>/{0}</g><s>[</s><a value = '{1}'><s>{2}</s></a><s>]</s>{3}<s>";
				str=StringUtil.formatString(str, userInforProxy.userInfoVO.vip_level, str1, userInforProxy.userInfoVO.nickname, tt1);
//				str = StringUtil.formatString(str,userInforProxy.userInfoVO.vip_level,userInforProxy.userInfoVO.player_id,userInforProxy.userInfoVO.userName,text);
			}


			return str;
		}


		private function showFriendListHAndler(event:FriendListEvent):void
		{
			var obj:Object={playerID: userInforProxy.userInfoVO.player_id};
			sendNotification(FriendListComponentMediator.SHOW_NOTE, obj);
		}

		private function talkingHandler(event:TalkEvent):void
		{
			if (!_canChat)
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString("canNotCharTips"));
				return;
			}
			
			var str:String=event.talk;
			str=setDat(str);
			if (comp.channelSelected == ChannelEnum.CHANNEL_PRIVATE)
			{
				if (isFriendList == true)
				{
					//通过好友列表选择的私聊
					chatProxy.talking(str, (obj as FriendInfoVo).id);
				}
				else
				{
					//通过聊天框选择的私聊
					chatProxy.talking(str, obj.otherID);
				}
			}
			else
			{
				chatProxy.talking(str, event.channel);
			}

			_canChat=false;
			setTimeout(function():void
			{
				_canChat=true;
			}, 3000);

		}

		private function linkHandler(event:TextEvent):void
		{
			var idString:String;
			if (event.text.indexOf("ZhanChe_") != -1)
			{
				idString=event.text.replace("ZhanChe_", "");
				packageViewproxy.getChariotInfo(idString, function():void
				{
					sendNotification(ChaKanZhanCheViewComponentMediator.DESTROY_NOTE);
					sendNotification(ChaKanZhanCheViewComponentMediator.SHOW_NOTE);
				});
			}
			else if (event.text.indexOf("GuaJian_") != -1)
			{
				idString=event.text.replace("GuaJian_", "");
				packageViewproxy.getTankPartInfo(idString, function():void
				{
					sendNotification(ChaKanGuaJianViewComponentMediator.DESTROY_NOTE);
					sendNotification(ChaKanGuaJianViewComponentMediator.SHOW_NOTE);
				});
			}
			else if (event.text.indexOf("TuZhi_") != -1)
			{
				idString=event.text.replace("TuZhi_", "");
				packageViewproxy.getDaoJuVOByID(idString, function():void
				{
					sendNotification(ChaKanTuZhiViewComponentMediator.DESTROY_NOTE);
					sendNotification(ChaKanTuZhiViewComponentMediator.SHOW_NOTE);
				});
			}
			else if (event.text.indexOf("Item_") != -1)
			{
				idString=event.text.replace("Item_", "");
				packageViewproxy.getDaoJuVOByID(idString, function():void
				{
					sendNotification(ChaKanDaoJuViewComponentMediator.DESTROY_NOTE);
					sendNotification(ChaKanDaoJuViewComponentMediator.SHOW_NOTE);
				});
			}
			else
			{
				//将特殊字符转换回来
				var t:String=String.fromCharCode(11);
				var re:RegExp=new RegExp(t, "g");
				event.text=event.text.replace(re, '"');
				var obj1:Object={};
				obj1=JSON.parse(event.text);
				if (obj1.otherID)
				{
					friendProxy.checkOtherPlayer(obj1.otherID, function():void
					{
						sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
					});
				}
				else
				{
					friendProxy.checkOtherPlayer(obj1.myID, function():void
					{
						sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
					});
				}

				/*if(!isHave)
				{
				  chatSelectedComponent = new ChatSelectedComponent();
				  var mainMediater:MainViewMediator = getMediator(MainViewMediator);
				  mainMediater.comp.addChild(chatSelectedComponent);
				  isHave = true;
				}

				var point:Point = new Point((comp.currentTarget as Label).x,(comp.currentTarget as Label).y);
				point = (comp.currentTarget as Label).localToGlobal(point);
//				chatSelectedComponent.x = (comp.currentTarget as Label).x;
				chatSelectedComponent.x = point.x;
//				chatSelectedComponent.y = (comp.currentTarget as Label).y;
				chatSelectedComponent.y = point.y;
				//将特殊字符转换回来
				var t:String=String.fromCharCode(11);
				var re:RegExp=new RegExp(t,"g");
				event.text=event.text.replace(re,'"');

				chatSelectedComponent.data = event.text;*/

			}

		}

		private function checkIdCardHandler(talk:String):void
		{
//			isHave = false;
//			obj=JSON.parse(talk);
			friendProxy.checkOtherPlayer(talk, function():void
			{
				sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
			});
		}

		private function privateTalkHandler(_obj:Object):void
		{
//			isHave = false;
			obj=_obj;
			comp.privateChatName=obj.otherName;
			comp.privateChatHandler();

		}

		private function privateTalkByFriendListHandler(friendinforVO:FriendInfoVo):void
		{
			//通过好友列表选择的私聊
			obj=friendinforVO;
			comp.privateChatName=friendinforVO.nickname;
			comp.privateChatHandler();

		}

		private function showBagComponentHandler(event:TalkEvent):void
		{
			sendNotification(ShowBagComponentMediator.SHOW_NOTE);
		}

		private function tipsHandler(event:Event):void
		{
			var obj:Object={infoLable: MultilanguageManager.getString("titleInChat"), showLable: MultilanguageManager.getString("inforInChat")};
			sendNotification(PromptSureMediator.SHOW_NOTE, obj);
		}

		/***********************************************************
		 *
		 * 功能方法
		 *
		 * ****************************************************/
		private function setString(data:ChatItemVO):String
		{
			if (data.str.hasOwnProperty("@value"))
			{
				var userData:String=data.str[0].value;
			}

			var timeStr:String;
			var dataObj:Object=JSON.parse(userData);
			var str:String
			if (dataObj.myID == userInforProxy.userInfoVO.player_id)
			{
				//发送者显示设置
				timeStr=DateFormatter.formatterTime(data.timeStamp);
				str="<p color = '0xc3d4e8'><s>{0}</s><s>[</s><s>{1}</s><s>]</s></p>";
				str=StringUtil.formatString(str, data.str, timeStr);
			}
			else
			{
				timeStr=DateFormatter.formatterTime(data.timeStamp);
				str="<p color = '0x5283ae'><s>{0}</s><s>[</s><s>{1}</s><s>]</s></p>";
				str=StringUtil.formatString(str, data.str, timeStr);
			}

			return str;
		}
	}
}
