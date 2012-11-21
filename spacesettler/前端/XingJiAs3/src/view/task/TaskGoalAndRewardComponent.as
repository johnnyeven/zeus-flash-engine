package view.task
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *任务目标和完成 
	 * @author Administrator
	 * 
	 */	
	public class TaskGoalAndRewardComponent extends Component
	{
		public var taskGoalLabel:Label;
		public var titleLable:Label;
		public var crystalLabel:Label;
		public var brokenCrystaLabel:Label;
		public var tritiumLabel:Label;
		public var darkCrystalLabel:Label;
		public var darkCrystalSp:Sprite;
		
		
		public function TaskGoalAndRewardComponent()
		{
			super(ClassUtil.getObject("view.taskGoalAndRewardSkin"));
			
			titleLable=createUI(Label,"titleLable");
			taskGoalLabel=createUI(Label,"taskGoal_tf");
			crystalLabel=createUI(Label,"crystal");
			brokenCrystaLabel=createUI(Label,"broken_crysta");
			tritiumLabel=createUI(Label,"tritium");
			darkCrystalLabel=createUI(Label,"dark_crystal");
			darkCrystalSp=getSkin("dark_crystal_MC");
			sortChildIndex();
		}
		
		public function isComplete():void
		{
			titleLable.text="任务完成：";
		}
		
		public function isNotComplete():void
		{
			titleLable.text="目标：";			
		}
		
		public function set goalText(value:String):void
		{
			taskGoalLabel.text=value;
		}
		public function set crystalText(value:String):void
		{
			crystalLabel.text=value;
		}
		public function set brokenCrystaText(value:String):void
		{
			brokenCrystaLabel.text=value;
		}
		public function set tritiumText(value:String):void
		{
			tritiumLabel.text=value;
		}
		public function set darkCrystalText(value:String):void
		{
			darkCrystalLabel.text=value;
		}
		public function set isShow(value:Boolean):void
		{
			darkCrystalSp.visible=value;
		}
	}
}