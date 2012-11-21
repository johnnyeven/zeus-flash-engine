package mediator.groupFight
{
	import enum.groupFightEnum.GroupFightEnum;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.groupFight.tiShi.GroupFightOneComponentMediator;
	import mediator.groupFight.tiShi.GroupFightThreeComponentMediator;
	import mediator.groupFight.tiShi.GroupFightTwoComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.groupFight.GroupFightProxy;
	
	import view.groupFight.GroupFightComponent;
	
	import vo.groupFight.LossReportVo;

	public class GroupFightComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static const CHANGE_NOTE:String="change" + NAME + "Note";
		
		public static const ATTACK_NOTE:String="attack" + NAME + "Note";
		
		public static const SENCECHANGE_NOTE:String="senceChange" + NAME + "Note";
		
		private var groupFightProxy:GroupFightProxy;
		public function GroupFightComponentMediator()
		{
			super(NAME, new GroupFightComponent());
			_popUp=false;
			groupFightProxy=getProxy(GroupFightProxy);
			comp.addEventListener(GroupFightEvent.CHAKAN_EVENT,chaKanHandler);
			comp.addEventListener(GroupFightEvent.PAIQIAN_EVENT,paiQianHandler);
			comp.addEventListener(GroupFightEvent.GONGJI_EVENT,gongJiHandler);
			comp.addEventListener(GroupFightEvent.BACK_EVENT,backHandler);
			comp.addEventListener(GroupFightEvent.SENCE_EVENT,rectMoveHandler);
		}		
		
		protected function rectMoveHandler(event:GroupFightEvent):void
		{
			sendNotification(GroupFightMapComponentMediator.MOVE_NOTE,event);
		}
		
		protected function backHandler(event:GroupFightEvent):void
		{
			sendNotification(GroupFightMenuComponentMediator.SHOW_HIDE_NOTE);
			sendNotification(GroupFightShowComponentMediator.SHOW_HIDE_NOTE);
		}
		
		protected function gongJiHandler(event:GroupFightEvent):void
		{
			groupFightProxy.move_to_star(GroupFightEnum.CURRTENT_STARVO.name,GroupFightEnum.CURRTENT_TO_STARVO.name,
				GroupFightEnum.NUM,function():void
				{
					sendNotification(GroupFightMenuComponentMediator.SHOW_HIDE_NOTE);
					sendNotification(GroupFightShowComponentMediator.SHOW_HIDE_NOTE);
					GroupFightComponent.MOUSE_ENABLED=true;
				});				
		}
		
		protected function paiQianHandler(event:GroupFightEvent):void
		{
			sendNotification(GroupFightTwoComponentMediator.SHOW_NOTE);
		}
		
		protected function chaKanHandler(event:GroupFightEvent):void
		{
			var obj:Object={};
			obj.num=GroupFightEnum.MONEY
			obj.fun=function():void
			{
				sendNotification(GroupFightOneComponentMediator.SHOW_NOTE);
			}
			sendNotification(GroupFightThreeComponentMediator.SHOW_NOTE,obj);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,CHANGE_NOTE,ATTACK_NOTE,SENCECHANGE_NOTE];
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
					comp.changeHander();
					break;
				}
				case ATTACK_NOTE:
				{
					sendNotification(GroupFightMenuComponentMediator.HIDE_NOTE);
					sendNotification(GroupFightShowComponentMediator.HIDE_NOTE);
					var lossReportVo:LossReportVo=new LossReportVo();
					lossReportVo.send_warships=GroupFightEnum.NUM;
					lossReportVo.send_warships_1=GroupFightEnum.CURRTENT_TO_STARVO.total_warships;
					comp.attack(lossReportVo);
					break;
				}
				case SENCECHANGE_NOTE:
				{
					var e:GroupFightEvent=note.getBody() as GroupFightEvent;
					comp.senceChange(e.starVO);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():GroupFightComponent
		{
			return viewComponent as GroupFightComponent;
		}

	}
}