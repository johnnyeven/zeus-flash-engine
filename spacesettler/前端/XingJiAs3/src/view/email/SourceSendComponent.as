package view.email
{
	import com.zn.utils.ClassUtil;
	
	import enum.email.EmailTypeEnum;
	import enum.item.ItemEnum;
	
	import events.email.EmailEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	import vo.email.SourceItemVO;
	
	/**
	 *资源库存
	 * @author lw
	 *
	 */
    public class SourceSendComponent extends Window
    {
		public var closeBtn:Button;
		public var okBtn:Button;
		public var sourceImage:LoaderImage;
		public var countTxt:TextField;
		public var tipsLabel:Label;
		public var costLabel:Label;
		
		private var container:Container;
		private var userInforProxy:UserInfoProxy;
		//当前选中的条目
		private var _currendSelected:SourceItem;
		//是否是第一次输入值
		private var isFirst:Boolean = true;
        public function SourceSendComponent()
        {
            super(ClassUtil.getObject("view.email.SourceSendSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			container = new Container(null);
			container.contentWidth = 312;
			container.contentHeight = 190;
			container.layout = new HTileLayout(container);
			container.x = 19;
			container.y = 45;
			addChild(container);
			
			closeBtn = createUI(Button,"closeBtn");
			okBtn = createUI(Button,"okBtn");
			sourceImage = createUI(LoaderImage,"sourceImage");
			countTxt = getSkin("countTxt");
			countTxt.mouseEnabled = true;
			countTxt.restrict = "0-9";
			countTxt.addEventListener(TextEvent.TEXT_INPUT,countTxt_changeHAndler);
//			countTxt.visible = false;
			tipsLabel = createUI(Label,"tipsLabel");
//			tipsLabel.visible = true;
//			tipsLabel.mouseEnabled = true;
//			tipsLabel.addEventListener(MouseEvent.CLICK,tipsLabel_clickHandler);
			costLabel = createUI(Label,"costLabel");
			costLabel.text = "0";
			
			sortChildIndex();
			
			removeCWList();
			
			var arr:Array = [];
			var sourceItemVO1:SourceItemVO = new SourceItemVO();
			    sourceItemVO1.attachment_type = ItemEnum.CRYSTAL;
				cwList.push(BindingUtils.bindProperty(sourceItemVO1,"mySourceCount",userInforProxy,["userInfoVO","crystal"]));
//				sourceItemVO1.mySourceCount = userInforProxy.userInfoVO.crystal;
				arr.push(sourceItemVO1);
			var sourceItemVO2:SourceItemVO = new SourceItemVO();
			    sourceItemVO2.attachment_type = ItemEnum.TRITIUM;
				cwList.push(BindingUtils.bindProperty(sourceItemVO2,"mySourceCount",userInforProxy,["userInfoVO","tritium"]));
//				sourceItemVO2.mySourceCount = userInforProxy.userInfoVO.tritium;
				arr.push(sourceItemVO2);
			var sourceItemVO3:SourceItemVO = new SourceItemVO();
			    sourceItemVO3.attachment_type = ItemEnum.BROKENCRYSTAL;
				cwList.push(BindingUtils.bindProperty(sourceItemVO3,"mySourceCount",userInforProxy,["userInfoVO","broken_crysta"]));
//				sourceItemVO3.mySourceCount = userInforProxy.userInfoVO.broken_crysta;
			    arr.push(sourceItemVO3);
			setData(arr);
			
			okBtn.addEventListener(MouseEvent.CLICK,okBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closedHandler);
        }
		
		private function setData(data:Array):void
		{
			var sourceItem:SourceItem;
			for(var i:int =0;i<data.length;i++)
			{
				sourceItem = new SourceItem();
				sourceItem.data = data[i];
				if(i == 0)
				{
					currendSelected = sourceItem;
				}
				sourceItem.addEventListener(MouseEvent.CLICK,sourceItem_clickHandler);
				container.add(sourceItem);
			}
			container.layout.update();
        }
		
		private function sourceItem_clickHandler(event:MouseEvent):void
		{
			var item:SourceItem = event.currentTarget as SourceItem;
			currendSelected = item;
		}

		public function get currendSelected():SourceItem
		{
			return _currendSelected;
		}

		public function set currendSelected(value:SourceItem):void
		{
			if(_currendSelected)
			{
				_currendSelected.noSelectedBtn.visible = true;
				_currendSelected.selectedBtn.visible = false;
			}
			_currendSelected = value;
			_currendSelected.noSelectedBtn.visible = false;
			_currendSelected.selectedBtn.visible = true;
			
			if(_currendSelected.data)
			     sourceImage.source = EmailTypeEnum.getSourceImageByEmailType(_currendSelected.data.attachment_type);
		}
		
		private function countTxt_changeHAndler(event:TextEvent):void
		{
//			countTxt.visible = true;
			tipsLabel.visible = false;
			_currendSelected.data.attachment_count = int(countTxt.text);
			_currendSelected.data.costMoney = EmailTypeEnum.getSourceCostBySourceCount(int(countTxt.text),_currendSelected.data.attachment_type);
			costLabel.text = _currendSelected.data.costMoney +"";
			
		}
		
		private function okBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new EmailEvent(EmailEvent.SEND_SOURCE_DATA_EVENT,_currendSelected.data));
		}
		
		private function closedHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("closeSendSourceComponent"));
		}
		
		private function tipsLabel_clickHandler(event:MouseEvent):void
		{
			countTxt.visible = true;
			tipsLabel.visible = false;
		}
	}
}