package mediator.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import ui.managers.PopUpManager;
	
	import view.buildingView.InfoViewComponent;
	
	/**
	 *基地中心信息 
	 * @author zn
	 * 
	 */
	public class CenterInfoComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="CenterInfoComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
				
		public function CenterInfoComponentMediator()
		{
			super(NAME, new InfoViewComponent(ClassUtil.getObject("info_center_view")));
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
		protected function get comp():InfoViewComponent
		{
			return viewComponent as InfoViewComponent;
		}
	}
}