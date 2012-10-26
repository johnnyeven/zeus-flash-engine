package proxy.battle
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.net.socket.ClientSocket;
	import com.zn.utils.StringUtil;
	import com.zn.utils.UIDUtil;
	
	import controller.battle.fight.FightCreateFeiJiCommand;
	import controller.battle.fight.FightExplodeCommand;
	import controller.battle.fight.FightFireCommand;
	import controller.battle.fight.FightHitCommand;
	import controller.battle.fight.FightItemCommand;
	import controller.battle.fight.FightLockCommand;
	import controller.battle.fight.FightMoveCommand;
	
	import enum.ResEnum;
	import enum.battle.BattleBuildTypeEnum;
	import enum.battle.FightBuffItemTypeEnum;
	import enum.battle.FightCustomMessageTypeEnum;
	import enum.battle.FightVOTypeEnum;
	import enum.battle.GameServerErrorEnum;
	import enum.command.CommandEnum;
	import enum.item.ItemEnum;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mediator.battle.BattleFightMediator;
	import mediator.prompt.PromptMediator;
	
	import net.NetHttpConn;
	import net.gameServer.GamerServerProtocol;
	import net.gameServer.GamerServerSocket;
	import net.gameServer.GamerServerSocketIn;
	import net.gameServer.GamerServerSocketOut;
	import net.roomServer.RoomProtocol;
	import net.roomServer.RoomSocket;
	import net.roomServer.RoomSocketIn;
	import net.roomServer.RoomSocketOut;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import proxy.login.LoginProxy;
	import proxy.packageView.PackageViewProxy;
	import proxy.plantioid.PlantioidProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import utils.battle.CalculateUtil;
	import utils.battle.FightDataUtil;
	import utils.battle.SocketUtil;
	
	import view.battle.fight.FightFeiJiComponent;
	
	import vo.battle.BattleRoomVO;
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;
	import vo.battle.fight.FightHitVO;
	import vo.battle.fight.FightItemVO;
	import vo.battle.fight.FightLockVO;
	import vo.battle.fight.FightMoveVO;
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.userInfo.UserInfoVO;

	/**
	 *战场
	 * @author zn
	 *
	 */
	public class BattleProxy extends Proxy implements IProxy
	{
		public static const NAME:String="BattleProxy";

		private var _getAllZhanCheListCallBack:Function;

		private var _enterBattleCallBack:Function;

		private var _enterBattleZhanCheID:String;

		/**
		 * 玩家所有战车
		 * value:ZhanCheInfoVO
		 */
		[Bindable]
		public var allZhanCheList:Array=[];

		public var roomVO:BattleRoomVO;

		public var userData:USER_DATA;

		public function BattleProxy(data:Object=null)
		{
			super(NAME, data);

			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_MOVING_HISTORY, moveHistoryResult);
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_FIRE, fireResult);
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_BOARDCAST_MESSAGE, customMessageResult);
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_ATTACKED, attackedResult);
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_REQUEST_BUFFER_RESULT, fightItemResult);
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_NPC_CHARIOT_ENTER, createFeiJiResult);
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_REQUEST_CONTROL_RESULT, getContorlResult);
//			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_RELEASE_CONTROL, freeContorlResult);/
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_BOARDCAST_STATUS, updateHitResult);
			
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_UPDATE_OBJECT, updateCenterResult);
		}

		/**
		 * 获取玩家所有战车信息
		 * @param callBack
		 *
		 */
		public function getAllZhanCheList(callBack:Function):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.getAllZhanCheList, getAllZhanCheListResult))
				Protocol.registerProtocol(CommandEnum.getAllZhanCheList, getAllZhanCheListResult);

			_getAllZhanCheListCallBack=callBack;
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var obj:Object={player_id: userInfoVO.player_id};
			NetHttpConn.send(CommandEnum.getAllZhanCheList, obj);
		}

		private function getAllZhanCheListResult(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.getAllZhanCheList, getAllZhanCheListResult);

			if (data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString("errors:getAllZhanCheListResult"));
				_getAllZhanCheListCallBack=null;
				return;
			}

			var list:Array=[];
			var tanks:Array=data.tanks;
			var packageProxy:PackageViewProxy=getProxy(PackageViewProxy);
			var zhanCheVO:ZhanCheInfoVO;
			for (var i:int=0; i < tanks.length; i++)
			{
				tanks[i].item_type=ItemEnum.Chariot;
				zhanCheVO=packageProxy.createZhanCheVO(tanks[i]);
				packageProxy.setZhanCheInfo(zhanCheVO, tanks[i]);
				zhanCheVO.total_shield=data.total_shield;
				list.push(zhanCheVO);
			}

			list.sortOn("level", Array.NUMERIC | Array.DESCENDING);
			allZhanCheList=list;

			if (_getAllZhanCheListCallBack != null)
				_getAllZhanCheListCallBack();
			_getAllZhanCheListCallBack=null;
		}

		/**
		 *进入战场
		 * @param id
		 * @param param1
		 *
		 */
		public function enterBattle(id:String, callBack:Function):void
		{
			_enterBattleCallBack=callBack;
			_enterBattleZhanCheID=id;

			var plantioidProxy:PlantioidProxy=getProxy(PlantioidProxy);
			plantioidProxy.getPlantioidInfo(PlantioidProxy.selectedVO.id, function():void
			{
				GamerServerSocket.instance.addEventListener(Event.CONNECT, connectComplete);
				GamerServerSocket.instance.connectServer(LoginProxy.selectedServerVO.server_game_id, LoginProxy.selectedServerVO.server_game_port);
			});
		}

		protected function connectComplete(event:Event):void
		{
			GamerServerSocket.instance.removeEventListener(Event.CONNECT, connectComplete);
			gamerServerLogin();
		}

		/**
		 *登陆gameServer
		 *
		 */
		private function gamerServerLogin():void
		{
			if (!GamerServerProtocol.hasProtocolFunction(CommandEnum.GAME2CLIENT_LOGIN_RESULT, gamerServerLoginResult))
				GamerServerProtocol.registerProtocol(CommandEnum.GAME2CLIENT_LOGIN_RESULT, gamerServerLoginResult);

			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;

			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);
			Protocol.writeByStr(userInfoVO.session_key, body);

			var out:GamerServerSocketOut=new GamerServerSocketOut(CommandEnum.GAME2CLIENT_LOGIN, body);
			GamerServerSocket.instance.sendMessage(out);
		}

		/**
		 *登陆gameServer返回
		 * @param pg
		 *
		 */
		private function gamerServerLoginResult(pg:GamerServerSocketIn):void
		{
			GamerServerProtocol.deleteProtocolFunction(CommandEnum.GAME2CLIENT_LOGIN_RESULT, gamerServerLoginResult);

			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				_enterBattleCallBack=null;
				return;
			}

			requestRoom();
		}

		/**
		 *请求房间
		 *
		 */
		private function requestRoom():void
		{
			if (!GamerServerProtocol.hasProtocolFunction(CommandEnum.GAME2CLIENT_REQUEST_ROOM_RESULT, requestRoomResult))
				GamerServerProtocol.registerProtocol(CommandEnum.GAME2CLIENT_REQUEST_ROOM_RESULT, requestRoomResult);

			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;

			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body); //攻击者id
			SocketUtil.writeIdType(_enterBattleZhanCheID, body); //攻击者tank_id
			SocketUtil.writeIdType(PlantioidProxy.selectedVO.player_id, body); //防守者id
			SocketUtil.writeIdType(PlantioidProxy.selectedVO.id, body); //要塞id

			var out:GamerServerSocketOut=new GamerServerSocketOut(CommandEnum.GAME2CLIENT_REQUEST_ROOM, body);
			GamerServerSocket.instance.sendMessage(out);
		}

		private function requestRoomResult(pg:GamerServerSocketIn):void
		{
			GamerServerProtocol.deleteProtocolFunction(CommandEnum.GAME2CLIENT_REQUEST_ROOM_RESULT, requestRoomResult);

			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				_enterBattleCallBack=null;
				return;
			}

			var roomVO:BattleRoomVO=new BattleRoomVO();
			roomVO.gid=pg.body.readInt();
			roomVO.hall_server_index=pg.body.readInt();
			roomVO.room_type=pg.body.readInt();
			roomVO.room_index=pg.body.readInt();
			roomVO.server_address_ipv4=pg.body.readInt();
			roomVO.server_listen_port=pg.body.readInt();
			roomVO.passport=pg.body.readInt();

			this.roomVO=roomVO;

			connectRoom();
		}

		/**
		 *连接房间
		 *
		 */
		private function connectRoom():void
		{
			RoomSocket.instance.addEventListener(Event.CONNECT, connectRoomComplete);
			RoomSocket.instance.connectServer(roomVO.serverAddress, roomVO.server_listen_port);
		}

		protected function connectRoomComplete(event:Event):void
		{
			RoomSocket.instance.removeEventListener(Event.CONNECT, connectRoomComplete);
			loginRoom();
		}

		/**
		 *登陆房间
		 *
		 */
		private function loginRoom():void
		{
			if (!RoomProtocol.hasProtocolFunction(CommandEnum.ROOM2CLIENT_LOGIN_RESULT, loginRoomResult))
				RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_LOGIN_RESULT, loginRoomResult);

			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;

			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);
			SocketUtil.writeIdType(_enterBattleZhanCheID, body);
			body.writeUnsignedInt(roomVO.gid);
			body.writeUnsignedInt(roomVO.room_index);
			body.writeUnsignedInt(roomVO.passport);
			body.writeUnsignedInt(0x20120518);

			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_LOGIN, body);
			RoomSocket.instance.sendMessage(out);
		}

		private function loginRoomResult(pg:RoomSocketIn):void
		{
			RoomProtocol.deleteProtocolFunction(CommandEnum.ROOM2CLIENT_LOGIN_RESULT, loginRoomResult);

			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:loginRoomResult"));
				_enterBattleCallBack=null;
				return;
			}

			roomVO.room_startup=pg.body.readInt();
			roomVO.room_will_shutdown_at=pg.body.readInt();

			userData=new USER_DATA();
			userData.mergeFrom(pg.body);
			initUserData();
			debugUserData();

			if (_enterBattleCallBack != null)
				_enterBattleCallBack();
			_enterBattleCallBack=null;
		}

		/**
		 *设置数据
		 *
		 */
		private function initUserData():void
		{
			FightDataUtil.dataDic={};

			var player1:PLAYER1;

			for (var i:int=0; i < userData.player1s.length; i++)
			{
				player1=userData.player1s[i];

				FightDataUtil.dataDic[(player1.players[0] as PLAYER).id]=player1.players[0];

				//战车
				var zhanCheVO:CHARIOT;
				for (var j:int=0; j < player1.chariots.length; j++)
				{
					//移动速度
					zhanCheVO=player1.chariots[j];
					FightDataUtil.dataDic[zhanCheVO.id]=zhanCheVO;

					zhanCheVO.voType=FightVOTypeEnum.zhanChe;
					zhanCheVO.myMoveSpeed=CalculateUtil.fightZhanCheSpeed(zhanCheVO);
					zhanCheVO.gid=player1.gid;
					zhanCheVO.lockArea=zhanCheVO.totalAttackArea;

					//挂件
					var guaJianVO:TANKPART;
					for (var k:int=0; k < zhanCheVO.tankparts.length; k++)
					{
						guaJianVO=zhanCheVO.tankparts[k];
						FightDataUtil.dataDic[guaJianVO.id]=guaJianVO;
						guaJianVO.voType=FightVOTypeEnum.guaJia;

						guaJianVO.myAttackArea=CalculateUtil.fightZhanCheAttackArea(zhanCheVO, guaJianVO);
						guaJianVO.explodeArea=guaJianVO.explodeArea;
					}
				}

				//建筑
				var fort:FORT=player1.forts[0];
				if (fort)
				{
					var buildingVO:FORTBUILDING;
					for (var i4:int=0; i4 < fort.fortbuildings.length; i4++)
					{
						buildingVO=fort.fortbuildings[i4];
						FightDataUtil.dataDic[buildingVO.id]=buildingVO;

						buildingVO.voType=FightVOTypeEnum.building;
						buildingVO.lockArea=buildingVO.searchArea;
						buildingVO.explodeArea=buildingVO.currentAttackArea;
					}
				}
			}

			//BUFF
			var buffVO:BUFFER_DEF;
			for (var i2:int=0; i2 < userData.buffers.length; i2++)
			{
				buffVO=userData.buffers[i2];
				buffVO.uid=UIDUtil.createUID();
				FightDataUtil.dataDic[buffVO.uid]=buffVO;

				buffVO.voType=FightVOTypeEnum.item;

				FightBuffItemTypeEnum.setItemType(buffVO);
				buffVO.iconURL=ResEnum.fightBuffItemIcon + buffVO.itemType + ".png";
			}

			//战车数据
			var myCar:CHARIOT;
			var zhancheVo:ZhanCheInfoVO;
			var baseVo:BaseItemVO=new BaseItemVO();
			var pageProxy:PackageViewProxy;
			var num1:Number=0;
			var num2:Number=0;
			var num3:Number=0;
			var num4:Number=0;
			var list1:Array=[];
			var list2:Array=[];

			myCar=FightDataUtil.getMyChariot();
			pageProxy=getProxy(PackageViewProxy);
			baseVo.category=myCar.category;
			baseVo.type=myCar.type;
			baseVo.enhanced=myCar.enhanced;
			baseVo.item_type=ItemEnum.Chariot;
			zhancheVo=pageProxy.createZhanCheVO(baseVo);
			myCar.name=zhancheVo.name; //战车名字
			for (var i3:int=0; i3 < myCar.tankparts.length; i3++)
			{
				var tank:TANKPART=myCar.tankparts[i3] as TANKPART;
				if (tank.slotType == 2)
				{
					list1.push(tank);
				}
				else if (tank.slotType == 1)
				{
					list2.push(tank);
				}
			}

			for (var j3:int=0; j3 < list1.length; j3++)
			{
				var tank1:TANKPART=list1[j3] as TANKPART;
				if (tank1.damageDescType == 1)
				{
					num1+=tank1.damageDesc;
				}
				else if (tank1.damageDescType == 2)
				{
					num2+=tank1.damageDesc;
				}
				else if (tank1.damageDescType == 3)
				{
					num3+=tank1.damageDesc;
				}
				else if (tank1.damageDescType == 4)
				{
					num4+=tank1.damageDesc;
				}
			}

			myCar.num1=num1; //实弹减伤百分比
			myCar.num2=num2; //激光减伤百分比
			myCar.num3=num3; //电磁减伤百分比
			myCar.num4=num4; //暗能减伤百分比

			myCar.length=list2.length; //战车装载武器挂件数
			for (var k3:int=0; k3 < list2.length; k3++)
			{
				var tank2:TANKPART=list2[k3] as TANKPART;
				if (k3 == 0)
				{
					myCar.tank1=tank2;
					myCar.attack1=tank2.attack; //战车第1挂件的攻击和下面的图片导入地址
					myCar.source1=ResEnum.senceEquipmentSmall + ItemEnum.TankPart + "_" + tank2.category + ".png";
				}
				else if (k3 == 1)
				{
					myCar.tank2=tank2;
					myCar.attack2=tank2.attack; //战车第2挂件的攻击和下面的图片导入地址
					myCar.source2=ResEnum.senceEquipmentSmall + ItemEnum.TankPart + "_" + tank2.category + ".png";
				}
				else if (k3 == 2)
				{
					myCar.tank3=tank2;
					myCar.attack3=tank2.attack; //战车第3挂件的攻击和下面的图片导入地址
					myCar.source3=ResEnum.senceEquipmentSmall + ItemEnum.TankPart + "_" + tank2.category + ".png";
				}
			}
		}

		private function debugUserData():void
		{
			//移动
			var zhanCheVO:CHARIOT=FightDataUtil.getMyChariot();
			zhanCheVO.myMoveSpeed=300;

			//炮塔
			var player1:PLAYER1=FightDataUtil.getFortPlayer1();
			var fort:FORT=player1.forts[0];
			var list:Array=[];
			var buildVO:FORTBUILDING;
			for (var i:int=0; i < fort.fortbuildings.length; i++)
			{
				buildVO=fort.fortbuildings[i];
				if (buildVO.type != 3)
				{
					fort.fortbuildings.splice(i, 1);
					i--;
				}
				else if (list.length == 0)
					list.push(buildVO);
			}
			fort.fortbuildings=list;
		}

		/**
		 *战车移动
		 * @param param0
		 * @param startX
		 * @param startY
		 * @param angle
		 * @param speed
		 * @param endX
		 * @param endY
		 *
		 */
		public function zhanCheMove(moveVO:FightMoveVO):void
		{
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_MOVING, moveVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}

		/**
		 *可移动对象移动历史
		 *
		 */
		private function moveHistoryResult(pg:RoomSocketIn):void
		{
			var nb_history:int=pg.body.readUnsignedInt();
			for (var i:int=0; i < nb_history; i++)
			{
				var fightMoveVO:FightMoveVO=new FightMoveVO();
				fightMoveVO.toObj(pg.body);

				//通知战车移动控制器
				sendNotification(FightMoveCommand.FIGHT_MOVE_COMMAND, fightMoveVO);
			}
		}

		/**
		 *开火
		 * @param fireVO
		 *
		 */
		public function fire(fireVO:FightFireVO):void
		{
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_FIRE, fireVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}

		private function fireResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var fireVO:FightFireVO=new FightFireVO();
			fireVO.toObj(pg.body);

			//通知开火控制器
			sendNotification(FightFireCommand.FIGHT_FIRE_COMMAND, fireVO);
		}

		/**
		 *锁定
		 * @param fightLockVO
		 *
		 */
		public function lock(fightLockVO:FightLockVO):void
		{
			var myID:String=FightDataUtil.getMyChariot().id.toString();
			if (fightLockVO.lockedID == myID)
				getContorl(fightLockVO.lockID);
			if (StringUtil.isEmpty(fightLockVO.lockedID) && fightLockVO.oldLocked == myID)
				freeContorl(fightLockVO.lockID);

			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_BOARDCAST_MESSAGE, fightLockVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}

		private function customMessageResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var type:int=pg.body.readUnsignedInt();
			switch (type)
			{
				case FightCustomMessageTypeEnum.LOCK:
				{
					//锁定
					var lockVO:FightLockVO=new FightLockVO();
					lockVO.toObj(pg.body);

					//通知锁定控制器
					sendNotification(FightLockCommand.FIGHT_LOCK_COMMAND, lockVO);
					break;
				}
			}
		}

		/**
		 *爆炸
		 * @param fightLockVO
		 *
		 */
		public function attacked(fightExplodeVO:FightExplodeVO):void
		{
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_ATTACKED, fightExplodeVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}

		private function attackedResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var fightExplodeVO:FightExplodeVO=new FightExplodeVO();
			fightExplodeVO.toObj(pg.body);

			//通知爆炸控制器
			sendNotification(FightExplodeCommand.FIGHT_EXPLODE_COMMAND, fightExplodeVO);
		}

		/**
		 *拾取物品
		 * @param fightExplodeVO
		 *
		 */
		public function fightItem(itemVO:FightItemVO):void
		{
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_REQUEST_BUFFER, itemVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}

		private function fightItemResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var itemVO:FightItemVO=new FightItemVO();
			itemVO.toObj(pg.body);

			//通知拾取物品控制器
			sendNotification(FightItemCommand.FIGHT_ITEM_COMMAND, itemVO);
		}

		/**
		 *撤退
		 *
		 */
		public function backReturn():void
		{
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);

			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_SURRENDER, body);
			RoomSocket.instance.sendMessage(out);
		}

		/**
		 *生成小飞机
		 * @param pg
		 *
		 */
		private function createFeiJiResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var generated_by:String=SocketUtil.readIdType(pg.body);
			var playe1:PLAYER1=new PLAYER1();
			playe1.mergeFrom(pg.body);

			var zhanCheVO:CHARIOT;
			for (var i:int=0; i < playe1.chariots.length; i++)
			{
				zhanCheVO=playe1.chariots[i];
				FightDataUtil.dataDic[zhanCheVO.id]=zhanCheVO;
				FightDataUtil.dataDic[zhanCheVO.tankparts[0].id]=zhanCheVO.tankparts[0];

				if (zhanCheVO.category == FightFeiJiComponent.XIAO_FEI_JI)
					zhanCheVO.voType=FightVOTypeEnum.xiaoFeiJi;
				else if (zhanCheVO.category == FightFeiJiComponent.DA_FEI_JI)
					zhanCheVO.voType=FightVOTypeEnum.daFeiJi;
				if (zhanCheVO.category == FightFeiJiComponent.LIAO_JI)
					zhanCheVO.voType=FightVOTypeEnum.liaoJi;

				zhanCheVO.myMoveSpeed=CalculateUtil.fightZhanCheSpeed(zhanCheVO);
				zhanCheVO.gid=playe1.gid;
				zhanCheVO.lockArea=zhanCheVO.totalAttackArea;

				zhanCheVO.tankparts[0].myAttackArea=CalculateUtil.fightZhanCheAttackArea(zhanCheVO, zhanCheVO.tankparts[0]);
				zhanCheVO.tankparts[0].voType=FightVOTypeEnum.guaJia;
			}

			//TODO:ZN 恢复
			//通知生成小飞机 控制器
