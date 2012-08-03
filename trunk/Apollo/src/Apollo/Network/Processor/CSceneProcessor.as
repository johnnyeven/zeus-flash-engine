package Apollo.Network.Processor 
{
	import Apollo.Controller.IControllerMovable;
	import Apollo.Events.*;
	import Apollo.CWoohaGame;
	import Apollo.Objects.*;
	import Apollo.Scene.CWoohaScene;
	import Apollo.Configuration.*;
	import Apollo.Network.Command.CCommandList;
	import Apollo.Network.Command.receiving.*;
	
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
			commandList.bind(0x000b, Receive_NPC_Move_MoveTo);
			commandList.bind(0x010b, Receive_NPC_Move_Move);
		}
		
		override public function hook():void 
		{
			commandCenter.add(0x0000, onCameraViewRefresh);
			commandCenter.add(0x000b, onNPCMoveTo);
			commandCenter.add(0x010b, onNPCMove);
		}
		
		override public function unhook():void 
		{
			commandCenter.remove(0x0000, onCameraViewRefresh);
			commandCenter.remove(0x000b, onNPCMoveTo);
			commandCenter.remove(0x010b, onNPCMove);
		}
		
		private function onNPCMoveTo(protocol: Receive_NPC_Move_MoveTo): void
		{
			var scene: CWoohaScene = CWoohaScene.getInstance();
			var c: CGameObject = scene.getObjectById(protocol.guid);
			if (c == null)
			{
				
			}
			else
			{
				(c.controller as IControllerMovable).moveTo(protocol.targetX, protocol.targetY);
			}
		}
		
		private function onNPCMove(protocol: Receive_NPC_Move_Move): void
		{
			var scene: CWoohaScene = CWoohaScene.getInstance();
			var c: CGameObject = scene.getObjectById(protocol.guid);
		}
		
		private function onCameraViewRefresh(protocol: Receive_Info_CameraView): void
		{
			var scene: CWoohaScene = CWoohaScene.getInstance();
			var c: CGameObject = scene.getObjectById(protocol.guid);
			if (c == null)
			{
				//如果不存在则创建
				var param: Object = new Object();
				param.objectId = protocol.guid;
				param.playerName = protocol.characterName;
				param.startX = protocol.posX;
				param.startY = protocol.posY;
				param.speed = protocol.speed;
				var o: COtherPlayerCharacter = scene.createOtherPlayer(protocol.resourceId, protocol.direction, param);
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