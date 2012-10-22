package view.battle.fight
{
    import com.zn.utils.BitmapUtil;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.PointUtil;
    import com.zn.utils.StringUtil;
    
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
    
    import utils.battle.BattleUtil;
    import utils.battle.FightDataUtil;
    
    import vo.battle.fight.FightFireVO;
    import vo.battle.fight.FightLockVO;
    import vo.battle.fight.FightMoveVO;

    /**
     *战场
     * @author zn
     *
     */
    public class BattleFightComponent extends Component
    {
        public var moveBitMapData:BitmapData;

        public var maskBitmapData:BitmapData;

        /**
         *地面buff
         */
        public var buffSp:Sprite = new Sprite();

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
        public var airSp:Sprite = new Sprite();
		
		/**
		 *特效 
		 */		
		public var effectSp:Sprite=new Sprite();

        public var mouseClickEffectMC:MovieClip;

        public var startPoint:Point;

        private var _plantioidProxy:PlantioidProxy;

        private var _battleProxy:BattleProxy;

        public var allCompList:Array = [];

        public var buildCompList:Array = [];

        public var compIDDic:Object = {};

        public function BattleFightComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            moveRangeSp = getSkin("moveRangeSp");
            moveBitMapData = BitmapUtil.drawBitmapData(moveRangeSp);

            startPoint = BattleUtil.getStartPoint(this, true);

            buildSp = getSkin("buildSp");
			buildSp.mouseEnabled=true;
			
            maskSp = getSkin("maskSp");
			maskSp.mouseEnabled=false;
			
            maskBitmapData = BitmapUtil.drawBitmapData(maskSp);

            mouseClickEffectMC = ClassUtil.getObject("fight.MoveClickEffectSkin");
            mouseClickEffectMC.stop();
            mouseClickEffectMC.visible = false;
            mouseClickEffectMC.addEventListener(Event.COMPLETE, mouseClickEffectMC_completeHandler);

            addChild(buffSp);
            addChild(moveRangeSp);
            addChild(buildSp);
            addChild(maskSp);
            addChild(airSp);
            addChild(mouseClickEffectMC);

            _plantioidProxy = ApplicationFacade.getProxy(PlantioidProxy);
            _battleProxy = ApplicationFacade.getProxy(BattleProxy);

            initBuild();
            initZhanChe();
            sortBuild();

            moveRangeSp.addEventListener(MouseEvent.CLICK, moveSp_clickHandler);
            moveRangeSp.mouseEnabled = true;

            //开始每帧检查
            startCheck();
        }

		
		public override function dispose():void
		{
			mouseClickEffectMC.removeEventListener(Event.COMPLETE, mouseClickEffectMC_completeHandler);
			DisposeUtil.dispose(maskBitmapData);
			DisposeUtil.dispose(moveBitMapData);
			allCompList=null;
			buildCompList=null;
			compIDDic=null;
			super.dispose();
		}
		
        private function initBuild():void
        {
            //生成建筑
            var fortPlayer1:PLAYER1 = FightDataUtil.getFortPlayer1();

            var buildComp:FightBuildComponent;
            var fort:FORT = fortPlayer1.forts[0];

            for (var i:int = 0; i < fort.fortbuildings.length; i++)
            {
                buildComp = new FightBuildComponent(fort.fortbuildings[i]);
                buildComp.addEventListener(MouseEvent.CLICK, build_clickHandler);

                compIDDic[buildComp.buildVO.id] = buildComp;

                allCompList.push(buildComp);
                buildCompList.push(buildComp);

                buildSp.addChild(buildComp);
            }
        }

        private function initZhanChe():void
        {
            //生成战车
            var useData:USER_DATA = FightDataUtil.getUseData();
            var fortPlayer1:PLAYER1;

            var zhanCheComp:FightZhanCheComponent;

            for (var i:int = 0; i < useData.player1s.length; i++)
            {
                fortPlayer1 = useData.player1s[i];

                if (fortPlayer1.chariots.length == 1)
                {
                    zhanCheComp = new FightZhanCheComponent(fortPlayer1.chariots[0]);
                    zhanCheComp.x = startPoint.x;
                    zhanCheComp.y = startPoint.y;

                    compIDDic[zhanCheComp.zhanCheVO.id] = zhanCheComp;

                    allCompList.push(zhanCheComp);
                    buildCompList.push(zhanCheComp);

                    buildSp.addChild(zhanCheComp);
                }
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
            var buildComp:FightBuildComponent = event.currentTarget as FightBuildComponent;

            var chariot:CHARIOT = FightDataUtil.getMyChariot();
            chariot.attackID = buildComp.buildVO.id.toString();

            //锁定建筑
            var lockVO:FightLockVO = new FightLockVO();
            lockVO.lockID = chariot.id.toString();
            lockVO.lockedID = chariot.attackID;
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
         *根据Y坐标进行层次排序
         * @param sp
         *
         */
        public function sortSp(sp:Sprite, compList:Array):void
        {
            //进行层次排序
            compList.sortOn("y", Array.NUMERIC);
            for (var i:int = 0; i < compList.length; i++)
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
			if(effectSp.contains(obj))
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
            mouseClickEffectMC.visible = true;
        }

        protected function mouseClickEffectMC_completeHandler(event:Event):void
        {
            mouseClickEffectMC.stop();
            mouseClickEffectMC.visible = false;
        }

        /**
         *移动战车
         * @param endP
         *
         */
        private function zhanCheMoveTo(endP:Point):void
        {
            //判断战车下一个点是否可移动，不能移动返回

            var zhanCheComp:FightZhanCheComponent = myZhanCheComp();

            var startP:Point = new Point(zhanCheComp.x, zhanCheComp.y);
            zhanCheComp.zhanCheRotation = PointUtil.getRotaion(startP, endP);
            if (!zhanCheCanMove(zhanCheComp.nextMovePoint))
                return;

            //发送战车移动事件

            var fightMoveVO:FightMoveVO = new FightMoveVO();
            fightMoveVO.zhanCheID = zhanCheComp.zhanCheVO.id.toString();
            fightMoveVO.startPoint.x = zhanCheComp.x;
            fightMoveVO.startPoint.y = zhanCheComp.y;
            fightMoveVO.angle = zhanCheComp.zhanCheRotation;
            fightMoveVO.speed = zhanCheComp.zhanCheVO.moveSpeed;
            fightMoveVO.endPoint.x = endP.x;
            fightMoveVO.endPoint.y = endP.y;

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
            return moveBitMapData.getPixel32(p.x, p.y) != 0;
        }

        /**
         *是否有遮挡
         * @param p
         * @return
         *
         */
        public function hasMask(p:Point):Boolean
        {
            return maskBitmapData.getPixel32(p.x, p.y) != 0;
        }

        /**
         *开始每帧检查
         *
         */
        public function startCheck():void
        {
            SystemManager.rootStage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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

            //TODO:ZN 生成小飞机
            createFeiJi();

            var zhanCheComp:FightZhanCheComponent = myZhanCheComp();

            //TODO:ZN 循环所有对象
            for (var i:int = 0; i < allCompList.length; i++)
            {
                obj = allCompList[i];
                if (obj == zhanCheComp)
                    continue;

                //TODO:ZN 检查移动
                checkMove(obj);

                //TODO:ZN 自动锁定
                checkAutoLock(obj);

                //TODO:ZN 检查BUFF
                checkBuff(obj);

                //TODO:ZN 如果是物品，检查物品，然后返回
                checkItem(obj);

                //TODO:ZN 如果是小飞机，小飞机追踪战车
                followZhanChe(obj);

                //TODO:ZN 小飞机和战车碰撞
                feiJiHitZhanChe(obj);

                //TODO:ZN 检查攻击
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
            var lockVO:FightLockVO;
            var zhanCheComp:FightZhanCheComponent = myZhanCheComp();

            //炮台锁定

            if (obj is FightBuildComponent)
            {
                var buildVO:FORTBUILDING = (obj as FightBuildComponent).buildVO;

                var lockedObj:DisplayObject = compIDDic[buildVO.attackID];
                //更新锁定角度
                if (lockedObj)
                {
                    var rotaion:Number = PointUtil.getRotaion(new Point(obj.x, obj.y), new Point(lockedObj.x, lockedObj.y));
                    (obj as FightBuildComponent).paotaRotaion = rotaion;
                }

                //计算锁定物体距离
                var dis:Number;
                var oldDis:Number;
                if (!StringUtil.isEmpty(buildVO.attackID))
                {
                    oldDis = PointUtil.getDis(obj, lockedObj);
                    if (oldDis > buildVO.searchArea)
                    {
                        //取消锁定
                        oldDis = NaN;
                        buildVO.attackID = null;

                        //发送取消锁定事件
                        lockVO = new FightLockVO();
                        lockVO.lockID = buildVO.id.toString();
                        dispatchEvent(new FightLockEvent(FightLockEvent.LOCK_EVENT, lockVO));
                    }
                }

                dis = PointUtil.getDis(obj, zhanCheComp);

                if (buildVO.searchArea >= dis &&
                    (isNaN(oldDis) || dis < oldDis) &&
                    buildVO.attackID != zhanCheComp.zhanCheVO.id)
                {
                    //锁定对象
                    buildVO.attackID = zhanCheComp.zhanCheVO.id.toString();

                    //发送锁定事件
                    lockVO = new FightLockVO();
                    lockVO.lockID = buildVO.id.toString();
                    lockVO.lockedID = buildVO.attackID;
                    dispatchEvent(new FightLockEvent(FightLockEvent.LOCK_EVENT, lockVO));
                }
            }

            //TODO:ZN 小飞机锁定
        }

        /**
         *检查移动
         * @param obj
         *
         */
        private function checkMove(obj:DisplayObject):void
        {
            var zhanCheComp:FightZhanCheComponent = myZhanCheComp();

            //如果战车碰撞到建筑，停止移动	
            if (obj is FightBuildComponent && obj.hitTestObject(zhanCheComp))
                stopMove(zhanCheComp);
        }

        /**
         *检查BUFF
         * @param obj
         *
         */
        private function checkBuff(obj:DisplayObject):void
        {

        }

        /**
         *检查物品
         * @param obj
         *
         */
        private function checkItem(obj:DisplayObject):void
        {

        }

        /**
         *生成小飞机
         *
         */
        private function createFeiJi():void
        {
            //TODO:ZN 如果小飞机数量小于应该显示的飞机数量，生成小飞机

        }

        /**
         *小飞机追踪战车
         * @param param0
         *
         */
        private function followZhanChe(obj:DisplayObject):void
        {

        }

        /**
         *小飞机和战车碰撞
         * @param param0
         *
         */
        private function feiJiHitZhanChe(obj:DisplayObject):void
        {

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
            //TODO:ZN 建筑攻击

            //            var displayObject:DisplayObject = _buildCompDic[id];

            //            var displayObjectPoint:Point = new Point(displayObject.x, displayObject.y);
            //            var dis:Number = Point.distance(displayObjectPoint, new Point(zhanCheComp.x, zhanCheComp.y));
            //
            //            if (dis <= zhanCheComp.zhanCheVO.serverZhanCheVO.totalAttackArea)
            //            {
            //                var attackVO:FightAttackVO = new FightAttackVO();
            //            }


        }

        /**
         *检查战车攻击
         *
         */
        private function checkZhanCheAttack():void
        {
            //检查战车攻击
            var zhanCheComp:FightZhanCheComponent = myZhanCheComp();

            //判断是否有攻击目标，如果没有则不攻击
            if (StringUtil.isEmpty(zhanCheComp.zhanCheVO.attackID))
                return;

            var hitObj:DisplayObject = compIDDic[zhanCheComp.zhanCheVO.attackID];

            //检查挂件是否都冷却过了，是否可以进行攻击

            var tankpartVO:TANKPART = FightDataUtil.getMyCanAttackTankPart();
            if (tankpartVO == null)
                return;

			//大于攻击范围，返回
			var dis:Number=PointUtil.getDis(zhanCheComp,hitObj);
			if(dis>tankpartVO.attackArea)
				return ;
			
            //设置开火冷却时间
            tankpartVO.attackCoolEndTime = DateFormatter.currentTimeM + tankpartVO.attackCoolDown;

            // 发送开火事件
            var fireVO:FightFireVO = new FightFireVO();
            fireVO.id = zhanCheComp.zhanCheVO.id.toString();
            fireVO.startX = zhanCheComp.x;
            fireVO.startY = zhanCheComp.y;
            fireVO.endX = hitObj.x;
            fireVO.endY = hitObj.y;
            fireVO.attackType = FightFireVO.GUA_JIA;
            fireVO.attackID = tankpartVO.id.toString();

            dispatchEvent(new FightFireEvent(FightFireEvent.FIGHT_FIRE_EVENT, fireVO));
        }

        public function myZhanCheComp():FightZhanCheComponent
        {
            var chariotVO:CHARIOT = FightDataUtil.getMyChariot();
            return compIDDic[chariotVO.id];
        }
    }
}
