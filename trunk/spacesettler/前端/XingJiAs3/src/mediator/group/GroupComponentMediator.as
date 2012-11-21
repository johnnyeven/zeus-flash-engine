package mediator.group
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.SenceTypeEnum;
	import enum.groupFightEnum.GroupFightEnum;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.groupFight.GroupFightComponentMediator;
	import mediator.groupFight.GroupFightMapComponentMediator;
	import mediator.groupFight.GroupFightMenuComponentMediator;
	import mediator.groupFight.GroupFightShowComponentMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.BuildProxy;
	import proxy.group.GroupProxy;
	import proxy.groupFight.GroupFightProxy;
	
	import view.group.GroupComponent;
	
	import vo.GlobalData;
	import vo.groupFight.GroupFightVo;

	public class GroupComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public static const CHANGE_NOTE:String="change_note";
		
		private var groupProxy:GroupProxy;
		private var buildProxy:BuildProxy;
		private var groupFightProxy:GroupFightProxy;

		private var bool1:Boolean;

		private var bool2:Boolean;

		private var bool3:Boolean;

		private var bool4:Boolean;
		public function GroupComponentMediator()
		{
			super(NAME, new GroupComponent());
			groupProxy=getProxy(GroupProxy);
			buildProxy=getProxy(BuildProxy);
			comp.med=this;
			level=1;
			
			groupFightProxy=getProxy(GroupFightProxy);			
			upData();
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,closeHandler);
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_GROUPMANAGE,showGroupManageHandler);
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_LOOKMEMBER,showLookMemberHandler)
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_MEMBERMANAGE,showMemberManageHandler);
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_PLANE_EVENT,showPlaneHandler);
			comp.addEventListener(GroupEvent.BUCHONG_EVENT,buChongHandler);
		}
		
		private function upData():void
		{
			groupFightProxy=getProxy(GroupFightProxy);
			groupFightProxy.get_star_map(function():void
			{
				for(var i:int=0;i<groupFightProxy.starArr.length;i++)
				{
					var starVo:GroupFightVo=groupFightProxy.starArr[i] as GroupFightVo;
					if(starVo.name==GroupFightEnum.ZIYUAN3_STAR)
					{
						bool1=starVo.isMine;
					}
					if(starVo.name==GroupFightEnum.ZIYUAN1_STAR)
					{
						bool2=starVo.isMine;
					}
					if(starVo.name==GroupFightEnum.ZIYUAN2_STAR)
					{
						bool3=starVo.isMine;
					}
					if(starVo.name==GroupFightEnum.ZHU_STAR)
					{
						bool4=starVo.isMine;
					}
				}
				
				comp.upData(groupProxy.groupInfoVo,bool1,bool2,bool3,bool4);
			})
		}
		
		protected function showPlaneHandler(event:GroupShowAndCloseEvent):void
		{
			if (GlobalData.currentSence == SenceTypeEnum.GROUP_FIGHT)
				return;
			var buildProxy:BuildProxy=getProxy(BuildProxy);
			buildProxy.isBuild=false;
			groupFightProxy.get_star_map(function():void
			{
					sendNotification(MainViewMediator.HIDE_RIGHT_VIEW_NOTE);
					sendNotification(MainViewMediator.HIDE_RENWU_VIEW_NOTE);
					sendNotification(GroupFightComponentMediator.SHOW_NOTE);
					sendNotification(GroupFightMenuComponentMediator.SHOW_NOTE);
					sendNotification(GroupFightShowComponentMediator.SHOW_NOTE);
					sendNotification(GroupFightMapComponentMediator.SHOW_NOTE);
					sendNotification(MainViewMediator.HIDE_TOP_VIEW_NOTE);
					sendNotification(DESTROY_NOTE);
			});
		}
		
		protected function buChongHandler(event:GroupEvent):void
		{
			groupProxy.get_warship(function():void
			{
				comp.current_warship=groupProxy.groupInfoVo.current_warship;
				var obj:Object={};
				obj.infoLable=MultilanguageManager.getString("lingqu");
				obj.showLable=MultilanguageManager.getString("lingquNum")+comp.gapNum.toString()+"艏";
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			});
		}
		
		protected function closeHandler(event:GroupShowAndCloseEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function showGroupManageHandler(event:GroupShowAndCloseEvent):void
		{
			sendNotification(GroupManageComponentMediator.SHOW_NOTE);
		}
		
		protected function showLookMemberHandler(event:GroupShowAndCloseEvent):void
		{
			groupProxy.groupMemberList(groupProxy.groupInfoVo.id,function():void
			{				
				sendNotification(GroupMemberComponentMediator.SHOW_NOTE);
			});
		}
		
		protected function showMemberManageHandler(event:GroupShowAndCloseEvent):void
		{
			groupProxy.groupMemberList(groupProxy.groupInfoVo.id,function():void
			{				
				sendNotification(GroupMemberManageComponentMediator.SHOW_NOTE);
			});
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
					upData();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():GroupComponent
		{
			return viewComponent as GroupComponent;
		}

	}
}