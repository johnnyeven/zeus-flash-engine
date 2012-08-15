package apollo.network.processor 
{
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author john
	 */
	public class CProcessorRouter 
	{
		private var processorList: Array;
		private static var instance: CProcessorRouter;
		private static var allowInstance: Boolean = false;
		
		public function CProcessorRouter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CProcessorRouter不允许实例化");
			}
			processorList = new Array();
		}
		
		public function refreash(): void
		{
			for each(var processor: CBaseProcessor in processorList)
			{
				processor.unhook();
				processor.hook();
			}
		}
		
		public function add(processor: CBaseProcessor): void
		{
			processorList.push(processor);
			processor.hook();
		}
		
		public function remove(processor: CBaseProcessor): void
		{
			for (var i:int = 0; i < processorList.length; i++)
			{
				if (processorList[i] == processor)
				{
					processorList.slice(i, 1);
					processor.unhook();
					return;
				}
			}
		}
		
		public static function getInstance(): CProcessorRouter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CProcessorRouter();
				allowInstance = false;
			}
			return instance;
		}
	}

}