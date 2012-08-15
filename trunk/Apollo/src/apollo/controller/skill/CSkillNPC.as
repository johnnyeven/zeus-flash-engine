package apollo.controller.skill 
{
	import apollo.objects.CActionObject;
	import apollo.objects.effects.*;
	import apollo.graphics.CGraphicCharacter;
	import apollo.renders.CRenderEffect;
	import apollo.events.SkillEvent;
	import apollo.controller.KeyCode;
	import apollo.controller.skill.SkillConfig;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class CSkillNPC extends CSkill
	{
		public function CSkillNPC(owner: CActionObject) 
		{
			super(owner);
		}
		
		override public function showRangeAttack(keyCode: int): void
		{
			return;
		}
		
		override protected function onRangeAttackConfirm(event: SkillEvent): void
		{
			return;
		}
		
		override public function showSingEffect(keyCode: int, target: * ): void
		{
			var obj: Object = target as Object;
			showSingEffectEx(obj.skillId, obj.skillLevel, obj.target);
			return;
		}
		
		public function showSingEffectEx(skillId: String, skillLevel: int, target: *): void
		{
			var skillConfig: Object = SkillConfig.getSkillConfig(skillId);
			
			var sing: CSingEffect = new CSingEffect(_controlObject, _controlObject.controller.perception.scene, skillId, target);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool("prepareSkill", 1, 6, 30);
			sing.graphic = rs;
			sing.singTime = skillConfig.level[skillLevel].singTime;
			var render: CRenderEffect = new CRenderEffect();
			sing.render = render;
			sing.addEventListener(SkillEvent.SING_COMPLETED, onSkillPrepared);
			_controlObject.controller.perception.scene.addObject(sing);
		}
		
		override protected function onSkillPrepared(event: SkillEvent): void
		{
			var skillConfig: Object = SkillConfig.getSkillConfig(event.data.skillId);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			var render: CRenderEffect = new CRenderEffect();
			if (skillConfig.fire != 0)
			{
				var skill: CSkillEffect = new CSkillEffect(_controlObject.controller.perception.scene, event.data.skillId, _controlObject, event.data.target);
				rs.getResourceFromPool(event.data.skillId + "_FIRE", 1, skillConfig.fire, 15);
				skill.graphic = rs;
				skill.render = render;
				skill.speed = 20;
				skill.addEventListener(SkillEvent.FIRE_COMPLETED, showExplode);
				_controlObject.controller.perception.scene.addObject(skill);
			}
			else
			{
				var explode: CExplodeEffect = new CExplodeEffect(_controlObject.controller.perception.scene, _controlObject, event.data.target);
				rs.getResourceFromPool(event.data.skillId + "_EXPLODE", 1, skillConfig.explode, 15);
				explode.graphic = rs;
				explode.render = render;
				_controlObject.controller.perception.scene.addObject(explode);
			}
		}
		
		override protected function showExplode(event: SkillEvent): void
		{
			var skillConfig: Object = SkillConfig.getSkillConfig(event.data.skillId);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			var explode: CExplodeEffect;
			explode = new CExplodeEffect(_controlObject.controller.perception.scene, _controlObject, event.data.target);
			rs.getResourceFromPool(event.data.skillId + "_EXPLODE", 1, skillConfig.explode, 15);
			explode.graphic = rs;
			var render: CRenderEffect = new CRenderEffect();
			explode.render = render;
			_controlObject.controller.perception.scene.addObject(explode);
		}
	}

}