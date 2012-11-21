package view.mainView
{
	import com.zn.utils.ClassUtil;
	
	import events.talk.ChatEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.registerClassAlias;
	import flash.utils.getDefinitionByName;
	
	import ui.components.Button;
	import ui.core.Component;
	import ui.layouts.VTileLayout;
	import ui.managers.PopUpManager;

	/**
	 * 聊天表情选择面板
	 * @author lw
	 * 
	 */	
	public class ChatFaceComponent extends Component
	{
		public static const FACE_COUNT:int = 24;
		public var closeButton:Button;
		public function ChatFaceComponent()
		{
			super(ClassUtil.getObject("mainView.chat.faceComponentSkin"));
			closeButton = createUI(Button,"closeButton");
			sortChildIndex();
			layout=new VTileLayout(this);
			
			var chatMC:MovieClip;
			var num:String;
			for(var i:int = 1;i<=FACE_COUNT;i++)
			{
				num = String(i);
				chatMC = ClassUtil.getObject("FACE_"+num) as MovieClip;
				chatMC.mouseEnabled = chatMC.buttonMode = true;
				chatMC.num = num;
//				registerClassAlias("/"+num,Class(getDefinitionByName("FACE_"+num)));
				chatMC.addEventListener(MouseEvent.CLICK,clickHandler);
				addChild(chatMC);
			}
			layout.hGap = 5;
//			layout.vGap = 5;
			layout.update();
			
			closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
		}
		private function clickHandler(event:MouseEvent):void
		{
			var chat:MovieClip = event.target as MovieClip;
			if(chat.hasOwnProperty("num"))
			{
				dispatchEvent(new ChatEvent(ChatEvent.SELECTED_CHAT_FACE,chat.num));
			}
		}
		
		private function closeButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("closeBtnInChatFace"));
		}
	}
}