package view.email
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.email.EmailTypeEnum;
	
	import events.email.EmailEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.email.EmailItemVO;
	
	public class EmailItem extends Component
	{
		public var headImage:LoaderImage;
		public var typeImage:LoaderImage;
		public var timeLabel:Label;
		public var sendNameLabel:Label;
		public var titleNameLabel:Label;
		public var deleteBtn:Button;
		public var haveFuJianSprite:Sprite;
		public var alreadyReceiveFuJianSprivate:Sprite;
		
		public var alreadyViewSpriteBg:Sprite;
		public var noViewSpriteBg:Sprite;
		
		private var _isDelete:Boolean;
		
		private var _data:EmailItemVO;
		public function EmailItem()
		{
			super(ClassUtil.getObject("view.email.ItemSkin"));
			
			headImage = createUI(LoaderImage,"headImage");
			typeImage = createUI(LoaderImage,"typeImage");
			timeLabel = createUI(Label,"timeLabel");
			sendNameLabel = createUI(Label,"sendNameLabel");
			titleNameLabel = createUI(Label,"titleNameLabel");
			deleteBtn = createUI(Button,"deleteBtn");
			deleteBtn.visible = false;
			haveFuJianSprite = getSkin("haveFuJianSprite");
			haveFuJianSprite.visible = false;
			alreadyReceiveFuJianSprivate = getSkin("alreadyReceiveFuJianSprivate");
			alreadyReceiveFuJianSprivate.visible = false;
			alreadyViewSpriteBg = getSkin("alreadyViewSpriteBg");
			alreadyViewSpriteBg.visible = false;
			noViewSpriteBg = getSkin("noViewSpriteBg");
			noViewSpriteBg.visible = true;
			
			sortChildIndex();
			
			deleteBtn.addEventListener(MouseEvent.CLICK,deleteBtn_clickHandler);
		}

		public function get data():EmailItemVO
		{
			return _data;
		}

		public function set data(value:EmailItemVO):void
		{
			_data = value;
			
			if(_data)
			{
				headImage.source = EmailTypeEnum.getHeadImageByEmailType(_data.type);
				typeImage.source = EmailTypeEnum.getTypeImageByEmailType(_data.type);
				timeLabel.text = DateFormatter.formatterTimeAll(_data.created_at);
				sendNameLabel.text = _data.sender;
				titleNameLabel.text = _data.title;
				if(_data.is_read == true)
				{
					alreadyViewSpriteBg.visible = true;
					noViewSpriteBg.visible = false;
				}
				else
				{
					alreadyViewSpriteBg.visible = false;
					noViewSpriteBg.visible = true;
				}
				if(_data.attachment && _data.attachment == true)
				{
					if(_data.receive_attachment ==true)
					{
						alreadyReceiveFuJianSprivate.visible = true;
						haveFuJianSprite.visible = false;
					}
					else
					{
						haveFuJianSprite.visible = true;
						alreadyReceiveFuJianSprivate.visible = false;
					}
					
				}
				else
				{
					haveFuJianSprite.visible = false;
					alreadyReceiveFuJianSprivate.visible = false;
				}
			}
		}

		public function get isDelete():Boolean
		{
			return _isDelete;
		}

		public function set isDelete(value:Boolean):void
		{
			_isDelete = value;
			deleteBtn.visible = _isDelete;
		}
		
		private function deleteBtn_clickHandler(event:MouseEvent):void
		{
			var arr:Array = [];
			arr.push(_data.id);
			dispatchEvent(new EmailEvent(EmailEvent.DELETE_ONE_EMAIL_EVENT,arr));
		}
	}
}