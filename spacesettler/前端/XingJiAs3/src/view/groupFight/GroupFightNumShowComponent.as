package view.groupFight
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *球形显示  只有星球被占领才会显示
	 * @author Administrator
	 * 
	 */	
    public class GroupFightNumShowComponent extends Component
    {
		/**
		 *自身战舰数 
		 */		
		public var lable2:Label;
		
		/**
		 *军团战舰数 
		 */		
		public var lable1:Label;
		
		/**
		 *自身战舰数 如果没有 则不显示
		 */		
		public var mc:Sprite;
		
		/**
		 *背景 
		 */		
		public var mc1:Sprite;

		
        public function GroupFightNumShowComponent(skin:DisplayObjectContainer)
        {
            super(skin);
			
			lable1=createUI(Label,"lable1");
			lable2=createUI(Label,"lable2");
			mc=getSkin("mc");
			mc1=getSkin("mc1");
			
			sortChildIndex();
        }
    }
}