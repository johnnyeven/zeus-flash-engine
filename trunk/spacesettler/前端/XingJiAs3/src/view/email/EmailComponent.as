package view.email
{
	import com.adobe.fileformats.vcard.Email;
	import com.zn.utils.ClassUtil;
	
	import events.email.EmailEvent;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.email.EmailProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.email.EmailItemVO;
	
	/**
	 *邮件
	 * @author lw
	 *
	 */
    public class EmailComponent extends Window
    {
		public var vScrollBar:VScrollBar; //拖动条
		
		public var receiveEmailBtn:Button;
		public var sendEmailBtn:Button;
		public var deleteEmailBtn:Button;
		public var deleteSuccessBtn:Button;
		public var closeBtn:Button;
		public var deleteAllBtn:Button;
		
		public var emailCountLabel:Label;
		
		private var container:Container;
		
		private var currentCount:int = 0;
		private var isDelete:Boolean;
		
		private var emailProxy:EmailProxy;
		private var arr:Array = [];
        public function EmailComponent()
        {
            super(ClassUtil.getObject("view.email.EmailSkin"));
			emailProxy = ApplicationFacade.getProxy(EmailProxy);
			
			container = new Container(null);
			container.contentWidth = 316;
			container.contentHeight = 360;
			container.layout = new HTileLayout(container);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.x = 12;
			container.y = 94;
			addChild(container);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			
			receiveEmailBtn = createUI(Button,"receiveEmailBtn");
			sendEmailBtn = createUI(Button,"sendEmailBtn");
			closeBtn  = createUI(Button,"closeBtn");
			deleteEmailBtn = createUI(Button,"deleteEmailBtn");
			deleteSuccessBtn = createUI(Button,"deleteSuccessBtn");
			deleteAllBtn = createUI(Button,"deleteAllBtn");
			emailCountLabel = createUI(Label,"emailCountLabel");
			emailCountLabel.text = "";
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange,emailProxy,"emailList"));
			cwList.push(BindingUtils.bindSetter(function():void
			{
				emailCountLabel.text = emailProxy.emailCount +"/" +emailProxy.emailCount +"";
			},emailProxy,"emailCount"));
			//刷新邮件列表
			receiveEmailBtn.addEventListener(MouseEvent.CLICK,receiveEmailBtn_clickHandler);
			sendEmailBtn.addEventListener(MouseEvent.CLICK,sendEmailBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHAnd);
			
			deleteEmailBtn.visible = true;
			deleteEmailBtn.addEventListener(MouseEvent.CLICK,deleteEmailBtn_clickHandler);
			deleteSuccessBtn.visible = false;
			deleteSuccessBtn.addEventListener(MouseEvent.CLICK,deleteSuccessBtn_clickHandler);
			deleteAllBtn.addEventListener(MouseEvent.CLICK,deleteAllBtn_clickHandler);
		}
		
		
		private function itemVOListChange(value:*,bool:Boolean = false):void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
			
			 arr = value as Array;
			 if(arr.length>0)
			 {
//				 emailCountLabel.text = (arr[0] as EmailItemVO).mails_count +"/" +(arr[0] as EmailItemVO).mails_count +"";
			    for (var i:int = 0; i < arr.length; i++)
				{
					var emailItem:EmailItem = new EmailItem();
					emailItem.data = arr[i];
					emailItem.isDelete = bool;
					emailItem.addEventListener(MouseEvent.CLICK, emailItem_clickHandler);
					emailItem.dyData = i;
					
					container.add(emailItem);
				}
				
				container.layout.update();
				
				vScrollBar.update();
			 }
			
		}
		
		private function emailItem_clickHandler(event:MouseEvent):void
		{
//			event.stopImmediatePropagation();
			var emailItemVO:EmailItemVO = (event.currentTarget as EmailItem).data
             dispatchEvent(new EmailEvent(EmailEvent.SHOW_EMAIL_INFOR_EVENT,emailItemVO));
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
		
		private function closeBtn_clickHAnd(event:MouseEvent):void
		{
			dispatchEvent(new EmailEvent(EmailEvent.CLOSE_EVENT));
		}
		private function sendEmailBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new EmailEvent(EmailEvent.SEND_EMAIL_EVENT));
		}
		
		private function receiveEmailBtn_clickHandler(event:MouseEvent):void
		{
			deleteEmailBtn.visible = true;
			deleteSuccessBtn.visible = false;
			dispatchEvent(new EmailEvent(EmailEvent.RECEIVE_EMAIL_EVENT));
		}
			
		protected function deleteAllBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var arrJson:Array = [];
			var emialID:int;
			for(var i:int = 0;i<arr.length;i++)
			{
				if((arr[i] as EmailItemVO).is_read == true)
				{
					emialID = int((arr[i] as EmailItemVO).id);
					arrJson.push(emialID);
				}
			}
			deleteEmailBtn.visible = true;
			deleteSuccessBtn.visible = false;
			dispatchEvent(new EmailEvent(EmailEvent.DELETE_ALL_READ_EMAIL_EVENT,arrJson));
		}
		
		protected function deleteSuccessBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			deleteEmailBtn.visible = true;
			deleteSuccessBtn.visible = false;
			//隐藏删除小按钮
			isDelete = false;
			itemVOListChange(arr,isDelete);
		}
		
		protected function deleteEmailBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			deleteEmailBtn.visible = false;
			deleteSuccessBtn.visible = true;
			//显示删除小按钮
			isDelete = true;
			itemVOListChange(arr,isDelete);
		}
		
		
    }
}