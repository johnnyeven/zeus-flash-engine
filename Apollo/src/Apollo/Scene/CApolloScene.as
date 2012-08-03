package Apollo.Scene 
{
	import Apollo.Controller.*;
	import Apollo.Objects.*;
	import Apollo.Objects.Effects.*;
	import Apollo.Renders.*;
	import Apollo.Graphics.*;
	import Apollo.Maps.CWorldMap;
	import Apollo.utils.GUID;
	import Apollo.Configuration.*;
	import flash.errors.IllegalOperationError;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CApolloScene extends CBaseScene 
	{
		protected var render_npc: CRenderNPC;
		protected var render_monster: CRenderMonster;
		protected var render_player: CRenderCharacter;
		private static var instance: CApolloScene;
		private static var allowInstance: Boolean = false;
		
		public function CApolloScene() 
		{
			super(GlobalContextConfig.container, GlobalContextConfig.stage);
			if (!allowInstance)
			{
				throw new IllegalOperationError("CApolloScene类不允许实例化");
			}
			render_npc = new CRenderNPC();
			render_monster = new CRenderMonster();
			render_player = new CRenderCharacter();
		}
		
		public static function getInstance(): CApolloScene
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CApolloScene();
				allowInstance = false;
			}
			return instance;
		}
		
		public static function terminateInstance(): void
		{
			instance.clear();
			instance = null;
		}
		
		public function createPlayer(): void
		{
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool(CharacterData.ResourceId, 8, 4, 7);
			var perception: CPerception = new CPerception(this);
			var ctrl: CCharacterController = new CCharacterController(perception);
			var player: CCharacterObject = new CCharacterObject(ctrl, CharacterData.Direction);
			player.objectId = CharacterData.Guid;
			player.objectName = "player";
			player.healthMax = CharacterData.HealthMax;
			player.health = CharacterData.Health;
			player.attackRange = CharacterData.AttackRange;
			player.attackSpeed = CharacterData.AttackSpeed;
			player.canBeAttack = true;
			player.graphic = rs;
			player.inUse = true;
			player.beFocus = true;
			player.render = render_player;
			player.speed = 7;
			player.setCharacterName(CharacterData.UserName, 0xFFFFFF, 0x000000);
			//player.setPos(new Point(startX, startY));
			player.setPos(new Point(CharacterData.PosX, CharacterData.PosY));
			_player = player;
			setPlayerController(ctrl);
			addObject(player);
			//_map.follow(player);
		}
		
		public function createOtherPlayer(resourceId: String, startDirection: uint = CDirection.DOWN, parameter: Object = null): COtherPlayerCharacter
		{
			var c: COtherPlayerController = _ctrlCenter.getOtherController(parameter.objectId);
			if (parameter != null && parameter.objectId != undefined && c != null)
			{
				return null;
			}
			//图形素材
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool(resourceId, 8, 4, 7);
			
			//感知器
			var perception: CPerception = new CPerception(this);
			//配置控制器
			var controller: COtherPlayerController = new COtherPlayerController(perception);
			//渲染器
			var render: CRenderOtherCharacter = new CRenderOtherCharacter();
			
			//初始化游戏对象
			var id: String;
			if (parameter != null)
			{
				if (parameter.objectId != undefined)
				{
					id = parameter.objectId;
				}
				else
				{
					id = GUID.create();
				}
			}
			var player: COtherPlayerCharacter = new COtherPlayerCharacter(controller, startDirection);
			
			player.objectId = id;
			player.graphic = rs;
			player.render = render;
			player.action = Action.STOP;
			player.speed = parameter.speed;
			
			if (parameter != null)
			{
				if (parameter.playerName != undefined)
				{
					player.setCharacterName(parameter.playerName, 0x00FFFF, 0x000000);
				}
				if (parameter.startX != undefined && parameter.startY != undefined)
				{
					player.setPos(new Point(parameter.startX, parameter.startY));
				}
			}
			setOtherPlayerController(controller, player.objectId);
			addObject(player);
			
			return player;
		}
		
		public function createNPC(): CNPCCharacter
		{
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool("char8", 8, 4, 7);
			var perception: CPerception = new CPerception(this);
			var ctrl: CNPCController = new CNPCController(perception);
			var npc: CNPCCharacter = new CNPCCharacter("npc001", ctrl);
			npc.objectId = 'fcd52e6c-6184-4920-870e-9c04e9bfb18c';
			npc.graphic = rs;
			//npc.inUse = true;
			npc.render = render_npc;
			npc.speed = 5;
			npc.setCharacterName('配角李四', 0x00FFFF, 0x000000);
			npc.setPos(new Point(4671, 2667));
			npc.action = Action.STOP;
			//npc.follow = _player;
			setNPCController(ctrl, npc.objectId);
			addObject(npc);
			
			return npc;
		}
		
		public function createMonster(): CMonsterCharacter
		{
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool("char4", 8, 4, 7);
			var perception: CPerception = new CPerception(this);
			var ctrl: CMonsterController = new CMonsterController(perception);
			var monster: CMonsterCharacter = new CMonsterCharacter("monster001_1", ctrl);
			monster.objectId = 'b77e32e8-1482-4dbd-8565-6848acce1b2d';
			monster.healthMax = 40000;
			monster.health = 40000;
			monster.attackRange = 100;
			monster.attackSpeed = 0.5;
			monster.canBeAttack = true;
			monster.graphic = rs;
			//monster.inUse = true;
			monster.render = render_monster;
			monster.speed = 5;
			monster.setCharacterName('被动怪', 0x00FFFF, 0x000000);
			monster.setPos(new Point(4325, 2837));
			monster.action = Action.STOP;
			//npc.follow = _player;
			//setNPCController(ctrl, npc.objectId);
			setMonsterController(ctrl, monster.objectId);
			addObject(monster);
			
			return monster;
		}
	}

}