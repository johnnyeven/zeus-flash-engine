package apollo.network.processor 
{
	import apollo.controller.IControllerMovable;
	import apollo.events.*;
	import apollo.CGame;
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
			var scene: CApolloScene = CApolloScene.getInstance();
			var c: CGameObject = scene.getObjectById(protocol.guid);
			if (c == null)
			{
				//如果不存在则创建
				var param: CRoleParameter = new CRoleParameter();
				param.objectId = protocol.guid;
				param.playerName = protocol.characterName;
				param.startX = protocol.posX;
				param.startY = protocol.posY;
				param.speed = protocol.speed;
				var o: CCharacterObject = scene.createRole(protocol.resourceId, protocol.direction, param);
				o.action = protocol.characterAction;
			}
			else
			{
				//如果已经存在则更新状态
				if (c.pos.x != protocol.posX || c.pos.y != protocol.posY)
				{
					c.setPos(new Point(protocol.posX, protocol.posY));
				}
				if (c is CActionObject && (c as CActionObject).action != protocol.characterAction)
				{
					(c as CActionObject).action = protocol.characterAction;
				}
				if (c.direction != protocol.direction)
				{
					c.direction = protocol.direction;
				}
			}
		}
	}

}