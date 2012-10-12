package view.mainView
{
	import events.friendList.FriendListEvent;
	import events.talk.TalkEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.TextInput;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	public class ChatViewComponent extends Component
	{
		/**
		 * 聊天输入框	
		 */		
		public var chatText:TextInput;
		
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
		public var partShowContainer:Container;
		
		/**
		 *表情按钮 
		 */		
		public var faceBtn:MovieClip;
		
		private var chatString:String = "";
		
		public function ChatViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			chatText=createUI(TextInput,"liaotian_tf");
			sendBtn=createUI(Button,"fasong_btn");
			friendBtn=createUI(Button,"haoyou_btn");
			wordBtn=createUI(Button,"shijie_btn");
			campBtn=createUI(Button,"zhenying_btn");
			armyGroupBtn=createUI(Button,"juntuan_btn");
			privateChatBtn=createUI(Button,"siliao_btn");
			hyperlinkBtn=createUI(Button,"chaolianjie_btn");
			
			upBtn=getSkin("up_btn");
			downBtn=getSkin("down_btn");
			faceBtn=getSkin("biaoqing_mc");
			var biaoqing_mc:Sprite=getSkin("biaoqing_mc");
			
			allShowSprite = createUI(Component,"allShowSprite");
			vScrollBar = allShowSprite.createUI(VScrollBar,"vScrollBar");
			allShowContainer = allShowSprite.createUI(Container,"allShowContainer");
			allShowSprite.sortChildIndex();
			
			partShowSprite = createUI(Component,"partShowSprite");
			partShowContainer = partShowSprite.createUI(Container,"partShowContainer");
			partShowSprite.sortChildIndex();
			
			sortChildIndex();
			
			chatString = chatText.text;
			chatText.addEventListener(TextEvent.TEXT_INPUT,textChange_handler);
			chatText.addEventListener(KeyboardEvent.KEY_DOWN,keyDown_clickHandler);
			
			allShowContainer.layout = new HTileLayout(allShowContainer);
			partShowContainer.layout = new HTileLayout(partShowContainer);
			
			vScrollBar.viewport = allShowContainer;
			biaoqing_mc.visible = downBtn.visible = allShowSprite.visible = false;
			upBtn.mouseEnabled = downBtn.mouseEnabled = true;
			chatText.mouseChildren = chatText.mouseEnabled = true;
			
			upBtn.addEventListener(MouseEvent.CLICK,upBtn_clickHandler);
			downBtn.addEventListener(MouseEvent.CLICK,downBtn_clickHandler);
			friendBtn.addEventListener(MouseEvent.CLICK,friendBtn_clickHandler);
			sendBtn.addEventListener(MouseEvent.CLICK,send_clickHandler);
		}
		
		private function setDat(value:Array):void
		{
			while(allShowContainer.num)
				DisposeUtil.dispose(allShowContainer.removeAt(0));
			while(partShowContainer.num)
				DisposeUtil.dispose(partShowContainer.removeAt(0));
			var itemLabel:Label;
			if(value.length>0)
			{
				for(var i:int = 0;i<value.length;i++)
				{
					itemLabel = new Label();
					itemLabel.text = value[i];
					allShowContainer.add(itemLabel);
					partShowContainer.add(itemLabel);
//					itemLabel.addEventListener(
				}
				allShowContainer.layout.update();
				partShowContainer.layout.update();
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
			if(chatString == "")
			    return;
			dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT,chatString));
		}
		
		private function textChange_handler(event:TextEvent):void
		{
			
		}
		
		private function keyDown_clickHandler(event:KeyboardEvent):void
		{
			if(event.charCode == 13 && chatString != "")
				dispatchEvent(new TalkEvent(TalkEvent.TALK_EVENT,chatString));
		}
	}
}