package mediator.battle
{
	import enum.BuildTypeEnum;
	
	import events.buildingView.ConditionEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.buildingView.CenterUpComponentMediator;
	import mediator.buildingView.DianChangCreateComponentMediator;
	import mediator.buildingView.DianChangUpComponentMediator;
	import mediator.buildingView.KeJiCreateComponentMediator;
	import mediator.buildingView.KeJiUpComponentMediator;
	import mediator.scienceResearch.ScienceResearchComponentMediator;
	import mediator.shangCheng.ShangChengComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.BuildProxy;
	
	import view.battle.build.battleEditorConditionComponent;
	
	import vo.BuildInfoVo;
	import vo.battle.BattleBuildVO;

	/**
	 *战场编辑条件弹出框
	 * @author lw
	 *
	 */
	public class battleEditorConditionComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="battleEditorConditionComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function battleEditorConditionComponentMediator()
		{
			super(NAME, new battleEditorConditionComponent());
			
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
			return [DESTROY_NOTE];
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
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():battleEditorConditionComponent
		{
			return viewComponent as battleEditorConditionComponent;
		}
		
		public function setData(data:Array):void
		{
			comp.setValue(data);
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