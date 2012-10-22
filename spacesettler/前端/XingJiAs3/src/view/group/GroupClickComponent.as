package view.group
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.core.Component;
	
    public class GroupClickComponent extends Component
    {
		public var mc_6:Sprite;
		public var mc_5:Sprite;
		public var mc_4:Sprite;
		public var mc_3:Sprite;
		public var mc_2:Sprite;
		public var mc_1:Sprite;

		
        public function GroupClickComponent(skin:DisplayObjectContainer)
        {
            super(skin);
			mc_1=getSkin("mc_1")
			mc_2=getSkin("mc_2")
			mc_3=getSkin("mc_3")
			mc_4=getSkin("mc_4")
			mc_5=getSkin("mc_5")
			mc_6=getSkin("mc_6")
				
			sortChildIndex();
        }
    }
}