package view.groupFight.tiShi
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.groupFight.GroupFightVo;
	
    public class GroupFightOneComponent extends Component
    {
		public var numLable:Label;
		public var groupLable:Label;
		public var timeLable:Label;
		public var titleLable:Label;
		public var numLable1:Label;

		public var closeBtn:Button;
		
        public function GroupFightOneComponent()
        {
            super(ClassUtil.getObject("view.GroupFightOneSkin"));
			
			numLable=createUI(Label,"numLable");
			groupLable=createUI(Label,"groupLable");
			timeLable=createUI(Label,"timeLable");
			titleLable=createUI(Label,"titleLable");
			numLable1=createUI(Label,"numLable1");
			
			closeBtn=createUI(Button,"closeBtn");
			
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
		}
		
		public function upData(starVo:GroupFightVo):void
		{
			numLable.text=starVo.total_warships.toString();
			if(starVo.legion_name!="")
			{
				groupLable.text=starVo.legion_name;				
			}else
			{
				groupLable.text=MultilanguageManager.getString("wurenzhanling");
			}
			if(starVo.remainTime)
			{
				timeLable.text=DateFormatter.formatterTimeSFM(starVo.remainTime/1000);				
			}else
			{
				timeLable.text=MultilanguageManager.getString("wuziyuan");
			}
			titleLable.text=starVo.name;
			numLable1.text=(starVo.total_warships*2).toString();
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupFightEvent(GroupFightEvent.CLOSE_EVENT));
        }
    }
}