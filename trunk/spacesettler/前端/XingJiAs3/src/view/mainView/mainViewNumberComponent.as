package view.mainView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.core.Component;
	
    public class mainViewNumberComponent extends Component
    {
		public var mc9:Sprite;
		public var mc8:Sprite;
		public var mc7:Sprite;
		public var mc6:Sprite;
		public var mc5:Sprite;
		public var mc4:Sprite;
		public var mc3:Sprite;
		public var mc2:Sprite;
		public var mc1:Sprite;
		public var mc0:Sprite;

        public function mainViewNumberComponent(skin:DisplayObjectContainer)
        {
            super(skin);
			
			mc0=getSkin("mc0");
			mc1=getSkin("mc1");
			mc2=getSkin("mc2");
			mc3=getSkin("mc3");
			mc4=getSkin("mc4");
			mc5=getSkin("mc5");
			mc6=getSkin("mc6");
			mc7=getSkin("mc7");
			mc8=getSkin("mc8");
			mc9=getSkin("mc9");
			
			sortChildIndex();
			mc0.visible=mc1.visible=mc2.visible=mc3.visible=mc4.visible=false;
			mc5.visible=mc6.visible=mc7.visible=mc8.visible=mc9.visible=false;
        }
		
		public function showNum(num:int):void
		{
			switch(num)
			{
				case 0:
				{
					mc0.visible=true;
					break;
				}
				case 1:
				{
					mc1.visible=true;
					break;
				}
				case 2:
				{
					mc2.visible=true;
					break;
				}
				case 3:
				{
					mc3.visible=true;
					break;
				}
				case 4:
				{
					mc4.visible=true;
					break;
				}
				case 5:
				{
					mc5.visible=true;
					break;
				}
				case 6:
				{
					mc6.visible=true;
					break;
				}
				case 7:
				{
					mc7.visible=true;
					break;
				}
				case 8:
				{
					mc8.visible=true;
					break;
				}
				case 9:
				{
					mc9.visible=true;
					break;
				}
			}
		}
    }
}