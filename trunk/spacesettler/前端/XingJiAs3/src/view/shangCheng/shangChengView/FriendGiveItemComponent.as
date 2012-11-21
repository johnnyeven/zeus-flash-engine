package view.shangCheng.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import ui.components.Label;
	import ui.core.Component;
	
	public class FriendGiveItemComponent extends Component
	{
		/**
		 * 普通用户的名称
		 */		
		public var username_tf:Label;
		
		/**
		 *VIP用户的名称 
		 */		
		public var username_vip:Label;
		
		/**
		 *VIP图标 
		 */		
		public var vip:Sprite;
		
		public function FriendGiveItemComponent()
		{
			super(ClassUtil.getObject("view.allView.friendGiveItemSkin"));
			username_tf=createUI(Label,"username_tf");
			username_vip=createUI(Label,"username_vip");
			vip=getSkin("vip_mc");
			
			sortChildIndex();
			
		}
		
		public function set usernamePt(text:String):void
		{
			username_tf.text=text;
			username_tf.visible=true;
			username_vip.visible=false;
			vip.visible=false;
			username_vip.text="";
		}
		
		public function set usernameVip(text:String):void
		{
			username_vip.text=text;
			vip.visible=true;
			username_vip.visible=true;
			username_tf.visible=false;
			username_tf.text="";
			
		}
	}
}