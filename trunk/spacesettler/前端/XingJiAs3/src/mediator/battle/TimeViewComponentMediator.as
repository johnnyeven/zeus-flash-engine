package mediator.battle
{
	import com.zn.utils.ClassUtil;
	
	import controller.mainSence.ShowCommand;
	
	import enum.SenceTypeEnum;
	
	import events.battle.TimeViewEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import ui.managers.SystemManager;
	
	import view.battle.bottomView.TimeViewComponent;

	/**
	 * 时间面板
	 * @author zn
	 * 
	 */
	public class TimeViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="TimeViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function TimeViewComponentMediator()
		{
			super(NAME, new TimeViewComponent(ClassUtil.getObject("battle.BattleTimePanelSkin")));
			comp.x=SystemManager.rootStage.stageWidth-comp.width;
			comp.y=30;
			
			comp.addEventListener(TimeViewEvent.TIMEOVER_EVENT,timeOverHandler);
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
		public function get comp():TimeViewComponent
		{
			return viewComponent as TimeViewComponent;
		}

		override public function show():void
		{
			MainViewMediator(getMediator(MainViewMediator)).comp.addChild(comp);
			
			comp.timer.start();
		}
		
		override public function destroy():void
		{
			comp.timer.stop();
			comp.dispose();
			viewComponent = null;
			
			removeCWList();
			
			facade.removeMediator(getMediatorName());
		}
		
		protected function timeOverHandler(event:TimeViewEvent):void
		{
			sendNotification(BattleEditMediator.DESTROY_NOTE);
			var obj1:Object={type:SenceTypeEnum.PLANT}
			sendNotification(ShowCommand.SHOW_INTERFACE,obj1);
		}
	}
}