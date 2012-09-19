package view.mainView
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import ui.components.Button;
	import ui.components.TextInput;
	import ui.components.VScrollBar;
	import ui.core.Component;
	
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
		public var juntuanBtn:Button;
		
		/**
		 * 私聊按钮
		 */		
		public var siliaoBtn:Button;
		
		/**
		 * 超链接按钮
		 */		
		public var chaolianjieBtn:Button;
		
		/**
		 *聊天窗口背景上升控制按钮 
		 */		
		public var upBtn:MovieClip;
		
		/**
		 * 聊天窗口背景下降控制按钮
		 */		
		public var downBtn:MovieClip;
		
		/**
		 *聊天窗口背景 
		 */		
		public var backMc:MovieClip;
		
		/**
		 *表情按钮 
		 */		
		public var faceBtn:MovieClip;
		
		/**
		 * 聊天窗口拖动条
		 * @param skin 
		 */		
		public var chatMC:VScrollBar;
		public function ChatViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			chatText=createUI(TextInput,"liaotian_tf");
			sendBtn=createUI(Button,"fasong_btn");
			friendBtn=createUI(Button,"haoyou_btn");
			wordBtn=createUI(Button,"shijie_btn");
			campBtn=createUI(Button,"zhenying_btn");
			juntuanBtn=createUI(Button,"juntuan_btn");
			siliaoBtn=createUI(Button,"siliao_btn");
			chaolianjieBtn=createUI(Button,"chaolianjie_btn");
			chatMC=createUI(VScrollBar,"tuodong_mc");
			
			upBtn=getSkin("up_btn");
			downBtn=getSkin("down_btn");
			backMc=getSkin("back_mc");
			faceBtn=getSkin("biaoqing_mc");
			
			sortChildIndex();
		}
	}
}