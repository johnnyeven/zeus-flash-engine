package apollo.network.processor 
{
	import apollo.center.CResourceCenter;
	import apollo.controller.IControllerMovable;
	import apollo.events.*;
	import apollo.CGame;
	import apollo.network.data.CResourceParameter;
	import apollo.objects.*;
	import apollo.scene.CApolloScene;
	import apollo.configuration.*;
	import apollo.network.command.CCommandList;
	import apollo.network.command.receiving.*;
	
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author john
	 */
	public class CResourceProcessor extends CBaseProcessor 
	{
		
		public function CResourceProcessor() 
		{
			super("Processor.ResourceProcessor");
			var commandList: CCommandList = CCommandList.getInstance();
			commandList.bind(0x0001, Receive_Info_RequestResources);
		}
		
		override public function hook():void 
		{
			commandCenter.add(0x0001, onResourcesRefresh);
		}
		
		override public function unhook():void 
		{
			commandCenter.remove(0x0001, onResourcesRefresh);
		}
		
		private function onResourcesRefresh(protocol: Receive_Info_RequestResources): void
		{
			for (var key: String in protocol.ResourcesList)
			{
				var resource: CResourceParameter = protocol.ResourcesList[key] as CResourceParameter;
				CResourceCenter.getInstance().registerResource(resource.resourceId, resource, resource.resourceMax);
			}
		}
	}

}