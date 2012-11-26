package view.task
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mediator.task.taskGideComponentMediator;
	
	import ui.core.Component;
	
	/**
	 *箭头动画 
	 * @author Administrator
	 * 
	 */	
	public class TaskGideViewComponent extends Component
	{
		public var gideMC:MovieClip;
		
		private var _objContainer:DisplayObjectContainer;
		private var point:Point;
		public function TaskGideViewComponent()
		{
			super(ClassUtil.getObject("view.taskGideSkin"));
			
			gideMC=getSkin("gideMC");
			point=new Point();
			this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			
		}	
		
		protected function enterFrameHandler(event:Event):void
		{
			if(objContainer)
			{
				this.rotation=0;
				point=objContainer.localToGlobal(new Point());
				if(objContainer.visible==false)
				{
					this.visible=false;
				}else
				{
					this.visible=true;
				}
//				this.x=point.x+objContainer.width*0.5;
//				this.y=point.y;
				var point1:Point=parent.globalToLocal(point);
				this.x=point1.x+objContainer.width*0.5;
				this.y=point1.y;
				if(this.y<60)
				{
					this.rotation=-90;
					this.x=point1.x;
					this.y=point1.y+objContainer.height*0.5;
				}
			}
			
		}
		
		public function setAddress(obj:DisplayObjectContainer):void
		{
			objContainer=obj;
		}
		
		public override function dispose():void
		{
			if(_objContainer)
				_objContainer.removeEventListener(Event.REMOVED_FROM_STAGE,removeFromStage);
			this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			super.dispose();
			_objContainer=null;
		}

		public function get objContainer():DisplayObjectContainer
		{
			return _objContainer;
		}

		public function set objContainer(value:DisplayObjectContainer):void
		{
			if(_objContainer)
			{
				_objContainer.removeEventListener(Event.REMOVED_FROM_STAGE,removeFromStage);
				_objContainer=null;
			}
			
			_objContainer = value;
			
			if(_objContainer)
			{
				_objContainer.addEventListener(Event.REMOVED_FROM_STAGE,removeFromStage);
			}
		}

		protected function removeFromStage(event:Event):void
		{
			ApplicationFacade.getInstance().sendNotification(taskGideComponentMediator.DESTROY_NOTE);
		}
	}
}