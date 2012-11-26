package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	/**
	 *战场左上角玩家信息 
	 * @author gx
	 * 
	 */	
	public class BattleNameItemComponent extends Component
	{
		public var vipNameComp:Component;
		public var vipNameLabel:Label;
		public var nameComp:Component;
		public var nameLabel:Label;
		public var progressBar:ProgressBar;
		
		public var timer:Timer;
		
		private var _player1:PLAYER1;
		private var _hp:Number;
		public function BattleNameItemComponent()
		{
			super(ClassUtil.getObject("battle.namePanelSkin"));
			
			vipNameComp=createUI(Component,"vipnamesp");
			nameComp=createUI(Component,"namesp");
			progressBar=createUI(ProgressBar,"progressBar");
			
			vipNameLabel=vipNameComp.createUI(Label,"nameLabel");
			vipNameLabel.sortChildIndex();
			nameLabel=nameComp.createUI(Label,"nameLabel");
			nameLabel.sortChildIndex();
			
			sortChildIndex();
			
			timer=new Timer(100);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		
		public function setValue(isVip:Boolean,str:String):void
		{
			vipNameComp.visible=false;
			nameComp.visible=false;
			vipNameLabel.text="";
			nameLabel.text="";
			progressBar.percent=100;
			if(isVip)
			{
				vipNameComp.visible=true;
				vipNameLabel.text=str;
			}
			else
			{
				nameComp.visible=true;
				nameLabel.text=str;
			}
		}
		
		public function get HP():Number
		{
			return _hp;
		}
		
		public function set HP(value:Number):void
		{
			_hp=value;
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			progressBar.percent=_player1.chariots[0].currentEndurance/_player1.chariots[0].totalEndurance;
		}
		
		public function get info():PLAYER1
		{
			return _player1;
		}
		
		public function set info(value:PLAYER1):void
		{
			_player1=value;
		}
		
		public override function dispose():void
		{
			super.dispose();
			stopTimer();
		}
		public function stopTimer():void
		{
			if(timer!=null)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				timer=null;				
			}
		}
	}
}