package mediator.battle
{
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.battle.fightView.BattleRevivePanelComponent;
	/**
	 *复活 
	 * @author gx
	 * 
	 */
	public class BattleRevivePanelComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleRevivePanelComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var okCallBack:Function;
		private var noCallBack:Function;
		public function BattleRevivePanelComponentMediator()
		{
			super(NAME, new BattleRevivePanelComponent());
			
			mode = true;
			popUpEffect=CENTER;
			
			comp.med=this;
			level=3;			
			
			comp.addEventListener(BattleRevivePanelComponent.OK_EVENT,okHandler);
			comp.addEventListener(BattleRevivePanelComponent.NO_EVENT,noHandler);
		}
		
		protected function okHandler(event:Event):void
		{
			if(okCallBack!=null)
				okCallBack();
			okCallBack=null
				
			sendNotification(DESTROY_NOTE);
		}
		
		protected function noHandler(event:Event):void
		{
//			if(noCallBack!=null)
//				noCallBack();
//			noCallBack=null
			//选择放弃后提示失败
			sendNotification(BattleFailPanelComponentMediator.SHOW_NOTE);
			sendNotification(DESTROY_NOTE);
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
		protected function get comp():BattleRevivePanelComponent
		{
			return viewComponent as BattleRevivePanelComponent;
		}
		
		public function upData(obj:Object):void
		{
			
			comp.name_tf.text ="复活";
			comp.cost_tf.text = "X1";
			
			okCallBack = obj.okCallBack;
			noCallBack = obj.noCallBack;
			
		}

	}
}