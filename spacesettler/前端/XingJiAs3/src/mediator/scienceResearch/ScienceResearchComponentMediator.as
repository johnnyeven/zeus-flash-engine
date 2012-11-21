package mediator.scienceResearch
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.buildingView.BuildEvent;
	import events.buildingView.ConditionEvent;
	import events.scienceResearch.SciencePopuEvent;
	import events.scienceResearch.ScienceResearchEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.buildingView.ConditionViewCompMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.scienceResearch.ScienceResearchProxy;
	
	import view.scienceResearch.ScienceResearchComponent;
	
	import vo.scienceResearch.ScienceResearchVO;

	/**
	 *科研
	 * @author lw
	 *
	 */
	public class ScienceResearchComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="ScienceResearchComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var scienceResearchProxy:ScienceResearchProxy;
		
		public function ScienceResearchComponentMediator()
		{
			super(NAME, new ScienceResearchComponent());
			comp.med=this;
			level=1;
			scienceResearchProxy = getProxy(ScienceResearchProxy);
			comp.addEventListener(ScienceResearchEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(ScienceResearchEvent.INFOR_EVENT,inforHandler);
			comp.addEventListener(ScienceResearchEvent.RESEARCH_EVENT,researchHAndler);
			comp.addEventListener(ScienceResearchEvent.GET_DATA_RESULT,getDataHandler);
			comp.addEventListener(ScienceResearchEvent.SPEED_EVENT,researchSpeedHandler);
//			comp.addEventListener(SciencePopuEvent.POPU_DATA_EVENT,popuHandler);
			comp.addEventListener(ConditionEvent.ADDCONDITIONVIEW_EVENT,addConditionViewHandler);
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
		public function get comp():ScienceResearchComponent
		{
			return viewComponent as ScienceResearchComponent;
		}
		
		private function inforHandler(event:ScienceResearchEvent):void
		{
			var obj:Object = {scienceType:event.scienceType};
			sendNotification(InforComponentMediator.SHOW_NOTE,obj);
		}
		
		private function researchHAndler(event:ScienceResearchEvent):void
		{			
			scienceResearchProxy.researchUp(event.scienceType);
		}
		
//		private function popuHandler(event:SciencePopuEvent):void
//		{
//			sendNotification(PopuItemComponentMediator.SHOW_NOTE,event.data);
//		}

		private function getDataHandler(event:ScienceResearchEvent):void
		{
			scienceResearchProxy.researchReturn(event.scienceType);
		}
		
		private function researchSpeedHandler(event:ScienceResearchEvent):void
		{
			sendNotification(MoneyAlertComponentMediator.SHOW_NOTE, { info: MultilanguageManager.getString("speedTimeInfo"),
				count: ScienceResearchVO.SPEEDCOST, okCallBack: function():void
				{
					scienceResearchProxy.speedResearchUp(event.eventID);
				}});
		}
		
		private function addConditionViewHandler(event:ConditionEvent):void
		{
			sendNotification(ConditionViewCompMediator.SHOW_NOTE,event.conditionArr);
		}
	}
}