package Apollo.Network.Processor 
{
	import Apollo.Center.CCommandCenter;
	import Apollo.CGame;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author john
	 */
	public class CBaseProcessor extends EventDispatcher 
	{
		private var processorName: String;
		protected var woohaGame: CGame;
		protected var commandCenter: CCommandCenter;
		
		public function CBaseProcessor(processorName: String) 
		{
			super(this);
			this.processorName = processorName;
			woohaGame = CGame.getInstance();
			commandCenter = CCommandCenter.getInstance();
		}
		
		public function get name(): String
		{
			return processorName;
		}
		
		public function hook(): void
		{
			return;
		}
		
		public function unhook(): void
		{
			return;
		}
	}

}