//			sendNotification(FightCreateFeiJiCommand.CREATE_FEI_JI_COMMAND, playe1);
		}

		/**
		 *获取控制权
		 * @param id
		 *
		 */
		public function getContorl(id:String):void
		{
			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(id, body);

			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_REQUEST_CONTROL, body);
			RoomSocket.instance.sendMessage(out);
		}

		private function getContorlResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var id:String=SocketUtil.readIdType(pg.body);
			var myID:String=FightDataUtil.getMyChariot().id.toString();
			var voObj:Object=FightDataUtil.getVO(id);
			if (id!=myID &&  voObj)
			{
				voObj.myAttackID=FightDataUtil.getMyChariot().id;

				if (voObj.voType == FightVOTypeEnum.xiaoFeiJi)
				{
					var fightMed:BattleFightMediator=getMediator(BattleFightMediator);
					var comp:FightFeiJiComponent=fightMed.comp.getCompByID(voObj.id) as FightFeiJiComponent;
					comp.feiJiMoveTO(fightMed.comp.getCompByID(voObj.myAttackID));
				}
			}
		}

		/**
		 *释放控制权
		 * @param id
		 *
		 */
		public function freeContorl(id:String):void
		{
			var body:ByteArray=ClientSocket.getBy();
			SocketUtil.writeIdType(id, body);

			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_RELEASE_CONTROL, body);
			RoomSocket.instance.sendMessage(out);
		}

		private function freeContorlResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:freeContorlResult"));
				return;
			}
			var id:String=SocketUtil.readIdType(pg.body);
			var myID:String=FightDataUtil.getMyChariot().id.toString();
			var voObj:Object=FightDataUtil.getVO(id);
			if (id!=myID && voObj)
				voObj.myAttackID=null;
		}

		/**
		 *更新伤害
		 * @param pg
		 *
		 */
		private function updateHitResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:"+pg.result);
				return;
			}

			var count:int=pg.body.readUnsignedInt();
			var hitList:Array=[];
			var hitVO:FightHitVO;
			for (var i:int=0; i < count; i++)
			{
				hitVO=new FightHitVO();
				hitVO.toObj(pg.body);
				hitList.push(hitVO);
			}

			sendNotification(FightHitCommand.FIGHT_HIT_COMMAND, hitList);
		}
		
		/**
		 *更新对象属性 改基地耐久为5%，攻击去掉 
		 * @param pg
		 * 
		 */		
		private function updateCenterResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:"+pg.result);
				return;
			}
			
			var buildingVO:FORTBUILDING;
			var fort:FORT=FightDataUtil.getFortPlayer1().forts[0];
			for (var i:int = 0; i < fort.fortbuildings.length; i++) 
			{
				buildingVO=fort.fortbuildings[i];
				if(buildingVO.type==BattleBuildTypeEnum.JI_DI)
				{
					buildingVO.currentEndurance=buildingVO.totalEndurance*0.05;
					break;
				}
			}
			
		}
		
	/******************************************************
 *
			  * 功能方法
	  *
	* ****************************************************/
	}
}
