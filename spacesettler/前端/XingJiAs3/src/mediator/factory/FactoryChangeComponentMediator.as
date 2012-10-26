package mediator.factory
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.cangKu.ChaKanGuaJianViewComponentMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.factory.FactoryProxy;
	
	import view.factory.FactoryChangeComponent;

	public class FactoryChangeComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FactoryChangeComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static const CHANGE_NOTE:String="change_Note";
		
		private var factoryProxy:FactoryProxy;
		public function FactoryChangeComponentMediator()
		{
			super(NAME, new FactoryChangeComponent());
			comp.med=this;
			level=1;
			
			factoryProxy=getProxy(FactoryProxy);
			
			comp.addEventListener(FactoryEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(FactoryEvent.QIANGHUA_EVENT,qiangHuaHandler);
			comp.addEventListener(FactoryEvent.CHANGE_ZHANCHE_EVENT,changeHandler);
			comp.addEventListener(FactoryEvent.SHOW_INFO_EVENT,showInfoHandler);
			
			comp.addEventListener(FactoryEvent.LOAD_GUAJIAN_EVENT,loadGuaJianHandler);
			comp.addEventListener(FactoryEvent.GENHUAN_GUAJIAN_EVENT,loadGuaJianHandler);
			
			comp.addEventListener(FactoryEvent.XIEZAI_EVENT,xieZaiHandler);
			comp.addEventListener(FactoryEvent.XIEZAI_ALL_EVENT,xieZaiAllHandler);
			comp.addEventListener(FactoryEvent.CHAKAN_GUAJIAN_EVENT,chaKanHandler);
			comp.addEventListener(FactoryEvent.NENGLIANG_MAX_EVENT,nengLiangMaxHandler);
			
			comp.upData(FactoryEnum.CURRENT_ZHANCHE_VO);
		}
		
		protected function nengLiangMaxHandler(event:FactoryEvent):void
		{			
				var obj:Object={};
				obj.infoLable=MultilanguageManager.getString("nengliangtishi");
				obj.showLable=MultilanguageManager.getString("nengliangmax");
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);					
		}
		
		protected function chaKanHandler(event:FactoryEvent):void
		{
			sendNotification(ChaKanGuaJianViewComponentMediator.SHOW_NOTE);
		}
		
		protected function xieZaiAllHandler(event:FactoryEvent):void
		{
			factoryProxy.unmount_all(FactoryEnum.CURRENT_ZHANCHE_VO.id,function():void
			{
				comp.changeAllLoader();
			});
		}
		
		protected function xieZaiHandler(event:FactoryEvent):void
		{
			factoryProxy.unmount(FactoryEnum.CURRENT_ZHANCHE_VO.id,FactoryEnum.CURRENT_GUAJIAN_VO.id,function():void
			{
				comp.changeLoader();
			});
		}		
		
		protected function loadGuaJianHandler(event:FactoryEvent):void
		{
			var obj:Object={};
			obj.type=ItemEnum.TankPart;
			sendNotification(FactoryArmsComponentMediator.SHOW_NOTE,obj);
		}
		
		protected function showInfoHandler(event:FactoryEvent):void
		{
			var obj:Object={};
			obj.type=FactoryEnum.GAIZHUANG_FACTORY;
			sendNotification(FactoryInfoComponentMediator.SHOW_NOTE,obj);
		}
		
		protected function changeHandler(event:FactoryEvent):void
		{
			
			var obj:Object={};
			obj.type=ItemEnum.Chariot;
			sendNotification(FactoryArmsComponentMediator.SHOW_NOTE,obj);
			sendNotification(DESTROY_NOTE);
		}
		
		protected function qiangHuaHandler(event:FactoryEvent):void
		{
			sendNotification(FactoryStrengthenComponentMediator.SHOW_NOTE);
		}
		
		protected function closeHandler(event:FactoryEvent):void
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
			return [DESTROY_NOTE,CHANGE_NOTE];
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
				case CHANGE_NOTE:
				{
					comp.upData(FactoryEnum.CURRENT_ZHANCHE_VO);
					comp.changeItem(FactoryEnum.CURRENT_ZHANCHE_VO);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():FactoryChangeComponent
		{
			return viewComponent as FactoryChangeComponent;
		}

	}
}