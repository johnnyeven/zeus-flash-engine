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
	import proxy.scienceResearch.ScienceResearchProxy;
	
	import view.cangKu.ChaKanTuZhiViewComponent;
	
	import vo.cangKu.ItemVO;
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
			var _arr1:Array=[];
			var _arr2:Array=[];
			var itemVo:ItemVO=event.itemVO as ItemVO;
			researchProxy.getScienceResearchInfor(function():void
			{
				var bool:Boolean=true;
				var arr:Array=researchProxy.reaearchList
				for(var  i:int=0;i<arr.length;i++)
				{
					var reVo:ScienceResearchVO=arr[i] as ScienceResearchVO;//当前科技等级的Vo
					for(var j:int=0;j<itemVo.techVOList.length;j++)
					{
						var resvo:ScienceResearchVO=itemVo.techVOList[j] as ScienceResearchVO;//图纸需要科技的VO
						//当科技类型一样时 如果满足图纸Vo的需要等级大于当前科技的等级时 就为false；如果都不满足 就是说所有学习条件都满足 此时可以学习图纸
						if(reVo.science_type==resvo.science_type&&reVo.level<resvo.level)
						{
							bool=false;
						}
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
					var obj:Object={};
					obj.infoLable=MultilanguageManager.getString("useItemshibai");
					obj.showLable=MultilanguageManager.getString("useItemclose");
					sendNotification(PromptSureMediator.SHOW_NOTE,obj);
				}
			});	
		}
	}
}