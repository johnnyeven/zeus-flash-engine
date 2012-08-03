package Apollo.Network.Processor 
{
	import Apollo.Controller.Skill.CSkillNPC;
	import Apollo.Events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import Apollo.CWoohaGame;
	import Apollo.Objects.*;
	import Apollo.Scene.CWoohaScene;
	import Apollo.Configuration.*;
	import Apollo.Network.Command.CCommandList;
	import Apollo.Network.Command.receiving.*;
	import Apollo.Controller.Skill.SkillConfig;
	import Apollo.Graphics.CGraphicCharacter;
	import Apollo.Objects.Effects.*;
	import Apollo.Renders.*;
	
	/**
	 * ...
	 * @author john
	 */
	public class CBattleProcessor extends CBaseProcessor 
	{
		
		public function CBattleProcessor() 
		{
			super("Processor.BattleProcessor");
			var commandList: CCommandList = CCommandList.getInstance();
			commandList.bind(0x0003, Receive_Battle_Attack);
			commandList.bind(0x030d, Receive_NPC_Battle_Sing);
		}
		
		override public function hook():void 
		{
			commandCenter.add(0x0003, onAttackConfirm);
			commandCenter.add(0x030d, onNPCSingConfirm);
		}
		
		override public function unhook():void 
		{
			commandCenter.remove(0x0003, onAttackConfirm);
			commandCenter.remove(0x030d, onNPCSingConfirm);
		}
		
		private function onAttackConfirm(protocol: Receive_Battle_Attack): void
		{
			//爆炸特效
			var skillConfig: Object = SkillConfig.getSkillConfig(protocol.skillId);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			var explode: CExplodeEffect = new CExplodeEffect(CWoohaScene.getInstance(), CWoohaScene.getInstance().player, protocol.target);
			rs.getResourceFromPool(protocol.skillId + "_EXPLODE", 1, skillConfig.explode, 15);
			explode.graphic = rs;
			var render: CRenderEffect = new CRenderEffect();
			explode.render = render;
			CWoohaScene.getInstance().addObject(explode);
			
			if (protocol.AttackInfo.length > 0)
			{
				for each(var o: Object in protocol.AttackInfo)
				{
					if (o.TargetId != null)
					{
						if (o.TargetId != '')
						{
							var scene: CWoohaScene = CWoohaScene.getInstance();
							var target: CCharacterObject = scene.getCharacterById(o.TargetId);
							target.underAttack(o.AttackPower);
						}
					}
				}
			}
			else
			{
				trace("范围攻击没有击中目标");
			}
		}
		
		private function onNPCSingConfirm(protocol: Receive_NPC_Battle_Sing): void
		{
			var scene: CWoohaScene = CWoohaScene.getInstance();
			var target: CCharacterObject = scene.getCharacterById(protocol.guid);
			target.direction = protocol.direction;
			(target.controller.skillController as CSkillNPC).showSingEffectEx(protocol.skillId, protocol.skillLevel, protocol.target);
		}
	}

}