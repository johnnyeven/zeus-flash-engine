package utils.battle
{
	import com.zn.log.Log;
	import com.zn.utils.BitmapUtil;
	import com.zn.utils.PointUtil;
	import com.zn.utils.RandomUtil;
	import com.zn.utils.RotationUtil;
	
	import enum.battle.FightVOTypeEnum;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import mediator.battle.BattleFightMediator;
	
	import proxy.battle.BattleProxy;
	
	import view.battle.fight.BattleFightComponent;
	import view.battle.fight.FightFeiJiComponent;
	
	import vo.battle.fight.FightExplodeItemVO;
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;
	import vo.cangKu.GuaJianInfoVO;

	/**
	 *战场解析
	 * @author zn
	 *
	 */
	public class FightUtil
	{
		/**
		 *下一步将要移动的点
		 * @return
		 *
		 */
		public static function getNextMovePoint(x:Number, y:Number, rotation:Number, len:Number=80):Point
		{
			var r:Number=RotationUtil.toRadian(rotation);
			var nx:Number=Math.cos(r) * len;
			var ny:Number=-Math.sin(r) * len;

			var p:Point=new Point(x + nx, y + ny);
			return p;
		}

		/**
		 *计算能够移动到的结束点
		 * @return
		 *
		 */
		public static function getMoveEndPoint(startP:Point, endP:Point, bitMapData:BitmapData):Point
		{
			var deg:Number=PointUtil.getRotaion(startP, endP);
			var rotation:Number=deg;
			rotation=RotationUtil.toRadian(deg);

			var dis:Number=Math.abs(endP.x - startP.x);

			var oldPoint:Point=startP.clone();

			var tPoint:Point=new Point();
			for (var i:int=0; i < dis; i++)
			{
				tPoint.y=Math.abs(i * Math.tan(rotation));
				if (deg < 90)
				{
					tPoint.y=startP.y - tPoint.y;
					tPoint.x=startP.x + i;
				}
				else if (deg < 180)
				{
					tPoint.y=startP.y - tPoint.y;
					tPoint.x=startP.x - i;
				}
				else if (deg < 270)
				{
					tPoint.y=startP.y + tPoint.y;
					tPoint.x=startP.x - i;
				}
				else if (deg < 360)
				{
					tPoint.y=startP.y + tPoint.y;
					tPoint.x=startP.x + i;
				}

				if (bitMapData.getPixel32(tPoint.x, tPoint.y) == 0)
					return oldPoint; //取上个坐标点
				oldPoint=tPoint.clone();
			}

			return endP;
		}

		/**
		 *计算爆炸
		 * @param voObj
		 * @return
		 *
		 */
		public static function getExplodeVO(fireVO:FightFireVO):FightExplodeVO
		{
			var fightMed:BattleFightMediator=ApplicationFacade.getInstance().getMediator(BattleFightMediator);
			var voObj:Object=FightDataUtil.getVO(fireVO.id);
			if(!voObj)	
				return null;
			var comp:*=fightMed.comp.getCompByID(fireVO.id);

			var explodeVO:FightExplodeVO=new FightExplodeVO();
			explodeVO.id=fireVO.id;
			explodeVO.gid=voObj.gid;
			explodeVO.startX=fireVO.endX;
			explodeVO.startY=fireVO.endY;

			if (voObj.voType == FightVOTypeEnum.building)
			{
				//建筑
				explodeVO.minAttack=(voObj as FORTBUILDING).currentMinAttack;
				explodeVO.maxAttack=(voObj as FORTBUILDING).currentMaxAttack;
				explodeVO.attackArea=voObj.explodeArea;
			}
			else
			{
				var tankpartVO:TANKPART;
				if (voObj.voType == FightVOTypeEnum.xiaoFeiJi)
					tankpartVO=(voObj as CHARIOT).tankparts[0];
				else
					tankpartVO=FightDataUtil.getVO(fireVO.guaJianID) as TANKPART;
				
				//挂件战车
				explodeVO.minAttack=0;
				explodeVO.maxAttack=tankpartVO.attack;
				explodeVO.attackArea=tankpartVO.explodeArea;
				explodeVO.guaJianID=tankpartVO.id.toString();
			}

			//计算打中对象
			var compList:Array=fightMed.comp.allCompList;
			var explodeItemVO:FightExplodeItemVO;
			var itemComp:*;
			var itemVO:Object;
			for (var i:int=0; i < compList.length; i++)
			{
				itemComp=compList[i];
				itemVO=itemComp["itemVO"];

				if (voObj.gid == itemVO.gid ||
					voObj.id == itemVO.id ||
					itemVO.voType == FightVOTypeEnum.item)
					continue;

				var dis:Number=Point.distance(new Point(fireVO.endX, fireVO.endY), new Point(itemComp.x, itemComp.y));
				if (dis < explodeVO.attackArea)
				{
					explodeItemVO=new FightExplodeItemVO();
					explodeItemVO.hitID=itemVO.id;
					
					if(itemVO.voType==FightVOTypeEnum.building)
						explodeItemVO.type=FightExplodeItemVO.BUILDING;
					else
						explodeItemVO.type=FightExplodeItemVO.CHARIOT;
					
					explodeItemVO.attackType=voObj.attackType;
					explodeItemVO.hitX=itemComp.x;
					explodeItemVO.hitY=itemComp.y;
					explodeVO.hitList.push(explodeItemVO);
				}
			}

			return explodeVO;
		}

		/**
		 *计算伤害
		 * @param attackID
		 * @param hitID
		 * @return
		 *
		 */
		public static function getHitNum(attackID:String, hitID:String):Number
		{
			var hitNum:Number=0;

			var attackVOObj:Object=FightDataUtil.getVO(attackID);
			var hitVOObj:Object=FightDataUtil.getVO(hitID);

			var tankpartVO:TANKPART;
			var buildingVO:FORTBUILDING;
			var chariot:CHARIOT;
			if (attackVOObj.voType == FightVOTypeEnum.guaJia)
			{
				tankpartVO=attackVOObj as TANKPART;
				if (hitVOObj.voType == FightVOTypeEnum.building)
					hitNum=tankpartVO.attack; //建筑
				else
				{
					//战车 飞机
					chariot=hitVOObj as CHARIOT;

					//计算护盾减伤
					hitNum=chariot.currentShield - tankpartVO.attack;
					chariot.currentShield=Math.max(0, hitNum);

					//剩余伤害
					if (hitNum < 0)
						hitNum=Math.abs(hitNum);
				}
			}
			else if (attackVOObj.voType == FightVOTypeEnum.building)
			{
				//建筑攻击战车
				buildingVO=attackVOObj as FORTBUILDING;
				chariot=hitVOObj as CHARIOT;

				hitNum=chariot.currentShield - buildingVO.currentMinAttack;
				chariot.currentShield=Math.max(0, hitNum);

				//剩余伤害
				if (hitNum < 0)
					hitNum=Math.abs(hitNum);
			}

			return hitNum;
		}
	}
}
