package mediator.cangKu
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import events.cangKu.ChaKanEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.packageView.PackageViewProxy;
	
	import view.cangKu.ChaKanTuZhiViewComponent;
	
	import vo.cangKu.ItemVO;

	/**
	 *
	 * @author zn
	 * 
	 */
	public class ChaKanTuZhiViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChaKanTuZhiViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var packageProxy:PackageViewProxy; 
		public function ChaKanTuZhiViewComponentMediator(viewComponent:Object=null)
		{
			super(NAME, new ChaKanTuZhiViewComponent(ClassUtil.getObject("tuZhiChaKan_View")));
			packageProxy=getProxy(PackageViewProxy);
			
			comp.med=this;
			level = 2;
			comp.addEventListener(ChaKanEvent.CLOSEVIEW_EVENT,closeHandler);
			comp.addEventListener(ChaKanEvent.USE_EVENT,useHandler);
			
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
		protected function get comp():ChaKanTuZhiViewComponent
		{
			return viewComponent as ChaKanTuZhiViewComponent;
		}
		
		protected function closeHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function useHandler(event:ChaKanEvent):void
		{
			var itemVo:ItemVO=event.itemVO as ItemVO;
			packageProxy.useItem(itemVo.id,function():void
			{
				var obj:Object={};
				obj.showLable=MultilanguageManager.getString("useIteminfo");
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
				sendNotification(DESTROY_NOTE);	
			});
				
						
			
		}
	}
}