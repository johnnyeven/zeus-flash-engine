package mediator.cangKu
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import events.buildingView.ConditionEvent;
	import events.cangKu.ChaKanEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.buildingView.ConditionViewCompMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.factory.FactoryProxy;
	import proxy.packageView.PackageViewProxy;
	import proxy.scienceResearch.ScienceResearchProxy;
	
	import view.cangKu.ChaKanTuZhiViewComponent;
	
	import vo.cangKu.ItemVO;
	import vo.factory.DrawListVo;
	import vo.scienceResearch.ScienceResearchVO;

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
		private var researchProxy:ScienceResearchProxy;
		public function ChaKanTuZhiViewComponentMediator(viewComponent:Object=null)
		{
			super(NAME, new ChaKanTuZhiViewComponent(ClassUtil.getObject("tuZhiChaKan_View")));
			packageProxy=getProxy(PackageViewProxy);
			researchProxy=getProxy(ScienceResearchProxy);
			
			comp.med=this;
			level = 2;
			comp.addEventListener(ChaKanEvent.CLOSEVIEW_EVENT,closeHandler);
			comp.addEventListener(ChaKanEvent.USE_EVENT,useHandler);
			comp.addEventListener(ConditionEvent.ADDCONDITIONVIEW_EVENT,addConditionViewHandler);
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
		public function get comp():ChaKanTuZhiViewComponent
		{
			return viewComponent as ChaKanTuZhiViewComponent;
		}
		
		protected function closeHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function addConditionViewHandler(event:ConditionEvent):void
		{
			sendNotification(ConditionViewCompMediator.SHOW_NOTE,event.conditionArr);
		}
		
		protected function useHandler(event:ChaKanEvent):void
		{
			var itemVo:ItemVO=event.itemVO as ItemVO;
			var bool:Boolean=true;
			var factoryProxy:FactoryProxy=getProxy(FactoryProxy);
			factoryProxy.makeList(function():void
			{
				for(var i:int=0;i<factoryProxy.makeListArr.length;i++)
				{
					var item:DrawListVo=factoryProxy.makeListArr[i] as DrawListVo;
					if(itemVo.type==item.type&&itemVo.category==item.category
						&&itemVo.enhanced==item.enhanced&&itemVo.recipe_type==item.recipe_type)
					{
						bool=false;
					}
				}
				
				if(bool)
				{
					packageProxy.useItem(itemVo.id,function():void
					{
						var obj:Object={};
						obj.showLable=MultilanguageManager.getString("useIteminfo");
						sendNotification(PromptSureMediator.SHOW_NOTE,obj);
						sendNotification(DESTROY_NOTE);	
					});
				}else
				{
					var obj1:Object={};
					obj1.showLable="图纸已经学习！";
					sendNotification(PromptSureMediator.SHOW_NOTE,obj1);
					sendNotification(DESTROY_NOTE);	
				}			
			});
		}
			
	}
}