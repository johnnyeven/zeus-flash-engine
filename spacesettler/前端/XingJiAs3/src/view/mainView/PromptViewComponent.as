package view.mainView
{
	import enum.TaskEnum;
	
	import events.buildingView.ZhuJiDiEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.core.Component;
	
	public class PromptViewComponent extends Component
	{
		/**
		 * 任务提示
		 */		
		public var job:MovieClip;
		
		/**
		 *邮件提示 
		 */		
		public var mail:MovieClip;
		
		/**
		 *礼包提示 
		 */		
		public var gift:Sprite;
		
		private var _userInfoProxy:UserInfoProxy;
		public function PromptViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			_userInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			job=getSkin("renwu_mc");
			mail=getSkin("youjian_mc");
			gift=getSkin("giftBag_mc");
			gift.visible = false;
			mail.mouseEnabled = mail.buttonMode = true;
			mail.visible=false;
			sortChildIndex();
			
			job.mouseEnabled=job.buttonMode=gift.mouseEnabled = gift.buttonMode = true;
			job.addEventListener(MouseEvent.CLICK,job_clickHandler);
			mail.addEventListener(MouseEvent.CLICK,mail_clickHandler);
			gift.addEventListener(MouseEvent.CLICK,gift_clickHandler);
			
			cwList.push(BindingUtils.bindSetter(renWuShanSu,_userInfoProxy,["userInfoVO","index"]));
		}
		
		private function renWuShanSu(value:*):void
		{
			if(value<=TaskEnum.index25)
			{
				job.visible=true;
			}else
			{
				job.visible=false;
			}
		}
		
		protected function job_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.JOB_EVENT,true,true));
		}
		
		protected function mail_clickHandler(event:MouseEvent):void
		{
			
			mail.visible = false;
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.EMAIL_EVENT,true));
		}
		
		protected function gift_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ZhuJiDiEvent(ZhuJiDiEvent.GIFT_EVENT,true,true));
		}
	}
}