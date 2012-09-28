package view.systemView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.URLFunc;
	
	import events.system.SystemEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.login.LoginProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
    public class AccountNumberBoundaryComponent extends Component
    {
		/**
		 *返回按钮 
		 */		
		public var fanHuiBtn:Button;
		
		/**
		 *绑定邮箱按钮 
		 */		
		public var boundMailBtn:Button;
		
		/**
		 *修改密码按钮 
		 */		
		public var passWordBtn:Button;
		
		/**
		 *邮件按钮 
		 */		
		public var mailBtn:Button;
		
		
		
		/**
		 *显示所在服务器 
		 */		
		public var fuWuQiTf:Label;
		
		/**
		 *显示用户账号 
		 */		
		public var zhangHaoTf:Label;
		
		/**
		 *显示用户昵称 
		 */		
		public var niChenTf:Label;
		
		/**
		 *显示用户邮箱 如果没有则为空 
		 */		
		public var mailTf_1:Label;
		
		
		
		
		private var _loginProxy:LoginProxy;
		private var _userinfoProxy:UserInfoProxy;
        public function AccountNumberBoundaryComponent()
        {
            super(ClassUtil.getObject("view.systemView.AccountNumberBoundarySkin"));
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			boundMailBtn=createUI(Button,"bangding_btn");
			passWordBtn=createUI(Button,"xiugai_btn");
			mailBtn=createUI(Button,"mail_btn");
			
			fuWuQiTf=createUI(Label,"fuwuqi_tf");
			zhangHaoTf=createUI(Label,"zhanghao_tf");
			niChenTf=createUI(Label,"nichen_tf");
			mailTf_1=createUI(Label,"mail_tf_1");
			
			sortChildIndex();
			
			_loginProxy=ApplicationFacade.getProxy(LoginProxy);
			_userinfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			mailBtn.addEventListener(MouseEvent.CLICK,mailBtn_clickHandler);
			
			if(LoginProxy.selectedServerVO)
			{
				fuWuQiTf.text=LoginProxy.selectedServerVO.server_name;
			}
			niChenTf.text=_userinfoProxy.userInfoVO.nickname;
			if(_loginProxy.userName)
			{
				zhangHaoTf.text=_loginProxy.userName;
			}else
			{
				zhangHaoTf.text="游客";
			}
			if(_loginProxy.email)
			{
				mailTf_1.text=_loginProxy.email;
			}
        }
		
		protected function mailBtn_clickHandler(event:MouseEvent):void
		{
			URLFunc.openHTML("");
			//TODO :GX
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.CLOSE));
		}
    }
}