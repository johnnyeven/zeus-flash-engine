package mediator.buildingView
{
	import com.greensock.easing.Sine;
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.ConditionEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.scienceResearch.ScienceResearchComponentMediator;
	import mediator.shangCheng.ShangChengComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	
	import ui.managers.PopUpManager;
	
	import view.buildingView.ConditionViewComp;
	
	import vo.BuildInfoVo;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class ConditionViewCompMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ConditionViewCompMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function ConditionViewCompMediator()
		{
			super(NAME,  new ConditionViewComp(ClassUtil.getObject("view.mainView.ConditionComp")));
			_popUp = true;
			mode = true;
			popUpEffect=CENTER;
			
			comp.med=this;
			level=2;
			
			comp.addEventListener(ConditionEvent.CLOSE_EVENT,closeViewHandler);
			comp.addEventListener(ConditionEvent.DUIHUAN_EVENT,duiHuanHandler);
			comp.addEventListener(ConditionEvent.SHENGCHAN_EVENT,shengChanHandler);
			comp.addEventListener(ConditionEvent.YANJIU_EVENT,yanJiuHandler);
			comp.addEventListener(ConditionEvent.SHENGJIKEJI_EVENT,shengJiKeJiHandler);
			comp.addEventListener(ConditionEvent.SHENGJI_EVENT,shengJiHandler);
			comp.addEventListener(ConditionEvent.CREATEKEJI_EVENT,createKeJiHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];//SHOW_NOTE, 
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
				/*case SHOW_NOTE:
				{
					show();
					break;
				}*/
				case DESTROY_NOTE:
				{
					//销毁对象
					destroy();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		public function get comp():ConditionViewComp
		{
			return viewComponent as ConditionViewComp;
		}
		
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}
		
		protected function closeViewHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function duiHuanHandler(event:ConditionEvent):void
		{
			sendNotification(ShangChengComponentMediator.SHOW_NOTE);
		}
		
		protected function shengChanHandler(event:ConditionEvent):void
		{
			var dianChangBuild:BuildInfoVo=BuildProxy(ApplicationFacade.getProxy(BuildProxy)).getBuild(BuildTypeEnum.DIANCHANG);
			if(dianChangBuild)
				sendNotification(DianChangUpComponentMediator.SHOW_NOTE);
			else
				sendNotification(DianChangCreateComponentMediator.SHOW_NOTE);
		}
		
		protected function yanJiuHandler(event:ConditionEvent):void
		{
			sendNotification(ScienceResearchComponentMediator.SHOW_NOTE);
		}
		
		protected function shengJiHandler(event:ConditionEvent):void
		{
			sendNotification(CenterUpComponentMediator.SHOW_NOTE);
		}
		
		protected function shengJiKeJiHandler(event:ConditionEvent):void
		{
			sendNotification(KeJiUpComponentMediator.SHOW_NOTE);
		}
		
		protected function createKeJiHandler(event:ConditionEvent):void
		{
			sendNotification(KeJiCreateComponentMediator.SHOW_NOTE);
		}
	}
}