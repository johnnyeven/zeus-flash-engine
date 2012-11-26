package mediator.groupFight
{
	import controller.EnterMainSenceViewCommand;
	
	import enum.SenceTypeEnum;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.mainView.MainViewMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.groupFight.GroupFightProxy;
	
	import view.groupFight.GroupFightMenuComponent;
	
	import vo.GlobalData;

	public class GroupFightMenuComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightMenuComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public static const CHANGE_NOTE:String="change" + NAME + "Note";
		
		public static const HIDE_NOTE:String="hide" + NAME + "Note";
		
		public static const SHOW_HIDE_NOTE:String="show_hide" + NAME + "Note";
		
		private var groupFightProxy:GroupFightProxy;
		public function GroupFightMenuComponentMediator()
		{
			super(NAME, new GroupFightMenuComponent());
			groupFightProxy=getProxy(GroupFightProxy);
			_popUp=false;
			comp.med=this;
			comp.x=395;
			comp.y=528;	
			
			comp.upData(groupFightProxy.num);
			comp.addEventListener(GroupFightEvent.JIDI_EVENT,jiDiHandler);
			comp.addEventListener(GroupFightEvent.SHUAXIN_EVENT,shuaXinHandler);
		}
		
		protected function shuaXinHandler(event:GroupFightEvent):void
		{
			groupFightProxy.get_star_map();
		}
		
		protected function jiDiHandler(event:GroupFightEvent):void
		{
			if (GlobalData.currentSence == SenceTypeEnum.MAIN)
				return;
			var mainViewMed:MainViewMediator=getMediator(MainViewMediator);
			mainViewMed.comp.controlComp.setBaseBtn();
			Main.addBG();
			sendNotification(MainViewMediator.SHOW_RENWU_VIEW_NOTE);
			sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
			sendNotification(MainViewMediator.SHOW_RIGHT_VIEW_NOTE);
			sendNotification(MainViewMediator.SHOW_TOP_VIEW_NOTE);
			sendNotification(DESTROY_NOTE);
			sendNotification(GroupFightShowComponentMediator.DESTROY_NOTE);
			sendNotification(GroupFightMapComponentMediator.DESTROY_NOTE);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,CHANGE_NOTE,HIDE_NOTE,SHOW_HIDE_NOTE];
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
				case CHANGE_NOTE:
				{
					comp.upData(groupFightProxy.num);
					break;
				}
				case HIDE_NOTE:
				{
					comp.visible=false;
					break;
				}
				case SHOW_HIDE_NOTE:
				{
					comp.visible=true;
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		public function get comp():GroupFightMenuComponent
		{
			return viewComponent as GroupFightMenuComponent;
		}

	}
}