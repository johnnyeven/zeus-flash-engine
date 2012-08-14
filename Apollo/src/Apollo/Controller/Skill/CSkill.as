package Apollo.Controller.Skill 
{
	import Apollo.Configuration.*;
	import Apollo.Objects.CActionObject;
	import Apollo.Objects.Effects.*;
	import Apollo.Graphics.CGraphicCharacter;
	import Apollo.Renders.CRenderEffect;
	import Apollo.Events.SkillEvent;
	import Apollo.Controller.KeyCode;
	import Apollo.Controller.Skill.SkillConfig;
	import Apollo.Center.CCommandCenter;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author john
	 */
	public class CSkill implements IEventDispatcher
	{
		protected var _controlObject: CActionObject;
		private var eventDispatcher: EventDispatcher;
		
		private var _isLastActionOver: Boolean;
		
		public function CSkill(owner: CActionObject) 
		{
			if (owner != null)
			{
				_controlObject = owner;
			}
			else
			{
				throw new Error("owner can not set to be null");
			}
			eventDispatcher = new EventDispatcher(this);
			_isLastActionOver = true;
		}
		
		public function showRangeAttack(keyCode: int): void
		{
			if (!_isLastActionOver)
			{
				return;
			}
			var rangeAttack: CRangeAttackEffect = new CRangeAttackEffect(_controlObject.controller.perception.scene, keyCode);
			rangeAttack.addEventListener(SkillEvent.RANGE_SELECTED, onRangeAttackConfirm);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool("rangeAttack", 1, 6, 20);
			rangeAttack.graphic = rs;
			var render: CRenderEffect = new CRenderEffect();
			rangeAttack.render = render;
			_controlObject.controller.perception.scene.addObject(rangeAttack);
		}
		
		protected function onRangeAttackConfirm(event: SkillEvent): void
		{
			var evt: SkillEvent = new SkillEvent(SkillEvent.RANGE_SELECTED);
			evt.data = new Object;
			evt.data.keyCode = event.data.keyCode;
			evt.data.point = event.data.point;
			dispatchEvent(evt);
		}
		
		public function showSingEffect(keyCode: int, target: *): void
		{
			if (!_isLastActionOver)
			{
				return;
			}
			var skillId: String = CharacterData.getInstance().skillList[keyCode][0];
			var skillConfig: Object = SkillConfig.getSkillConfig(skillId);
			
			var sing: CSingEffect = new CSingEffect(_controlObject, _controlObject.controller.perception.scene, skillId, target);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			rs.getResourceFromPool("prepareSkill", 1, 6, 30);
			sing.graphic = rs;
			var skillLevel: int = CharacterData.getInstance().skillList[keyCode][1];
			sing.singTime = skillConfig.level[skillLevel].singTime;
			var render: CRenderEffect = new CRenderEffect();
			sing.render = render;
			sing.addEventListener(SkillEvent.SING_COMPLETED, onSkillPrepared);
			_controlObject.controller.perception.scene.addObject(sing);
			_isLastActionOver = false;
		}
		
		protected function onSkillPrepared(event: SkillEvent): void
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
				/*
				var explode: CExplodeEffect = new CExplodeEffect(_controlObject.controller.perception.scene, _controlObject, event.data.target);
				rs.getResourceFromPool(event.data.skillId + "_EXPLODE", 1, skillConfig.explode, 15);
				explode.graphic = rs;
				explode.render = render;
				_controlObject.controller.perception.scene.addObject(explode);
				*/
				showExplode(event);
			}
			event = null;
			_isLastActionOver = true;
		}
		
		protected function showExplode(event: SkillEvent): void
		{
			//抛出event Controller才能处理通讯事件
			var evt: SkillEvent = new SkillEvent(SkillEvent.SING_COMPLETED);
			evt.data = new Object();
			evt.data.skillId = event.data.skillId;
			evt.data.target = event.data.target;
			event = null;
			dispatchEvent(evt);
			/*
			var skillConfig: Object = SkillConfig.getSkillConfig(event.data.skillId);
			var rs: CGraphicCharacter = new CGraphicCharacter();
			var explode: CExplodeEffect;
			explode = new CExplodeEffect(_controlObject.controller.perception.scene, _controlObject, event.data.target);
			rs.getResourceFromPool(event.data.skillId + "_EXPLODE", 1, skillConfig.explode, 15);
			explode.graphic = rs;
			var render: CRenderEffect = new CRenderEffect();
			explode.render = render;
			_controlObject.controller.perception.scene.addObject(explode);
			*/
		}
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false): void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 
		 * @param e
		 */
		public function dispatchEvent(e:Event): Boolean
		{
			return eventDispatcher.dispatchEvent(e);
		}

		/**
		 * 
		 * @param type
		 */
		public function hasEventListener(type:String): Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}

		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false): void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * 
		 * @param type
		 */
		public function willTrigger(type:String): Boolean
		{
			return eventDispatcher.willTrigger(type);
		}
	}

}