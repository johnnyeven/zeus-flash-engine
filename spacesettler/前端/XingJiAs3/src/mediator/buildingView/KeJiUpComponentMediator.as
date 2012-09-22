package mediator.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.AddViewEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.buildingView.KeJiUpComponent;
	
	/**
	 *科技中心升级
	 * @author zn
	 * 
	 */
	public class KeJiUpComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="KeJiUpComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function KeJiUpComponentMediator()
		{
			super(NAME, new KeJiUpComponent(ClassUtil.getObject("up_keJi_view")));
			comp.upType=BuildTypeEnum.KEJI;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
		}
		
		protected function closeHandler(event:AddViewEvent):void
		{
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
		protected function get comp():KeJiUpComponent
		{
			return viewComponent as KeJiUpComponent;
		}
	}
}