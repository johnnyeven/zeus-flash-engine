package view.task
{
	import com.netease.protobuf.TextFormat;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import events.task.TaskEvent;
	
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.task.TaskInfoVO;
	
	/**
	 *用户注册界面 
	 * @author Administrator
	 * 
	 */	
    public class taskMilitaryComponent extends Component
    {
		public var dark_crystal:Label;//暗能水晶
		public var broken_crystal:Label;//暗物质
		public var tritium:Label;//氚气
		public var crystal:Label;//水晶
		
		public var tiShiTf:Label;// tishi
		public var sureBtn:Button;
		
		public var mailTf:TextField;
		public var nameTf:TextField;
		public var passWordTf1:TextField;
		public var passWordTf:TextField;
		public var userNameTf:TextField;

		
        public function taskMilitaryComponent()
        {
            super(ClassUtil.getObject("view.taskMilitarySkin"));
			
			sureBtn=createUI(Button,"sureBtn");
			
			dark_crystal=createUI(Label,"dark_crystal");
			broken_crystal=createUI(Label,"broken_crystal");
			tritium=createUI(Label,"tritium");
			crystal=createUI(Label,"crystal");
			tiShiTf=createUI(Label,"tiShiTf");
			
			mailTf=getSkin("mailTf");
			nameTf=getSkin("nameTf");
			passWordTf1=getSkin("passWordTf1");
			passWordTf=getSkin("passWordTf");
			userNameTf=getSkin("userNameTf");
			
			sortChildIndex();
			
			mailTf.mouseEnabled=nameTf.mouseEnabled=passWordTf1.mouseEnabled=passWordTf.mouseEnabled=userNameTf.mouseEnabled=true;
			
			userNameTf.restrict = "a-zA-Z0-9\u4e00-\u9fa5_-";
			userNameTf.maxChars = 16;
			nameTf.maxChars = 16;
			
			nameTf.restrict = "a-zA-Z0-9\u4e00-\u9fa5_-";
			passWordTf.restrict = "a-zA-Z0-9_-";
			passWordTf.maxChars = 16;
			passWordTf1.restrict = "a-zA-Z0-9_-";
			passWordTf1.maxChars = 16;
			passWordTf1.displayAsPassword=passWordTf.displayAsPassword=true;//设置密码格式
			sureBtn.addEventListener(MouseEvent.CLICK,suerClickHandler);
			userNameTf.addEventListener(TextEvent.TEXT_INPUT,userNameTfEvent);
			nameTf.addEventListener(TextEvent.TEXT_INPUT,nameTfEvent);
        }
		
		public function upData(taskVo:TaskInfoVO):void
		{
			dark_crystal.text=taskVo.dark_crystal.toString();
			broken_crystal.text=taskVo.broken_crystal .toString();
			tritium.text=taskVo.tritium.toString();
			crystal.text=taskVo.crystal.toString();
		}
		
		private function nameTfEvent(e:TextEvent):void
		{
			
			if((getStringBytesLength(nameTf.text,"gb2312") +
				
				getStringBytesLength(e.text,'gb2312')) > nameTf.maxChars)
			{
				e.preventDefault();
				return; 
			}
		}
		
		private function userNameTfEvent(e:TextEvent):void
		{
			
			if((getStringBytesLength(userNameTf.text,"gb2312") +
				
				getStringBytesLength(e.text,'gb2312')) > userNameTf.maxChars)
			{
				e.preventDefault();
				return; 
			}
		}
		
		private function getStringBytesLength(str:String,charSet:String):int
		{
			
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeMultiByte(str, charSet);
			
			bytes.position = 0;
			
			return bytes.length;
			
		}
		
		private function strLength(str:String):int
		{
			var length:int=0;
			for (var i:int = 0; i < str.length; i++)
			{  
				if(str.charCodeAt(i)<10000)
					length+=1;
				else
					length+=2;
				//				trace(str.charAt(i), "-", str.charCodeAt(i));
			}
			
			return length;
		}
		
		protected function suerClickHandler(event:MouseEvent):void
		{
			var emailReg:RegExp=new RegExp("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$","g");
			
			if(StringUtil.isEmpty(userNameTf.text)||strLength(userNameTf.text)<6)
			{
				tiShiTf.text=MultilanguageManager.getString("registInforError");
				return;
			}
			else if(StringUtil.isEmpty(passWordTf1.text)||StringUtil.isEmpty(passWordTf.text))
			{
				tiShiTf.text=MultilanguageManager.getString("registPasswordEmpty");
				return;
			}
			else if(passWordTf1.length<6||passWordTf.length<6)
			{
				tiShiTf.text=MultilanguageManager.getString("registPasswordError");
				return;
			}
			else if(passWordTf1.text!=passWordTf.text)
			{
				tiShiTf.text=MultilanguageManager.getString("registAgainEmpty");
				return;
			}
			else if(strLength(nameTf.text)<6)
			{
				tiShiTf.text=MultilanguageManager.getString("registNameError");
				return;
			}
			else if(!StringUtil.isEmpty(mailTf.text)&&!emailReg.test(mailTf.text))//邮件格式不对
			{
				tiShiTf.text=MultilanguageManager.getString("registEmailError");	
				return;
			}
			
				dispatchEvent(new TaskEvent(TaskEvent.CLOSE_EVENT,null,userNameTf.text,
				passWordTf.text,nameTf.text,mailTf.text));
			
		}		
		
    }
}