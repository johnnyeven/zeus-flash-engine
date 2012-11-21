package view.battle.build
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import events.buildingView.ConditionEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.VLayout;
	import ui.utils.DisposeUtil;
	
	import view.buildingView.ConditionClickBtnComp;
	import view.buildingView.ConditionItemComp;
	
	/**
	 *战场编辑条件弹出框
	 * @author lw
	 *
	 */
    public class battleEditorConditionComponent extends Component
    {
		public var closeBtn:Button;
		public var vScrollBar:VScrollBar;
		public var container:Container;
		
		private var _itemComp:ConditionItemComp;
		
        public function battleEditorConditionComponent()
        {
            super(ClassUtil.getObject("battle.battleEditorConditionSkin"));
			closeBtn = createUI(Button, "close_button");
			
			container =createUI(Container,"container");
			container.layout = new VLayout(container);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHandler);
		}
		
		public function setValue(arr:Array):void
		{
			removeAllItem();
			
			for(var i:int=0;i<arr.length;i++)
			{
				_itemComp = new ConditionItemComp();
				_itemComp.imgSource=arr[i].imgSource;
				_itemComp.text=arr[i].content;
				_itemComp.labelOfBtn=arr[i].btnLabel;
				
				_itemComp.conditionBtn.addEventListener(MouseEvent.CLICK,conditionBtn_clickHandler);
				container.add(_itemComp);
			}
			container.layout.update();
		}
		
		protected function conditionBtn_clickHandler(event:MouseEvent):void
		{
			var btn:ConditionClickBtnComp=event.currentTarget as ConditionClickBtnComp;
			switch(btn.text)
			{
				case MultilanguageManager.getString("buy_click"):
					dispatchEvent(new ConditionEvent(ConditionEvent.DUIHUAN_EVENT));
					break;
				case MultilanguageManager.getString("produce_click"):
					dispatchEvent(new ConditionEvent(ConditionEvent.SHENGCHAN_EVENT));
					break;
				case MultilanguageManager.getString("up_science"):
					dispatchEvent(new ConditionEvent(ConditionEvent.SHENGJIKEJI_EVENT));
					break;
				case MultilanguageManager.getString("study_click"):
					dispatchEvent(new ConditionEvent(ConditionEvent.YANJIU_EVENT));
					break;
				case MultilanguageManager.getString("up_center"):
					dispatchEvent(new ConditionEvent(ConditionEvent.SHENGJI_EVENT));
					break;
				case MultilanguageManager.getString("build_click"):
					dispatchEvent(new ConditionEvent(ConditionEvent.CREATEKEJI_EVENT));
			}
			
		}
		
		public function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ConditionEvent(ConditionEvent.CLOSE_EVENT));
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
    }
}