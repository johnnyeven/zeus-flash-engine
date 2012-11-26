package view.battle.fight
{
	import com.greensock.TweenLite;
	import com.zn.utils.ArrayUtil;
	import com.zn.utils.BitmapUtil;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.PointUtil;
	import com.zn.utils.StringUtil;
	
	import enum.battle.BattleBuildTypeEnum;
	import enum.battle.FightPointEnum;
	import enum.battle.FightVOTypeEnum;
	
	import events.battle.fight.FightEvent;
	import events.battle.fight.FightFeiJiZiBaoEvent;
	import events.battle.fight.FightFireEvent;
	import events.battle.fight.FightItemEvent;
	import events.battle.fight.FightLockEvent;
	import events.battle.fight.FightZhanCheMoveEvent;
	import events.battle.fight.fightMorePlayer.FightZhanCheMaoYanEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import proxy.battle.BattleProxy;
	import proxy.plantioid.PlantioidProxy;
	
	import ui.core.Component;
	import ui.managers.SystemManager;
	import ui.utils.DisposeUtil;
	
	import utils.battle.FightDataUtil;
	import utils.battle.FightUtil;
	
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;
	import vo.battle.fight.FightItemVO;
	import vo.battle.fight.FightLockVO;
	import vo.battle.fight.FightMoveVO;
	import vo.battle.fight.fightMorePlayer.FightZhanCheMaoYanVO;

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

		public var fogShape:Shape=new Shape();

		public var startPoint:Point;

		private var _plantioidProxy:PlantioidProxy;

		private var _battleProxy:BattleProxy;

		public var allCompList:Array=[];

		public var buildCompList:Array=[];

		public var compIDDic:Object={};

		public var disposeZhanCheVODIC:Object={};

		public var feiJiCompList:Array=[];

		public static var daFeiJiCompList:Array=[];
		public static var liaoJiCompList:Array=[];

		public var isExit:Boolean=false;

		public var myZhanCheComp:FightZhanCheComponent;

		private var _currentSelectedBuild:FightBuildComponent;
		/**
		 *建筑被选中的特效
		 */
		private var buildSelectedEffect:MovieClip;
		public var isClickBuild:Boolean=false;
		//保存战车的临时数据
		private var point:Point;
		private var lockArea:Number;
		private var nextPointsprite:Sprite;
		//战车下一个点是否与建筑有碰撞
		private var isBuildHitNextPoint:Boolean=false;
		/**
		 * 与战车下一个点碰撞的建筑
		 */
		private var buildHitNextPointObj:DisplayObject;
		/**
		 * 战车死亡前的数据
		 */
		public var distoryZhanCheVo:Object;
		/**
		 * 已发送冒烟通知
		 */		
		private var isSendMaoYanInfor:Boolean = false;
		/**
		 * 已发送没冒烟通知
		 */		
		private var isSendNoMaoYanInfor:Boolean = false;
		public function BattleFightComponent(skin:DisplayObjectContainer)
		{
			super(skin);

			nextPointsprite=new Sprite();
			nextPointsprite.graphics.beginFill(0xffffff, 0);
			nextPointsprite.graphics.drawCircle(0, 0, 20);
			nextPointsprite.graphics.endFill();

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
			buildSelectedEffect=ClassUtil.getObject("battle.BuildSelectedEffectSkin") as MovieClip;
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

			//将建筑选中特效添加到特效层
			effectSp.addChild(buildSelectedEffect);
			buildSelectedEffect.visible=false;
			addChild(fogShape);
			mask=fogShape;
			fogShape.cacheAsBitmap=cacheAsBitmap=true;

			_plantioidProxy=ApplicationFacade.getProxy(PlantioidProxy);
			_battleProxy=ApplicationFacade.getProxy(BattleProxy);

			initBuild();
			initZhanChe();
			initDropItem();
			sortBuild();

			drawFog(myZhanCheComp);

			moveRangeSp.addEventListener(MouseEvent.CLICK, moveSp_clickHandler);
			moveRangeSp.mouseEnabled=true;

			//组件缩放
//			this.scaleX = BattleScaleEnum.battleScaleNumber;
//			this.scaleY = BattleScaleEnum.battleScaleNumber;
			//开始每帧检查
			startCheck();
		}

		public override function dispose():void
		{
			isExit=true;
			mouseChildren=mouseEnabled=false;
			stopCheck();
			stopMove(myZhanCheComp);

			moveRangeSp.removeEventListener(MouseEvent.CLICK, moveSp_clickHandler);
			mouseClickEffectMC.removeEventListener(Event.COMPLETE, mouseClickEffectMC_completeHandler);
			SystemManager.rootStage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			allCompList=null;
			buildCompList=null;
			compIDDic=null;
			disposeZhanCheVODIC=null;
			feiJiCompList=null;
			daFeiJiCompList=[];
			liaoJiCompList=[];
			myZhanCheComp=null;
			_currentSelectedBuild=null;
			buildHitNextPointObj=null;
			super.dispose();
		}

		public function initBuild():void
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

			myZhanCheComp=compIDDic[FightDataUtil.getMyChariot().id];

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
		 *绘制迷雾(战车存在）
		 *
		 */
		public function drawFog(zhanCheDisplayObject:DisplayObject):void
		{
			var p:Point=new Point(zhanCheDisplayObject.x, zhanCheDisplayObject.y);

			var x:Number=p.x;
			var y:Number=p.y;
			var r:Number=zhanCheDisplayObject["itemVO"].lockArea+200;
			var start:Number=136;
			var alpha:Number=0.3;
			var size:Number=r * 2;
			var tx:Number=x - r;
			var ty:Number=y - r;

			//保存战车当前数据
			point=p;
			lockArea=zhanCheDisplayObject["itemVO"].lockArea+200;
			fogShape.graphics.clear();

			var matrix:Matrix=new Matrix();
			matrix.createGradientBox(size, size, 0, tx, ty);
			fogShape.graphics.beginGradientFill(GradientType.RADIAL, [0xFF0000, 0x0000FF], [1, 0], [start, 255], matrix);
			fogShape.graphics.drawCircle(x, y, r);

			fogShape.graphics.beginFill(0xFFFFFF, alpha);
			fogShape.graphics.drawRect(0, 0, bgSp.width, bgSp.height);
			fogShape.graphics.endFill();
		}

		/**
		 *绘制迷雾(战车不存在）
		 *
		 */
		private function noZhanCheCompDrawFog(p:Point, lockArea:Number):void
		{
			var x:Number=p.x;
			var y:Number=p.y;
			var r:Number=lockArea;
			var start:Number=136;
			var alpha:Number=0.3;
			var size:Number=r * 2;
			var tx:Number=x - r;
			var ty:Number=y - r;

			fogShape.graphics.clear();

			var matrix:Matrix=new Matrix();
			matrix.createGradientBox(size, size, 0, tx, ty);
			fogShape.graphics.beginGradientFill(GradientType.RADIAL, [0xFF0000, 0x0000FF], [1, 0], [start, 255], matrix);
			fogShape.graphics.drawCircle(x, y, r);

			fogShape.graphics.beginFill(0xFFFFFF, alpha);
			fogShape.graphics.drawRect(0, 0, bgSp.width, bgSp.height);
			fogShape.graphics.endFill();
		}

		/**
		 *检查动作
		 *
		 */
		public function checkDo():void
		{
			var obj:DisplayObject;

			if (myZhanCheComp["itemVO"].currentEndurance > 0)
			{
				//循环所有对象
				for (var i:int=0; i < allCompList.length; i++)
				{
					obj=allCompList[i];
					if (obj == myZhanCheComp)
						continue;

					if (isExit)
						return;

					//检查是否显示
					checkVisible(obj);

					//检查移动
					checkMove(obj);

					//自动锁定
					checkAutoLock(obj);

					//如果是物品，检查物品
					checkItem(obj);

					//检查攻击(其他对象)
					checkObjAttack(obj);
				}

				//检查战车攻击
				checkZhanCheAttack();

				sortAir();

				//战车存在绘制迷雾
				drawFog(myZhanCheComp);
			}
			else
			{
				//战车不存在绘制迷雾
				noZhanCheCompDrawFog(point, lockArea);
			}

		}

		/**
		 *建筑被点击
		 * @param event
		 *
		 */
		protected function build_clickHandler(event:MouseEvent):void
		{
			currentSelectedBuild=event.currentTarget as FightBuildComponent;
			isClickBuild=true;
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
			//将建筑的选择特效取消
			buildSelectedEffect.visible=false;
			//取消选中对象
			myZhanCheComp["itemVO"].currentSelectedID=null;
			isClickBuild=false;
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

			var startP:Point=new Point(myZhanCheComp.x, myZhanCheComp.y);
			myZhanCheComp.zhanCheRotation=PointUtil.getRotaion(startP, endP);
			var nextPoint:Point=FightUtil.getNextMovePoint(myZhanCheComp.x, myZhanCheComp.y, myZhanCheComp.zhanCheRotation);
			nextPoint=localToGlobal(nextPoint);
			nextPoint=myZhanCheComp.globalToLocal(nextPoint);
			myZhanCheComp.addChild(nextPointsprite);
			nextPointsprite.x=nextPoint.x;
			nextPointsprite.y=nextPoint.y;
			if(!buildHitNextPointObj)
			{
				//不存在碰撞建筑
				isBuildHitNextPoint=false;
			}
			else if (buildHitNextPointObj && !buildHitNextPointObj.hitTestObject(nextPointsprite))
			{
				//存在碰撞建筑，但下一个方向点不在碰撞了
				isBuildHitNextPoint=false;
			}
			endP=FightUtil.getMoveEndPoint(startP, endP, moveBitmapData);
			//发送战车移动事件

			var fightMoveVO:FightMoveVO=new FightMoveVO();
			fightMoveVO.id=myZhanCheComp.itemVO.id.toString();
			fightMoveVO.startX=myZhanCheComp.x;
			fightMoveVO.startY=myZhanCheComp.y;
			fightMoveVO.angle=myZhanCheComp.zhanCheRotation;
			fightMoveVO.moveSpeed=myZhanCheComp.itemVO.myMoveSpeed;
			fightMoveVO.endX=endP.x;
			fightMoveVO.endY=endP.y;

			//战车下一个点是否与建筑有碰撞,有碰撞则战车不移动
			if (!isBuildHitNextPoint)
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
//			SystemManager.rootStage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		protected function enterFrameHandler(event:Event):void
		{
			checkDo();
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

			var zhanCheComp:FightZhanCheComponent=myZhanCheComp;

			var voObj:Object=obj["itemVO"];

//			voObj.voType == FightVOTypeEnum.zhanChe
			//被其他物体锁定
			if (voObj.voType == FightVOTypeEnum.building ||
				voObj.voType == FightVOTypeEnum.daFeiJi ||
				voObj.voType == FightVOTypeEnum.xiaoFeiJi)
			{
				lock(obj, zhanCheComp);
			}

			if (voObj.voType == FightVOTypeEnum.building ||
				voObj.voType == FightVOTypeEnum.daFeiJi ||
				voObj.voType == FightVOTypeEnum.xiaoFeiJi)
			{
				//计算锁定物体距离
				var dis:Number;
				var zhanCheObj:Object=zhanCheComp["itemVO"];
				dis=FightPointEnum.getDis(zhanCheComp, obj);
				//如果战车有选中的建筑物，就不在自动锁定了
				if (!zhanCheObj.currentSelectedID)
				{
					//战车主动锁定
					lock(zhanCheComp, obj);
				}

				if (voObj.voType == FightVOTypeEnum.building && zhanCheObj.lockArea >= dis)
				{
					if (obj && ((obj.x != buildSelectedEffect.x && obj.y != buildSelectedEffect.y) || (buildSelectedEffect.visible == false)))
					{
						//建筑上没有选中特效,并且选择特效没显示才显示范围内特效
						(obj as FightBuildComponent).setBuildRangeEffectVisible=true;
					}
					else
					{
						//建筑被打爆了，特效消失
						(obj as FightBuildComponent).setBuildRangeEffectVisible=false;
					}
				}
				else if (voObj.voType == FightVOTypeEnum.building && zhanCheObj.lockArea < dis)
				{
					//建筑处于战车锁定范围外，取消建筑特效
					(obj as FightBuildComponent).setBuildRangeEffectVisible=false;
				}
			}

			if (voObj.voType != FightVOTypeEnum.liaoJi && liaoJiCompList)
			{
				//僚机锁定对象的处理
				var liaoJiComp:FightFeiJiComponent;
				for (var i:int=0; i < liaoJiCompList.length; i++)
				{
					liaoJiComp=liaoJiCompList[i];
					if (liaoJiComp.itemVO.gid != voObj.gid
						&& (voObj.voType == FightVOTypeEnum.building ||
						voObj.voType == FightVOTypeEnum.daFeiJi ||
						voObj.voType == FightVOTypeEnum.xiaoFeiJi))
						lock(liaoJiComp, obj);
				}
			}
		}

		private function lock(zhuDong:DisplayObject, beiDong:DisplayObject):Boolean
		{
			if (zhuDong == beiDong || isExit == true)
				return false;

			var lockVO:FightLockVO;

			var voObj:Object=zhuDong["itemVO"];
			var oldDis:Number;

			var lockedObj:DisplayObject=compIDDic[voObj.myAttackID];
			//更新锁定角度(战车按中心点对其，建筑按左上角对其）
			if (lockedObj)
			{
				var rotaion:Number;
				//主动对象包含建筑
				if(voObj.voType == FightVOTypeEnum.building && lockedObj["itemVO"].voType == FightVOTypeEnum.zhanChe )
				{
					rotaion = PointUtil.getRotaion(new Point(zhuDong.x+75, zhuDong.y+75), new Point(lockedObj.x, lockedObj.y));
				}
				else if(lockedObj["itemVO"].voType == FightVOTypeEnum.zhanChe)
				{
					rotaion = PointUtil.getRotaion(new Point(zhuDong.x, zhuDong.y), new Point(lockedObj.x, lockedObj.y));
				}
				
				//被动对象包含建筑
				if((voObj.voType == FightVOTypeEnum.zhanChe || voObj.voType == FightVOTypeEnum.liaoJi) && lockedObj["itemVO"].voType == FightVOTypeEnum.building)
				{
					rotaion = PointUtil.getRotaion(new Point(zhuDong.x, zhuDong.y), new Point(lockedObj.x+75, lockedObj.y+75));
				}
				else
				{
					rotaion = PointUtil.getRotaion(new Point(zhuDong.x, zhuDong.y), new Point(lockedObj.x, lockedObj.y));
				}
				zhuDong["tankPartRotaion"]=rotaion;
				oldDis=FightPointEnum.getDis(zhuDong, lockedObj);
			}

			//计算锁定物体距离
			var dis:Number;

			if (voObj.voType != FightVOTypeEnum.xiaoFeiJi &&
				((!lockedObj && !StringUtil.isEmpty(voObj.myAttackID)) ||
				oldDis > voObj.lockArea))
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

			dis=FightPointEnum.getDis(zhuDong, beiDong);

			if (voObj.lockArea >= dis &&
				(isNaN(oldDis) || dis < oldDis) &&
				voObj.myAttackID != beiDong["itemVO"].id &&
				voObj.gid != beiDong["itemVO"].gid)
			{
				//锁定对象
				voObj.myAttackID=beiDong["itemVO"].id;
//				myZhanCheComp.itemVO.myAttackID = beiDong["itemVO"].id;

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
		 * 检查是否显示
		 * @param obj
		 *
		 */
		private function checkVisible(displayObj:DisplayObject):void
		{
			var voObj:Object=displayObj["itemVO"];
			if (voObj.voType == FightVOTypeEnum.building &&
				(voObj.type == BattleBuildTypeEnum.JI_DI ||
				voObj.type == BattleBuildTypeEnum.CAI_JI) ||
				voObj.voType == FightVOTypeEnum.zhanChe)
				return;

			var dis:Number=PointUtil.getDis(displayObj, myZhanCheComp);
			//TODO LW:此处距离增加了300（建筑显示出来了才能开火）
			if (dis < (myZhanCheComp.itemVO.lockArea + 300))
				displayObj.visible=true;
			else
				displayObj.visible=false;
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
//			var tankpartVO:TANKPART=FightDataUtil.getMyCanAttackTankPart();

			var voObj:Object=obj["itemVO"];

			//如果战车进入可攻击范围，停止移动	
			//tankpartVO && tankpartVO.myAttackArea > PointUtil.getDis(zhanCheComp, obj)))
			//TODO LW:碰撞检测
//			myZhanCheComp.zhanCheRotation=PointUtil.getRotaion(startP, endP);
			var nextPoint:Point=FightUtil.getNextMovePoint(myZhanCheComp.x, myZhanCheComp.y, myZhanCheComp.zhanCheRotation);
			nextPoint=localToGlobal(nextPoint);
			nextPoint=myZhanCheComp.globalToLocal(nextPoint);
			myZhanCheComp.addChild(nextPointsprite);
			nextPointsprite.x=nextPoint.x;
			nextPointsprite.y=nextPoint.y;
			if (voObj.voType == FightVOTypeEnum.building && obj.hitTestObject(nextPointsprite))
			{
				isBuildHitNextPoint=true;
				buildHitNextPointObj=obj;
				//如果战车下一个点与建筑碰创，战车停止移动
				stopMove(myZhanCheComp);

			}
			if (isClickBuild && voObj.voType == FightVOTypeEnum.building && obj.hitTestObject(myZhanCheComp))
			{
				stopMove(myZhanCheComp);
			}
			else if (voObj.voType == FightVOTypeEnum.liaoJi)
			{
				//僚机移动
				var ownID:String=voObj.ownID;
				if (ownID == myZhanCheComp.itemVO.id.toString())
				{
					if ((obj as FightFeiJiComponent).feiJiMoveTO(myZhanCheComp, true))
					{
						var fightMoveVO:FightMoveVO=new FightMoveVO();
						fightMoveVO.id=voObj.id;
						fightMoveVO.startX=obj.x;
						fightMoveVO.startY=obj.y;
						fightMoveVO.moveSpeed=voObj.myMoveSpeed;
						fightMoveVO.endX=myZhanCheComp.x;
						fightMoveVO.endY=myZhanCheComp.y;

						dispatchEvent(new FightZhanCheMoveEvent(FightZhanCheMoveEvent.ZHAN_CHE_MOVE_EVENT, fightMoveVO));
					}
				}
			}
			else if (voObj.voType == FightVOTypeEnum.xiaoFeiJi)
			{
				//小飞机移动
				(obj as FightFeiJiComponent).feiJiMoveTO(getCompByID(voObj.myAttackID));
			}
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
				var buffVO:BUFFER_DEF=voObj as BUFFER_DEF;
				var myPlayerID:String=FightDataUtil.getMyPlayer().id.toString();

				var des:Number=PointUtil.getDis(myZhanCheComp, obj);
				if (des < 100)
				{
					voObj.isPick=true;

					var fightItemVO:FightItemVO=new FightItemVO();
					fightItemVO.index=voObj.index;
					fightItemVO.uid=voObj.uid;
					fightItemVO.pickID=myZhanCheComp.itemVO.id.toString();

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

			if (voObj.voType == FightVOTypeEnum.building &&
				voObj.type != BattleBuildTypeEnum.CAI_JI)
			{
				//基地耐久小于5%，不攻击
				var buildingVO:FORTBUILDING=voObj as FORTBUILDING;
				if (buildingVO.type == BattleBuildTypeEnum.JI_DI &&
					buildingVO.currentEndurance <= buildingVO.totalEndurance * 0.05)
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
				if (hitObj && hitObj.x == obj.x && hitObj.y == obj.y)
				{
					voObj.isExplode=true;

					var fireVO:FightFireVO=new FightFireVO();
					fireVO.id=voObj.id;
					fireVO.endX=obj.x;
					fireVO.endY=obj.y;

					//撞上，小飞机爆炸
					var explodeVO:FightExplodeVO=FightUtil.getExplodeVO(fireVO);
					if (explodeVO)
						dispatchEvent(new FightFeiJiZiBaoEvent(FightFeiJiZiBaoEvent.FIGHT_FEI_JI_ZI_BAO_EVENT, explodeVO));
				}
			}
			else if (voObj.voType == FightVOTypeEnum.daFeiJi ||
				voObj.voType == FightVOTypeEnum.liaoJi)
			{
				//大飞机或者僚机
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
			if (!hitObj || hitObj["itemVO"].isDispose)
				return false;

			//检查是否冷却过了，是否可以进行攻击
			if ((voObj.attackCoolEndTime - DateFormatter.currentTimeM) > 0)
				return false;

			//大于攻击范围，返回
			var dis:Number=FightPointEnum.getDis(obj, hitObj);

			if (dis > voObj.myAttackArea)
				return false;

			// 发送开火事件
			var fireVO:FightFireVO=new FightFireVO();
			//如果是战车则用战车的中心点
			//TODU LW:修改建筑的开炮坐标
			//主动对象包含建筑
			if(obj["itemVO"].voType == FightVOTypeEnum.building && obj["itemVO"].type!= BattleBuildTypeEnum.JI_DI && obj["itemVO"].type != BattleBuildTypeEnum.CAI_JI)
			{
				if(obj && (obj as FightBuildComponent).buildFireEffect)
				{
					fireVO.startX=obj.x+(obj as FightBuildComponent).buildFireEffect.x;
					fireVO.startY=obj.y+(obj as FightBuildComponent).buildFireEffect.y;
				}
				
			}
			else if(obj["itemVO"].voType == FightVOTypeEnum.building && obj["itemVO"].type == BattleBuildTypeEnum.JI_DI)
			{
				fireVO.startX=obj.x+75;
				fireVO.startY=obj.y+75;
			}
			else if(obj["itemVO"].voType == FightVOTypeEnum.zhanChe)
			{
				if(obj && (obj as FightZhanCheComponent).zhanCheFireEffect)
				{
					fireVO.startX=obj.x + (obj as FightZhanCheComponent).zhanCheFireEffect.x; 
					fireVO.startY=obj.y + (obj as FightZhanCheComponent).zhanCheFireEffect.y;
				}
				
			}
			else
			{
				fireVO.startX=obj.x;
				fireVO.startY=obj.y;
			}
			
			//被打对象包含建筑
			if(hitObj["itemVO"].voType == FightVOTypeEnum.building)
			{
				fireVO.endX=hitObj.x+75;
				fireVO.endY=hitObj.y+75;
			}
			else
			{
				fireVO.endX=hitObj.x;
				fireVO.endY=hitObj.y;
			}
			
			fireVO.rotation=obj["tankPartRotaion"];

			if (voObj.voType == FightVOTypeEnum.building)
				fireVO.id=voObj.id;
			else if (voObj.voType == FightVOTypeEnum.guaJia)
			{
				fireVO.id=(voObj as TANKPART).chariotId.toString();
				fireVO.guaJianID=voObj.id;
			}

			fireVO.hitID=myAttackID;

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

			//检查挂件是否都冷却过了，是否可以进行攻击
			var tankpartVO:TANKPART=FightDataUtil.getMyCanAttackTankPart();
			if (tankpartVO == null)
				return;

			if (isFire(myZhanCheComp, tankpartVO, myZhanCheComp.itemVO.myAttackID))
			{
				//设置开火冷却时间
				tankpartVO.attackCoolEndTime=DateFormatter.currentTimeM + tankpartVO.attackCoolDown;
			}
			
			//TODO:LW:新加特效  战车的冒烟特效
			//战车的冒烟特效
			var zhanCheMaoYanVO:FightZhanCheMaoYanVO = new FightZhanCheMaoYanVO();
			zhanCheMaoYanVO.id = myZhanCheComp.itemVO.id.toString();
			if(myZhanCheComp.itemVO.currentEndurance <= myZhanCheComp.itemVO.basicEndurance*0.2)
			{
				//冒烟特效
				myZhanCheComp.zhanCheMaoYaneffectMC.visible = true;
				zhanCheMaoYanVO.isMaoYan = 1;
				if(!isSendMaoYanInfor)
				{
				  //广播战车的冒烟特效
				  dispatchEvent(new FightZhanCheMaoYanEvent(FightZhanCheMaoYanEvent.MAO_YAN_EVENT,zhanCheMaoYanVO));
				  isSendMaoYanInfor = true;
				  isSendNoMaoYanInfor = false;
				}
			}
			else
			{
				myZhanCheComp.zhanCheMaoYaneffectMC.visible = false;
				zhanCheMaoYanVO.isMaoYan = 0;
				if(!isSendNoMaoYanInfor)
				{
					//广播战车的没冒烟特效
					dispatchEvent(new FightZhanCheMaoYanEvent(FightZhanCheMaoYanEvent.MAO_YAN_EVENT,zhanCheMaoYanVO));
					isSendNoMaoYanInfor = true;
					isSendMaoYanInfor = false;
				}
				
			}
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

			TweenLite.killTweensOf(obj);
			
			//判断打爆的建筑
			var buildVO:Object=obj["itemVO"];
			if (buildVO.voType == FightVOTypeEnum.building)
			{
				if (obj.x == buildSelectedEffect.x && obj.y == buildSelectedEffect.y)
				{
					//建筑物被打爆了，选中特效消失
					buildSelectedEffect.visible=false;
				}
				//如果战车选中的建筑物被打爆了，战车选中ID被清空
				if (buildVO.id == myZhanCheComp["itemVO"].currentSelectedID)
					myZhanCheComp["itemVO"].currentSelectedID=null;
			}
			var zhanCheVO:Object=obj["itemVO"];
			if (zhanCheVO.voType == FightVOTypeEnum.zhanChe)
			{
				distoryZhanCheVo=zhanCheVO;
				disposeZhanCheVODIC[zhanCheVO.id]=zhanCheVO;
				zhanCheVO.x=obj.x;
				zhanCheVO.y=obj.y;
			}

			ArrayUtil.removeObj(allCompList, obj);
			ArrayUtil.removeObj(buildCompList, obj);
			ArrayUtil.removeObj(liaoJiCompList, obj);
			ArrayUtil.removeObj(feiJiCompList, obj);

			delete compIDDic[obj["itemVO"].id];
			delete FightDataUtil.dataDic[obj["itemVO"].id];
			delete FightDataUtil.dataDic[obj["itemVO"].uid];

			if (obj == myZhanCheComp)
			{
				//隐藏战车的冒烟特效
//				myZhanCheComp.zhanCheMaoYaneffectMC.visible = false;
				//战斗失败
				mouseChildren=mouseEnabled=false;
				stopCheck();
				stopMove(myZhanCheComp);
				isExit=true;

				dispatchEvent(new FightEvent(FightEvent.FAIL_EVENT));
			}
			DisposeUtil.dispose(obj);
		}

		public function getCompByID(id:String):DisplayObject
		{
			return compIDDic[id] as DisplayObject;
		}

		/**
		 *当前选中的建筑（锁定的建筑）
		 */
		public function get currentSelectedBuild():FightBuildComponent
		{
			return _currentSelectedBuild;
		}

		/**
		 * @private
		 */
		public function set currentSelectedBuild(value:FightBuildComponent):void
		{
			if (_currentSelectedBuild)
			{
				//设置建筑的选中效果
				if (buildSelectedEffect.visible == true)
					buildSelectedEffect.visible=false;
			}
			//设置战车攻击目标为这个建筑
			_currentSelectedBuild=value;
			buildSelectedEffect.x=_currentSelectedBuild.x;
			buildSelectedEffect.y=_currentSelectedBuild.y;
			//设置建筑的选中效果
			buildSelectedEffect.visible=true;
			var chariot:CHARIOT=FightDataUtil.getMyChariot();
			//战车攻击对象的ID
			chariot.myAttackID=_currentSelectedBuild.itemVO.id.toString();
			//当前选中建筑的ID
			chariot.currentSelectedID=_currentSelectedBuild.itemVO.id.toString();
			//锁定建筑
			var lockVO:FightLockVO=new FightLockVO();
			lockVO.lockID=chariot.id.toString();
			lockVO.lockedID=chariot.currentSelectedID;
			dispatchEvent(new FightLockEvent(FightLockEvent.LOCK_EVENT, lockVO));

			//点击建筑后，战车的移动(战车不能跑到建筑的下面去了)
			//计算锁定物体距离
			var dis:Number;
			var voObj:Object=myZhanCheComp["itemVO"];
			dis=FightPointEnum.getDis(myZhanCheComp, _currentSelectedBuild);
			if (voObj.lockArea >= dis)
			{
				//如果战车进入可攻击范围，停止移动	
				stopMove(myZhanCheComp);
			}
			else
			{
				//移动战车到这个建筑
				zhanCheMoveTo(new Point(_currentSelectedBuild.x, _currentSelectedBuild.y));
			}
		}
	}
}
