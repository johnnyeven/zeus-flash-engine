package mediator
{
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import utils.GameManager;
	
	public class BaseMediator extends Mediator implements IMediator
	{
		protected var _isPopUp: Boolean = false;
		public var mode: Boolean = false;
		public var onShow: Function;
		public var onDestroy: Function;
		
		public function BaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		public function get comp(): DisplayObject
		{
			return viewComponent as DisplayObject;
		}
		
		public function isShow(): Boolean
		{
			return comp.stage == null ? false : true;
		}
		
		public function show(): void
		{
			if(isShow())
			{
				return;
			}
			addComponent();
		}
		
		protected function addComponent(): void
		{
			if(_isPopUp)
			{
				
			}
			else
			{
				GameManager.instance.addBase(comp);
			}
		}
	}
}