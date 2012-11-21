package mediator.battle
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.ObjectUtil;
	import com.zn.utils.ScreenUtils;
	
	import events.battle.BottomViewEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import ui.managers.SystemManager;
	
	import view.battle.bottomView.BottomViewComponent;

	/**
	 *战场编辑底部面板
	 * @author zn
	 * 
	 */
	public class BottomViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BottomViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function BottomViewComponentMediator()
		{
			super(NAME, new BottomViewComponent(ClassUtil.getObject("battle.BattleBottomViewSkin")));
			comp.y=SystemManager.rootStage.stageHeight-comp.height;
			comp.x=SystemManager.rootStage.stageWidth-comp.width;
			
			comp.addEventListener(BottomViewEvent.EXIT_EVENT,exitHandler);
			
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
		public function get comp():BottomViewComponent
		{
			return viewComponent as BottomViewComponent;
		}
		
		protected function exitHandler(event:Event):void
		{
			sendNotification(BattleEditMediator.DESTROY_NOTE);
			sendNotification(PlantioidComponentMediator.SHOW_NOTE);
		}
		
		
		
		override public function show():void
		{
			MainViewMediator(getMediator(MainViewMediator)).comp.addChild(comp);
		}
		
		override public function destroy():void
		{
			comp.dispose();
			viewComponent = null;
			
			removeCWList();
			
			facade.removeMediator(getMediatorName());
		}
	}
}