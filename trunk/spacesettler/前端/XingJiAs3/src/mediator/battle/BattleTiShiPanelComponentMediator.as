package mediator.battle
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.battle.fightView.BattleTiShiPanelComponent;

	/**
	 * 时间或其他紧急提示
	 * @author rl
	 * 
	 */	
	public class BattleTiShiPanelComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleTiShiPanelComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function BattleTiShiPanelComponentMediator()
		{
			super(NAME, new BattleTiShiPanelComponent());
			
			comp.med=this;
			popUpEffect=LEFT;
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
		
		public function upData(obj:Object):void
		{
			comp.tiShiLable.text=obj.showLable;	
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():BattleTiShiPanelComponent
		{
			return viewComponent as BattleTiShiPanelComponent;
		}

	}
}