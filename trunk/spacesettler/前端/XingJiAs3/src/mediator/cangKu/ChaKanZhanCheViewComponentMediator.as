package mediator.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import events.cangKu.ChaKanEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.cangKu.ChaKanZhanCheViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class ChaKanZhanCheViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChaKanZhanCheViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function ChaKanZhanCheViewComponentMediator(viewComponent:Object=null)
		{
			super(NAME, new ChaKanZhanCheViewComponent(ClassUtil.getObject("zhanCheChaKan_View")));
			comp.med=this;
			level = 2;
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
				/*case SHOW_NOTE:
				{
					var event:ChaKanEvent=note.getBody() as ChaKanEvent;
					var viewComp:ChaKanZhanCheViewComponent=new ChaKanZhanCheViewComponent(ClassUtil.getObject("zhanCheChaKan_View"));
					viewComp.wpName.text="思索者号战车";
					viewComp.wplevel.text="43";
					viewComp.wpScore.text="240000";
					
					viewComp.addEventListener(ChaKanEvent.CLOSEVIEW_EVENT,closeHandler);
					
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
		protected function get comp():ChaKanZhanCheViewComponent
		{
			return viewComponent as ChaKanZhanCheViewComponent;
		}

		protected function closeHandler(event:ChaKanEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
	}
}