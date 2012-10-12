package mediator.prompt
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ui.managers.PopUpManager;
	
	import view.prompt.PromptSureComponent;
	
	public class PromptSureMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String = "PromptSureMediator";
		
		public static const SHOW_NOTE:String = "show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";
		
		public var okCallBack:Function;
		
		public function PromptSureMediator()
		{
			super(NAME, new PromptSureComponent(ClassUtil.getObject("res.Prompt_2_InfoSkin")));
			
			_popUp = true;
			mode = true;
			popUpEffect=CENTER;
			
			comp.med=this;
			level=2;
			
			comp.addEventListener(PromptSureComponent.OK_EVENT, okHandler);
			comp.addEventListener(PromptSureComponent.NO_EVENT, noHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [ SHOW_NOTE, DESTROY_NOTE ];
		}
		
		/**
		 *消息处理
		 * @param note
		 *
		 */
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case DESTROY_NOTE:
				{
					//销毁对象
					destroy();
					break;
				}
				case SHOW_NOTE:
				{
					var obj:Object = note.getBody();
					comp.infoTF.text = obj.infoLable;
					comp.showTF.text = obj.showLable;
					okCallBack = obj.okCallBack;
					show();
					break;
				}
			}
		}
		
		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():PromptSureComponent
		{
			return viewComponent as PromptSureComponent;
		}
		
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}		
		
		protected function noHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function okHandler(event:Event):void
		{
			if (okCallBack != null)
				okCallBack();
			okCallBack = null;
			
			sendNotification(DESTROY_NOTE);
		}
	}
}