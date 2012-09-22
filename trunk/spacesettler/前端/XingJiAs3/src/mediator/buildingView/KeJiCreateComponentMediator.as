package mediator.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.BuildProxy;
	
	import view.buildingView.CreateViewComponent;
	
	/**
	 *科技建造
	 * @author zn
	 * 
	 */
	public class KeJiCreateComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="KeJiCreateComponentMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function KeJiCreateComponentMediator()
		{
			super(NAME,new CreateViewComponent(ClassUtil.getObject("build_keJi_view")));
			comp.buildType=BuildTypeEnum.KEJI;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(BuildEvent.BUILD_EVENT,buildHandler);
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
		protected function get comp():CreateViewComponent
		{
			return viewComponent as CreateViewComponent;
		}
		
		protected function closeHandler(event:Event=null):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function buildHandler(event:Event):void
		{
			var buildProxy:BuildProxy=getProxy(BuildProxy);
			buildProxy.buildBuild(BuildTypeEnum.KEJI);
		}
	}
}