package apollo.network.processor 
{
	import apollo.center.CBuildingCenter;
	import apollo.controller.IControllerMovable;
	import apollo.events.*;
	import apollo.CGame;
	import apollo.network.data.basic.CBuildingParameter;
	import apollo.network.data.CRoleParameter;
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
	public class CSceneProcessor extends CBaseProcessor 
	{
		
		public function CSceneProcessor() 
		{
			super("Processor.SceneProcessor");
			var commandList: CCommandList = CCommandList.getInstance();
			commandList.bind(0x0000, Receive_Info_CameraView);
		}
		
		override public function hook():void 
		{
			commandCenter.add(0x0000, onCameraViewRefresh);
		}
		
		override public function unhook():void 
		{
			commandCenter.remove(0x0000, onCameraViewRefresh);
		}
		
		private function onCameraViewRefresh(protocol: Receive_Info_CameraView): void
		{
			for (var key: String in protocol.BuildingList)
			{
				CApolloScene.getInstance().createBuilding(protocol.BuildingList[key], false);
			}
		}
	}

}