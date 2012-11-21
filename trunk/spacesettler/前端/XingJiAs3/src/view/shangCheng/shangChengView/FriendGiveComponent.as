package view.shangCheng.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import events.allView.FriendGiveEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.LoaderImage;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	import vo.allView.FriendInfoVo;
	
    public class FriendGiveComponent extends Component
    {
		/**
		 *显示赠送的物品图 
		 */		
		public var titleSp:LoaderImage;
		
		/**
		 *显示赠送的物品名称 
		 */		
		public var titleTf:TextField;
		
		/**
		 *显示需要的金钱 
		 */		
		public var moneyTf:TextField;
		
		/**
		 *显示要赠送的好友TF 
		 */		
		public var showTf:TextField;
		
		/**
		 *确定赠送按钮 
		 */		
		public var okBtn:Button;
		
		/**
		 *关闭按钮 
		 */		
		public var closeBtn:Button;
		
		/**
		 *装ITEM的容器 
		 */		
		public var sprite:Sprite;
		
		/**
		 *拖动条 
		 */		
		public var vsBar:VScrollBar;
		
		private var _arr:Array=[];
		private var type:String;
		private var container:Container;
        public function FriendGiveComponent()
        {
            super(ClassUtil.getObject("view.allView.friendGiveSkin"));
			
			
			titleTf=getSkin("title_tf");
			moneyTf=getSkin("money_tf");
			showTf=getSkin("xianshi_tf");
			sprite=getSkin("sprite");
			
			okBtn=createUI(Button,"ok_btn");
			closeBtn=createUI(Button,"close_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			titleSp=createUI(LoaderImage,"tubiao_sprite");
			
			sortChildIndex();
			
			showTf.text="";
			okBtn.addEventListener(MouseEvent.CLICK,doGiveHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			addContainer();
        }
		
		private function addContainer():void
		{
			container=new Container(null);
			container.contentWidth=243;
			container.contentHeight=209;			
			container.layout=new HTileLayout(container);
			container.layout.vGap=2;
			container.x=0;
			container.y=0;
			vsBar.viewport=container;
			sprite.addChild(container);
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendGiveEvent(FriendGiveEvent.CLOSE_FRIENDGIVE));
		}
		
		protected function doGiveHandler(event:MouseEvent):void
		{
			
			for(var i:int;i<_arr.length;i++)
			{
				var firendVo:FriendInfoVo=_arr[i] as FriendInfoVo;
				if(firendVo.nickname==showTf.text)
				{
					dispatchEvent(new FriendGiveEvent(FriendGiveEvent.SURE_BTN_CLICK,null,firendVo.id,type));
				}
			}
		}
		
		public function setFriendConst(arr:Array,text:String,num:String,titleText:String,source:String):void
		{
			titleSp.source=source;
			_arr=arr;
			type=num;
			moneyTf.text=text;
			titleTf.text=titleText;
			for(var i:int;i<arr.length;i++)
			{
				var firendVo:FriendInfoVo=arr[i] as FriendInfoVo;
				var friendItem:FriendGiveItemComponent=new FriendGiveItemComponent();
				if(firendVo.vip_level>0)
				{
					friendItem.usernameVip=firendVo.nickname;
				}else
				{
					friendItem.usernamePt=firendVo.nickname;
				}
				//itemArr.push(friendItem);
				friendItem.addEventListener(MouseEvent.CLICK,doChangeNameHandler);
				container.add(friendItem);
			}
			container.layout.update();
			vsBar.update();
		}
		
		protected function doChangeNameHandler(event:MouseEvent):void
		{
			var friendItem:FriendGiveItemComponent=event.currentTarget as FriendGiveItemComponent;
			if(friendItem.username_tf.visible==true)
			{
				showTf.text=friendItem.username_tf.text;
			}else
			{
				showTf.text=friendItem.username_vip.text;
			}
			
		}
    }
}