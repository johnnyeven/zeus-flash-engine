package mediator.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import enum.factory.FactoryEnum;
	
	import events.cangKu.ChaKanEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.cangKu.ChaKanGuaJianViewComponent;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.GuaJianInfoVO;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class ChaKanGuaJianViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChaKanGuaJianViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function ChaKanGuaJianViewComponentMediator(viewComponent:Object=null)
		{
			super(NAME, new ChaKanGuaJianViewComponent(ClassUtil.getObject("guaJianChaKan_View")));
			comp.med=this;
			level = 3;
			comp.addEventListener(ChaKanEvent.CLOSEVIEW_EVENT,closeHandler);
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
		protected function get comp():ChaKanGuaJianViewComponent
		{
			return viewComponent as ChaKanGuaJianViewComponent;
		}
		
		protected function closeHandler(event:ChaKanEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
	}
}