package view.task
{
	import com.zn.utils.ClassUtil;
	
	import events.task.TaskEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import org.osmf.net.StreamingURLResource;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *任务描述 
	 * @author Administrator
	 * 
	 */	
	public class TaskDescripComponent extends Component
	{
		public var descripLabel:Label;
		
//		private var _desXML:XML;
		public function TaskDescripComponent()
		{
			super(ClassUtil.getObject("view.taskDesSkin"));
			
			descripLabel=createUI(Label,"descrip_tf");
			
			sortChildIndex();
		}
		
		public function set content(value:String):void
		{
			descripLabel.text=value;
		}
	}
}