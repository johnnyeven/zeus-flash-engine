package view.battle.fight
{
	import com.zn.utils.BitmapUtil;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.PointUtil;
	import com.zn.utils.StringUtil;

	import enum.battle.BattleBuildTypeEnum;
	import enum.battle.FightVOTypeEnum;

	import events.battle.fight.FightEvent;
	import events.battle.fight.FightFeiJiZiBaoEvent;
	import events.battle.fight.FightFireEvent;
	import events.battle.fight.FightLockEvent;
	import events.battle.fight.FightZhanCheMoveEvent;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import proxy.battle.BattleProxy;
	import proxy.plantioid.PlantioidProxy;

	import ui.core.Component;
	import ui.managers.SystemManager;
	import ui.utils.DisposeUtil;

	import utils.battle.FightDataUtil;
	import utils.battle.FightUtil;

	import vo.battle.fight.FightExplodeItemVO;
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;
	import vo.battle.fight.FightItemVO;
	import vo.battle.fight.FightLockVO;
	import vo.battle.fight.FightMoveVO;

	/**
	 *战场
	 * @author zn
	 *
	 */
	public class BattleFightComponent extends Component
	{
		public var moveBitmapData:BitmapData;
		public var maskBitmapData:BitmapData;

		public var bgSp:Sprite;

		/**
		 *地面buff
		 */
		public var buffSp:Sprite=new Sprite();

		/**
		 *建筑
		 */
		public var buildSp:Sprite;

		/**
		 *移动区域
		 */
		public var moveRangeSp:Sprite;

		/**
		 *遮罩物品
		 */
		public var maskSp:Sprite;

		/**
		 *空中
		 */
		public var airSp:Sprite=new Sprite();

		/**
		 *特效
		 */
		public var effectSp:Sprite=new Sprite();

		/**
		 *大飞机飞行中心点
		 */
		public var feiJiCenterSp:Sprite;

		public var mouseClickEffectMC:MovieClip;

		public var startPoint:Point;

		private var _plantioidProxy:PlantioidProxy;

		private var _battleProxy:BattleProxy;

		public var allCompList:Array=[];

		public var buildCompList:Array=[];

		public var compIDDic:Object={};

		public var feiJiCompList:Array=[];

		public var isExit:Boolean=false;

		public function BattleFightComponent(skin:DisplayObjectContainer)
		{
			super(skin);

			bgSp=getSkin("bg");
			feiJiCenterSp=getSkin("feiJiCenterSp");

			moveRangeSp=getSkin("moveRangeSp");
			moveBitmapData=BitmapUtil.drawBitmapData(moveRangeSp);

			maskSp=getSkin("maskSp");
			maskSp.mouseChildren=maskSp.mouseEnabled=false;
			maskBitmapData=BitmapUtil.drawBitmapData(maskSp);

			var startSp:Sprite=getSkin("startPoint");
			startPoint=new Point(startSp.x, startSp.y);
			DisposeUtil.dispose(startSp);

			buildSp=getSkin("buildSp");
//			buildSp.mouseEnabled=true;

			mouseClickEffectMC=ClassUtil.getObject("fight.MoveClickEffectSkin");
			mouseClickEffectMC.stop();
			mouseClickEffectMC.visible=false;
			mouseClickEffectMC.addEventListener(Event.COMPLETE, mouseClickEffectMC_completeHandler);

			addChild(buffSp);
			addChild(moveRangeSp);
			addChild(buildSp);
			addChild(maskSp);
			addChild(airSp);
			addChild(mouseClickEffectMC);
			addChild(effectSp);

			_plantioidProxy=ApplicationFacade.getProxy(PlantioidProxy);
			_battleProxy=ApplicationFacade.getProxy(BattleProxy);

			initBuild();
			initZhanChe();
			initDropItem();
			sortBuild();

			moveRangeSp.addEventListener(MouseEvent.CLICK, moveSp_clickHandler);
			moveRangeSp.mouseEnabled=true;

			//开始每帧检查
			startCheck();
		}

		public override function dispose():void
		{
			mouseClickEffectMC.removeEventListener(Event.COMPLETE, mouseClickEffectMC_completeHandler);
			SystemManager.rootStage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			allCompList=null;
			buildCompList=null;
			compIDDic=null;
			super.dispose();
		}

		private function initBuild():void
		{
			//生成建筑
			var fortPlayer1:PLAYER1=FightDataUtil.getFortPlayer1();

			var buildComp:FightBuildComponent;
			var fort:FORT=fortPlayer1.forts[0];

			for (var i:int=0; i < fort.fortbuildings.length; i++)
			{
				buildComp=new FightBuildComponent(fort.fortbuildings[i]);
				buildComp.addEventListener(MouseEvent.CLICK, build_clickHandler);

				compIDDic[buildComp.itemVO.id]=buildComp;

				allCompList.push(buildComp);
				buildCompList.push(buildComp);

				buildSp.addChild(buildComp);
			}
		}

		private function initZhanChe():void
		{
			//生成战车
			var useData:USER_DATA=FightDataUtil.getUseData();
			var fortPlayer1:PLAYER1;

			var zhanCheComp:FightZhanCheComponent;

			for (var i:int=0; i < useData.player1s.length; i++)
			{
				fortPlayer1=useData.player1s[i];

				if (fortPlayer1.chariots.length == 1)
				{
					zhanCheComp=new FightZhanCheComponent(fortPlayer1.chariots[0]);
					zhanCheComp.x=startPoint.x;
					zhanCheComp.y=startPoint.y;

					compIDDic[zhanCheComp.itemVO.id]=zhanCheComp;

					allCompList.push(zhanCheComp);
					buildCompList.push(zhanCheComp);

					buildSp.addChild(zhanCheComp);
				}
			}
		}

		/**
		 *掉落物品
		 *
		 */
		private function initDropItem():void
		{
			var userData:USER_DATA=FightDataUtil.getUseData();

			var buffVO:BUFFER_DEF;
			var fightItemComp:FightItemComponent;
			for (var i:int=0; i < userData.buffers.length; i++)
			{
				buffVO=userData.buffers[i];
				fightItemComp=new FightItemComponent();
				fightItemComp.itemVO=buffVO;

				buildCompList.push(fightItemComp);
				compIDDic[buffVO.uid]=fightItemComp;
				allCompList.push(fightItemComp);

				buildSp.addChild(fightItemComp);
			}
		}

		/**
		 *建筑被点击
		 * @param event
		 *
		 */
		protected function build_clickHandler(event:MouseEvent):void
		{
			//置战车攻击目标为这个建筑
			var buildComp:FightBuildComponent=event.currentTarget as FightBuildComponent;

			var chariot:CHARIOT=FightDataUtil.getMyChariot();
			chariot.myAttackID=buildComp.itemVO.id.toString();

			//锁定建筑
			var lockVO:FightLockVO=new FightLockVO();
			lockVO.lockID=chariot.id.toString();
			lockVO.lockedID=chariot.myAttackID;
			dispatchEvent(new FightLockEvent(FightLockEvent.LOCK_EVENT, lockVO));

			//移动战车到这个建筑
			zhanCheMoveTo(new Point(buildComp.x, buildComp.y));
		}

		/**
		 *建筑排序
		 *
		 */
		public function sortBuild():void
		{
			sortSp(buildSp, buildCompList);
		}

		/**
		 *空中排序
		 *
		 */
		public function sortAir():void
		{
			sortSp(airSp, feiJiCompList);
		}


		/**
		 *根据Y坐标进行层次排序
		 * @param sp
		 *
		 */
		public function sortSp(sp:Sprite, compList:Array):void
		{
			//进行层次排序
			compList.sortOn("y", Array.NUMERIC);
			for (var i:int=0; i < compList.length; i++)
			{
				sp.addChild(compList[i]);
			}
		}

		public function addEffect(obj:DisplayObject):void
		{
			effectSp.addChild(obj);
		}

		public function removeEffect(obj:DisplayObject):void
		{
			if (effectSp.contains(obj))
				effectSp.removeChild(obj);
		}

		/**
		 *点击可移动区域，移动战车
		 * @param event
		 *
		 */
		protected function moveSp_clickHandler(event:MouseEvent):void
		{
			//移动战车
			var p:Point=globalToLocal(new Point(event.stageX, event.stageY));
			playeClickEffectMC(p);
			zhanCheMoveTo(p);
		}

		private function playeClickEffectMC(p:Point):void
		{
			mouseClickEffectMC.x=p.x;
			mouseClickEffectMC.y=p.y;

			mouseClickEffectMC.gotoAndPlay(1);
			mouseClickEffectMC.visible=true;
		}

		protected function mouseClickEffectMC_completeHandler(event:Event):void
		{
			mouseClickEffectMC.stop();
			mouseClickEffectMC.visible=false;
		}

		/**
		 *移动战车
		 * @param endP
		 *
		 */
		private function zhanCheMoveTo(endP:Point):void
		{
			//判断战车下一个点是否可移动，不能移动返回

			var zhanCheComp:FightZhanCheComponent=myZhanCheComp();

			var startP:Point=new Point(zhanCheComp.x, zhanCheComp.y);
			zhanCheComp.zhanCheRotation=PointUtil.getRotaion(startP, endP);

			endP=FightUtil.getMoveEndPoint(startP, endP, moveBitmapData);
			//发送战车移动事件

			var fightMoveVO:FightMoveVO=new FightMoveVO();
			fightMoveVO.id=zhanCheComp.itemVO.id.toString();
			fightMoveVO.startX=zhanCheComp.x;
			fightMoveVO.startY=zhanCheComp.y;
			fightMoveVO.angle=zhanCheComp.zhanCheRotation;
			fightMoveVO.moveSpeed=zhanCheComp.itemVO.myMoveSpeed;
			fightMoveVO.endX=endP.x;
			fightMoveVO.endY=endP.y;

			dispatchEvent(new FightZhanCheMoveEvent(FightZhanCheMoveEvent.ZHAN_CHE_MOVE_EVENT, fightMoveVO));
		}

		/**
		 *能否移动
		 * @param p
		 * @return
		 *
		 */
		public function zhanCheCanMove(p:Point):Boolean
		{
			return moveBitmapData.getPixel32(p.x, p.y) != 0;
		}

		/**
		 *是否有遮挡
		 * @param p
		 * @return
		 *
		 */
		public function hasMask(p:Point):Boolean
		{
			return maskBitmapData.getPixel32(p.x, p.y) != 0
		}

		/**
		 *开始每帧检查
		 *
		 */
		public function startCheck():void
		{
			SystemManager.rootStage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		public function stopCheck():void
		{
			SystemManager.rootStage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		protected function enterFrameHandler(event:Event):void
		{
			checkDo();
		}

		/**
		 *检查动作
		 *
		 */
		public function checkDo():void
		{
			var obj:DisplayObject;

			var zhanCheComp:FightZhanCheComponent=myZhanCheComp();

			//循环所有对象
			for (var i:int=0; i < allCompList.length; i++)
			{
				obj=allCompList[i];
				if (obj == zhanCheComp)
					continue;

				if (isExit)
					return;

				//检查移动
				checkMove(obj);

				//自动锁定
				checkAutoLock(obj);

				//如果是物品，检查物品
				checkItem(obj);

				// 检查攻击
				checkObjAttack(obj);
			}

			//检查战车攻击
			checkZhanCheAttack();
		}

		/**
		 *自动锁定
		 * @param obj
		 *
		 */
		private function checkAutoLock(obj:DisplayObject):void
		{
			if (isExit)
				return;

			var zhanCheComp:FightZhanCheComponent=myZhanCheComp();

			var voObj:Object=obj["itemVO"];

			//被其他物体锁定
			if (voObj.voType == FightVOTypeEnum.building ||
				voObj.voType == FightVOTypeEnum.zhanChe ||
				voObj.voType == FightVOTypeEnum.daFeiJi ||
				voObj.voType == FightVOTypeEnum.liaoJi ||
				voObj.voType == FightVOTypeEnum.xiaoFeiJi)
			{
				lock(obj, zhanCheComp);
			}

			if (voObj.voType == FightVOTypeEnum.building ||
				voObj.voType == FightVOTypeEnum.daFeiJi ||
				voObj.voType == FightVOTypeEnum.xiaoFeiJi)
			{
				//战车主动锁定
				lock(zhanCheComp, obj);
			}
		}

		private function lock(zhuDong:DisplayObject, beiDong:DisplayObject):Boolean
		{
			if (zhuDong == beiDong)
				return false;

			var lockVO:FightLockVO;

			var voObj:Object=zhuDong["itemVO"];
			var oldDis:Number;

			var lockedObj:DisplayObject=compIDDic[voObj.myAttackID];
			//更新锁定角度
			if (lockedObj)
			{
				var rotaion:Number=PointUtil.getRotaion(new Point(zhuDong.x, zhuDong.y), new Point(lockedObj.x, lockedObj.y));
				zhuDong["tankPartRotaion"]=rotaion;
				oldDis=PointUtil.getDis(zhuDong, lockedObj);
			}

			//计算锁定物体距离
			var dis:Number;

			if ((!lockedObj && !StringUtil.isEmpty(voObj.myAttackID)) ||
				oldDis > voObj.lockArea)
			{
				//取消锁定
				oldDis=NaN;
				voObj.myAttackID=null;

				//发送取消锁定事件
				lockVO=new FightLockVO();
				lockVO.lockID=voObj.id;
				lockVO.oldLocked=voObj.myAttackID;
				dispatchEvent(new FightLockEvent(FightLockEvent.LOCK_EVENT, lockVO));
			}

			dis=PointUtil.getDis(zhuDong, beiDong);

			if (voObj.lockArea >= dis &&
				(isNaN(oldDis) || dis < oldDis) &&
				voObj.myAttackID != beiDong["itemVO"].id)
			{
				//锁定对象
//				voObj.myAttackID=beiDong["itemVO"].id;

				//发送锁定事件
				lockVO=new FightLockVO();
				lockVO.lockID=voObj.id;
				lockVO.lockedID=beiDong["itemVO"].id;
				dispatchEvent(new FightLockEvent(FightLockEvent.LOCK_EVENT, lockVO));
				return true;
			}

			return false;
		}

		/**
		 *检查移动
		 * @param obj
		 *
		 */
		private function checkMove(obj:DisplayObject):void
		{
			if (isExit)
				return;
			var zhanCheComp:FightZhanCheComponent=myZhanCheComp();

			var tankpartVO:TANKPART=FightDataUtil.getMyCanAttackTankPart();

			//如果战车进入可攻击范围，停止移动	
			//tankpartVO && tankpartVO.myAttackArea > PointUtil.getDis(zhanCheComp, obj)))
			if (obj is FightBuildComponent && obj.hitTestObject(zhanCheComp))
				stopMove(zhanCheComp);
		}

		/**
		 *检查物品
		 * @param obj
		 *
		 */
		private function checkItem(obj:DisplayObject):void
		{
			if (isExit)
				return;

			var voObj:Object=obj["itemVO"];

			if (voObj.voType == FightVOTypeEnum.item && !voObj.isPick)
			{
				var zhanCheComp:FightZhanCheComponent=myZhanCheComp();
				if (PointUtil.getDis(zhanCheComp, obj) < 100)
				{
					voObj.isPick=true;

					var fightItemVO:FightItemVO=new FightItemVO();
					fightItemVO.index=voObj.index;
					fightItemVO.uid=voObj.uid;
					fightItemVO.pickID=zhanCheComp.itemVO.id.toString();

					//发送事件
					dispatchEvent(new FightItemEvent(FightItemEvent.FIGHT_ITEM_EVENT, fightItemVO));
				}
			}
		}

		public function stopMove(zhanCheComp:FightZhanCheComponent):void
		{
			zhanCheComp.stopMove();
		}


		/**
		 *攻击
		 */
		private function checkObjAttack(obj:DisplayObject):void
		{
			if (isExit)
				return;

			//建筑攻击
			var voObj:Object=obj["itemVO"];

			if (voObj.voType == FightVOTypeEnum.building)
			{
				//基地耐久小于5%，不攻击
				var buildingVO:FORTBUILDING=voObj as FORTBUILDING;
				if (buildingVO.type == BattleBuildTypeEnum.JI_DI &&
					buildingVO.currentEndurance <= buildingVO.totalEndurance)
					return;

				if (isFire(obj, voObj, voObj.myAttackID))
				{
					//设置开火冷却时间
					voObj.attackCoolEndTime=DateFormatter.currentTimeM + (voObj as FORTBUILDING).currentAttackCoolDown;
				}
			}
			else if (voObj.voType == FightVOTypeEnum.xiaoFeiJi &&
				!voObj.isExplode)
			{
				//自爆小飞机
				var hitObj:DisplayObject=compIDDic[voObj.myAttackID];
				if (hitObj && hitObj.hitTestObject(obj))
				{
					voObj.isExplode=true;

					var fireVO:FightFireVO=new FightFireVO();
					fireVO.id=voObj.id;
					fireVO.endX=voObj.x;
					fireVO.endY=voObj.y;

					//撞上，小飞机爆炸
					var explodeVO:FightExplodeVO=FightUtil.getExplodeVO(fireVO);

					dispatchEvent(new FightFeiJiZiBaoEvent(FightFeiJiZiBaoEvent.FIGHT_FEI_JI_ZI_BAO_EVENT, explodeVO));
				}
			}
			else if (voObj.voType == FightVOTypeEnum.daFeiJi)
			{
				//大飞机
				var tankpartVO:TANKPART=(voObj as CHARIOT).tankparts[0];

				if (isFire(obj, tankpartVO, voObj.myAttackID))
				{
					//设置开火冷却时间
					tankpartVO.attackCoolEndTime=DateFormatter.currentTimeM + tankpartVO.attackCoolDown;
				}
			}
		}

		/**
		 * 是否开火
		 * @param obj
		 * @param voObj
		 * @param coolEndTime
		 * @param attackArea
		 * @return
		 *
		 */
		private function isFire(obj:DisplayObject, voObj:Object, myAttackID:String):Boolean
		{
			if (voObj.id == myAttackID)
				return false;

			//判断是否有攻击目标，如果没有则不攻击
			if (StringUtil.isEmpty(myAttackID))
				return false;

			var hitObj:DisplayObject=compIDDic[myAttackID];
			if (hitObj["itemVO"].isDispose)
				return false;

			//检查是否冷却过了，是否可以进行攻击
			if ((voObj.attackCoolEndTime - DateFormatter.currentTimeM) > 0)
				return false;

			//大于攻击范围，返回
			var dis:Number=PointUtil.getDis(obj, hitObj);

			if (dis > voObj.myAttackArea)
				return false;

			// 发送开火事件
			var fireVO:FightFireVO=new FightFireVO();
			fireVO.id=voObj.id;
			fireVO.startX=obj.x;
			fireVO.startY=obj.y;
			fireVO.endX=hitObj.x;
			fireVO.endY=hitObj.y;
			fireVO.rotation=obj["tankPartRotaion"];

			dispatchEvent(new FightFireEvent(FightFireEvent.FIGHT_FIRE_EVENT, fireVO));

			return true;
		}

		/**
		 *检查战车攻击
		 *
		 */
		private function checkZhanCheAttack():void
		{
			if (isExit)
				return;

			//检查战车攻击
			var zhanCheComp:FightZhanCheComponent=myZhanCheComp();

			//检查挂件是否都冷却过了，是否可以进行攻击
			var tankpartVO:TANKPART=FightDataUtil.getMyCanAttackTankPart();
			if (tankpartVO == null)
				return;

			if (isFire(zhanCheComp, tankpartVO, zhanCheComp.itemVO.myAttackID))
			{
				//设置开火冷却时间
				tankpartVO.attackCoolEndTime=DateFormatter.currentTimeM + tankpartVO.attackCoolDown;
			}
		}

		public function myZhanCheComp():FightZhanCheComponent
		{
			var chariotVO:CHARIOT=FightDataUtil.getMyChariot();
			return compIDDic[chariotVO.id];
		}

		/**
		 *销毁
		 * @param obj
		 *
		 */
		public function disposeComp(obj:DisplayObject):void
		{
//			if (obj == myZhanCheComp())
//			{
//				return;
//				//战斗失败
//				mouseChildren=mouseEnabled=false;
//				stopCheck();
//				stopMove(myZhanCheComp());
//				dispatchEvent(new FightEvent(FightEvent.FAIL_EVENT));
//			}
//
//			obj["itemVO"].isDispose=true;
//			if (obj["itemVO"] is CHARIOT)
//			{
//				var chariot:CHARIOT=obj["itemVO"];
//				for (var i:int=0; i < chariot.tankparts.length; i++)
//				{
//					chariot.tankparts[i].isDispose=true;
//				}
//			}
//
//			obj.visible=false;


			if (obj == myZhanCheComp())
			{
				return;
				//战斗失败
				mouseChildren=mouseEnabled=false;
				stopCheck();
				stopMove(myZhanCheComp());
				dispatchEvent(new FightEvent(FightEvent.FAIL_EVENT));
			}

			var index:int;
			index=allCompList.indexOf(obj);
			if (index != -1)
				allCompList.splice(index, 1);

			index=buildCompList.indexOf(obj);
			if (index != -1)
				buildCompList.splice(index, 1);

			delete compIDDic[obj["itemVO"].id];
			delete FightDataUtil.dataDic[obj["itemVO"].id];
			delete FightDataUtil.dataDic[obj["itemVO"].uid];

			DisposeUtil.dispose(obj);
		}

		public function getCompByID(id:String):DisplayObject
		{
			return compIDDic[id] as DisplayObject;
		}
	}
}
