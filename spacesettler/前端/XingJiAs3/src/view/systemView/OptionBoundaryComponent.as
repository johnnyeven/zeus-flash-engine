package view.systemView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.SoundUtil;
	
	import enum.SoundEnum;
	
	import events.system.SystemEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.CheckBox;
	import ui.core.Component;
	
    public class OptionBoundaryComponent extends Component
    {
		public static var _ischeck1:Boolean=true;//确定是否有音乐 为真则音乐开着的
		public static var _ischeck2:Boolean=true;//确定是否有音效 为真则音效开着的
		
		/**
		 *返回按钮 
		 */		
		public var fanHuiBtn:Button;
			
		/**
		 *音乐开关 
		 */		
		public var checkBox1:CheckBox;
		
		/**
		 *音效开关 
		 */		
		public var checkBox2:CheckBox;

        public function OptionBoundaryComponent()
        {
            super(ClassUtil.getObject("view.systemView.OptionBoundarySkin"));
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			checkBox1=createUI(CheckBox,"checkbox_1");
			checkBox2=createUI(CheckBox,"checkbox_2");
			
			checkBox1.selected=_ischeck1;
			checkBox2.selected=_ischeck2;
			
			sortChildIndex();
			
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			checkBox1.addEventListener(Event.CHANGE,checkBox1_clickHandler);
			checkBox2.addEventListener(Event.CHANGE,checkBox2_clickHandler);
			
        }
		
		protected function checkBox1_clickHandler(event:Event):void
		{
			_ischeck1=checkBox1.selected;
			if(!_ischeck1)
			{
				SoundUtil.setBG(false);
//				SoundUtil.stop(SoundEnum.bg_music);
//				SoundUtil.stop(SoundEnum.battle_bg_music);
//				SoundUtil.stop(SoundEnum.group_bg_music);
			}else
			{
				SoundUtil.setBG(true);
//				SoundUtil.play(SoundEnum.bg_music,true);
//				SoundUtil.play(SoundEnum.battle_bg_music,true);
//				SoundUtil.play(SoundEnum.group_bg_music,true);
			}
		}
		
		protected function checkBox2_clickHandler(event:Event):void
		{
			_ischeck2=checkBox2.selected;
			if(!_ischeck2)
			{
				SoundUtil.setEffect(false);
			}else
			{
				SoundUtil.setEffect(true);
			}
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.CLOSE));
		}
    }
}