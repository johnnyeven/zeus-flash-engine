package view.login
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.ColorUtil;
	
	import events.login.PkEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 *阵营
	 * @author lw
	 *
	 */
    public class PkComponent extends Component
    {
		public var alliance:MovieClip;
		
		public var haiDao:MovieClip;
		
		public var returnBtn:Button;
		
		public var beginBtn:Button;
		
		private var _currentSelectedCamp:MovieClip;

		public var campID:int=0;
		
        public function PkComponent()
        {
            super(ClassUtil.getObject("view.login.PkSkin"));
			
			alliance = getSkin("allianceMC") as MovieClip;
			alliance.buttonMode = true;
			
			haiDao = getSkin("haiDaoMC") as MovieClip;
			haiDao.buttonMode = true;
			haiDao.mouseEnabled=alliance.mouseEnabled=true;
			
			
			returnBtn=createUI(Button,"returnBtn");
			beginBtn=createUI(Button,"beginBtn");
			
			sortChildIndex();
			
			alliance.addEventListener(MouseEvent.CLICK,allianceBtn_clickHandler);
			haiDao.addEventListener(MouseEvent.CLICK,haiDaoBtn_clickHandler);
			returnBtn.addEventListener(MouseEvent.CLICK,returnBtn_clickHandler);
			beginBtn.addEventListener(MouseEvent.CLICK,beginBtn_clickHandler);

			currentSelectedCamp=alliance;

        }
		
		protected function beginBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new PkEvent(PkEvent.START_EVENT,campID));
		}
		
		protected function returnBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new PkEvent(PkEvent.BACK_EVENT));
		}
		
		protected function haiDaoBtn_clickHandler(event:MouseEvent):void
		{
			currentSelectedCamp=haiDao;
		}
		
		protected function allianceBtn_clickHandler(event:MouseEvent):void
		{

			currentSelectedCamp=alliance;

		}
		
		public function get currentSelectedCamp():MovieClip
		{
			return _currentSelectedCamp;
		}
		
		public function set currentSelectedCamp(value:MovieClip):void
		{
			if(currentSelectedCamp)
			{
				currentSelectedCamp.gotoAndStop(1);
//			   currentSelectedCamp.filters=null;
//				_currentSelectedCamp=null;
			}
			
			_currentSelectedCamp = value;
			_currentSelectedCamp.gotoAndStop(2);
//			_currentSelectedCamp.filters=[ColorUtil.selectedFilter];
			
			if(currentSelectedCamp==alliance)
				campID=0;
			else
				campID=1;
		}
	}
}