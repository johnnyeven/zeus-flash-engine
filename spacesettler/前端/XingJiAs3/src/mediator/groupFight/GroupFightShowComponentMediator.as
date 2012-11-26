package mediator.groupFight
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.groupFight.GroupFightProxy;
	
	import ui.managers.SystemManager;
	
	import view.groupFight.GroupFightShowComponent;

	public class GroupFightShowComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightShowComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public static const CHANGE_NOTE:String="change" + NAME + "Note";
		
		public static const HIDE_NOTE:String="hide" + NAME + "Note";
		
		public static const SHOW_HIDE_NOTE:String="show_hide" + NAME + "Note";
		
		private var groupFightProxy:GroupFightProxy;
		public function GroupFightShowComponentMediator()
		{
			super(NAME, new GroupFightShowComponent());
			groupFightProxy=getProxy(GroupFightProxy);
			
			_popUp=false;
			comp.med=this;
			comp.x=SystemManager.rootStage.stageWidth-comp.width;
			comp.y=0;
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
					comp.upData(groupFightProxy.lossReportVo)
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
		public function get comp():GroupFightShowComponent
		{
			return viewComponent as GroupFightShowComponent;
		}

	}
}