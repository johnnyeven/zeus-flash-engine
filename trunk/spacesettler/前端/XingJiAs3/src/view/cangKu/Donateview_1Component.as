package view.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import events.cangKu.DonateEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.core.Component;
	
    public class Donateview_1Component extends Component
    {
		public var Num_tf:TextField;
		public var close_btn:Button;
		public var donate_btn:Component;

		
        public function Donateview_1Component()
        {
            super(ClassUtil.getObject("Donateview_1"));
			
			donate_btn=createUI(Button,"donate_btn");
			close_btn=createUI(Button,"close_btn");
			Num_tf=getSkin("Num_tf");
			
			sortChildIndex();
			
			Num_tf.mouseEnabled=true;
			
			Num_tf.restrict="0-9";
			close_btn.addEventListener(MouseEvent.CLICK,closeHandler);
			donate_btn.addEventListener(MouseEvent.CLICK,donateHandler);
		}
		
		protected function donateHandler(event:MouseEvent):void
		{
			dispatchEvent(new DonateEvent(DonateEvent.DONATE_EVENT,null,null,int(Num_tf.text)));			
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new DonateEvent(DonateEvent.CLOSE_EVENT));
		}
    }
}