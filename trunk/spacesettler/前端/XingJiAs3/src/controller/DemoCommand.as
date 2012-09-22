package controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ShowSelectorViewComponentMediatorCommand extends SimpleCommand
	{
		public function ShowSelectorViewComponentMediatorCommand()
		{
			super();
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
		}

	}
}