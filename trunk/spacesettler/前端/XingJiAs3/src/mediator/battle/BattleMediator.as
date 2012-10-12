package mediator.battle
{
	import com.zn.events.ScreenScrollEvent;
	import com.zn.utils.ScreenUtils;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.battle.BattleComponent;

	/**
	 *战场
	 * @author zn
	 * 
	 */
	public class BattleMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function BattleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			_popUp=false;
		}

		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [ DESTROY_NOTE];
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
					ScreenUtils.removeScreenScroll();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():BattleComponent
		{
			return viewComponent as BattleComponent;
		}

		public override function showComplete():void
		{
			super.showComplete();
			
			ScreenUtils.normalW=comp.width;
			ScreenUtils.normalH=comp.height;
			ScreenUtils.addScreenScroll(comp,true);
		}
	}
}