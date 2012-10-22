package mediator.battle
{
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import mx.messaging.AbstractConsumer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.battle.build.BattleBuildInfoComponent;
	
	import vo.battle.BattleBuildVO;

	/**
	 *战场建筑信息 
	 * @author zn
	 * 
	 */	
	public class BattleBuildInfoComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="BattleBuildInfoComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function BattleBuildInfoComponentMediator()
		{
			super(NAME, new BattleBuildInfoComponent());
			comp.med=this;
			level=1;
			popUpEffect=CENTER;
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
		protected function get comp():BattleBuildInfoComponent
		{
			return viewComponent as BattleBuildInfoComponent;
		}

		public function set buildVO(value:BattleBuildVO):void
		{
			comp.buildVO=value;
		}
	}
}