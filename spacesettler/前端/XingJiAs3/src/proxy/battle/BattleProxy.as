package proxy.battle
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.net.socket.ClientSocket;
	import com.zn.utils.SoundUtil;
	import com.zn.utils.StringUtil;
	import com.zn.utils.UIDUtil;
	
	import controller.battle.fight.FightCreateFeiJiCommand;
	import controller.battle.fight.FightDropHonorCommand;
	import controller.battle.fight.FightExplodeCommand;
	import controller.battle.fight.FightFireCommand;
	import controller.battle.fight.FightHitCommand;
	import controller.battle.fight.FightItemCommand;
	import controller.battle.fight.FightLockCommand;
	import controller.battle.fight.FightMoveCommand;
	import controller.battle.fight.FightNewPlayerCommand;
	import controller.battle.fight.FightResurgenceCommand;
	import controller.battle.fight.fightMorePlayer.FightZhanCheFuHuoCommand;
	import controller.battle.fight.fightMorePlayer.FightZhanCheMaoYanCommand;
	import controller.task.TaskCompleteCommand;
	
	import enum.ResEnum;
	import enum.SoundEnum;
	import enum.TaskEnum;
	import enum.battle.BattleBuildTypeEnum;
	import enum.battle.FightBuffItemTypeEnum;
	import enum.battle.FightCustomMessageTypeEnum;
	import enum.battle.FightVOTypeEnum;
	import enum.battle.GameServerErrorEnum;
	import enum.command.CommandEnum;
	import enum.factory.FactoryEnum;
	import enum.item.ItemEnum;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mediator.battle.BattleBuyComponentMediator;
	import mediator.battle.BattleFailPanelComponentMediator;
	import mediator.battle.BattleFightMediator;
	import mediator.battle.BattleFightViewComponentMediator;
	import mediator.battle.BattleTiShiPanelComponentMediator;
	import mediator.battle.BattleVictoryPanelComponentMediator;
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
	
	import other.ConnDebug;
	
	import proxy.login.LoginProxy;
	import proxy.packageView.PackageViewProxy;
	import proxy.plantioid.PlantioidProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import utils.battle.CalculateUtil;
	import utils.battle.FightDataUtil;
	import utils.battle.SocketUtil;
	
	import view.battle.fight.BattleFightComponent;
	import view.battle.fight.FightFeiJiComponent;
	import view.battle.fight.FightItemComponent;
	import view.battle.fightView.BattleFailPanelComponent;
	import view.battle.fightView.BattleFightViewComponent;
	
	import vo.battle.BattleRoomVO;
	import vo.battle.fight.FightExplodeVO;
	import vo.battle.fight.FightFireVO;
	import vo.battle.fight.FightHitVO;
	import vo.battle.fight.FightHonorVO;
	import vo.battle.fight.FightItemVO;
	import vo.battle.fight.FightLockVO;
	import vo.battle.fight.FightMoveVO;
	import vo.battle.fight.FightResultVO;
	import vo.battle.fight.FightResurgenceVo;
	import vo.battle.fight.FightVictoryRewardVO;
	import vo.battle.fight.fightMorePlayer.FightZhanCheFuHuoVO;
	import vo.battle.fight.fightMorePlayer.FightZhanCheMaoYanVO;
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
		
		public static var isChaoShi:Boolean=false;

		private var _getAllZhanCheListCallBack:Function;

		private var _enterBattleCallBack:Function;

		private var _enterBattleZhanCheID:String;
		
		private var _callBackFun:Function;
		
		
		/**
		 * 玩家所有战车
		 * value:ZhanCheInfoVO
		 */
		[Bindable]
		public var allZhanCheList:Array=[];

		public var roomVO:BattleRoomVO;

		public var userData:USER_DATA;

		public var newUserData:USER_DATA;
		
		public var pickupArr:Array=[];

		public var isCompleteRenWu:Boolean;
		
		public function BattleProxy(data:Object=null)
		{
			super(NAME, data);
			
			
			// 可移动对象移动历史    （广播）
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_MOVING_HISTORY, moveHistoryResult);
			//攻击者对象移动
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_MOVING, zhanCheMoveResult);
			// 开火
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_FIRE, fireResult);
			//自定义消息
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_BOARDCAST_MESSAGE, customMessageResult);
			//爆炸伤害
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_ATTACKED, attackedResult);
			//捡到物品 返回      (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_REQUEST_BUFFER_RESULT, fightItemResult);
			//生成小飞机    (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_NPC_CHARIOT_ENTER, createFeiJiResult);
			//请求控制结果    (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_REQUEST_CONTROL_RESULT, getContorlResult);
			
//			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_RELEASE_CONTROL, freeContorlResult);/
			//广播受到伤害对象当前  (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_BOARDCAST_STATUS, updateHitResult);
			//更新对象属性 改基地耐久为5%，攻击去掉  (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_UPDATE_OBJECT, updateCenterResult);
			//击毁建筑（炮台）获得荣誉  (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_OBTAIN_HONOR, dropHonorResult);
			//	新玩家进入房间   (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_PLAYER_ENTER, newPlayerEnterResult);
			//游戏结束 (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_FINISH, finishResult);
			//游戏超时结束 (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_FINISH_TIMEOUT, finishTimeOutResult);
			//断开连接，赢了才会有战斗结果 (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_SHUTDOWN, shutDownResult);
			//打爆建筑时的物品掉落  (广播)
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_BUFFER_GENERATED, dropItemResult);
			//多人同时战斗（广播投票）
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_VOTE_STARTUP,voteSatrtUpResult);
			//购买结果返回（广播）
			RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_VOTE_RESULT,buyResult);
		}

		/**
		 * 获取玩家所有战车信息
		 * @param callBack
		 *
		 */
		public function getAllZhanCheList(callBack:Function = null):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.getAllZhanCheList, getAllZhanCheListResult))
				Protocol.registerProtocol(CommandEnum.getAllZhanCheList, getAllZhanCheListResult);

			_getAllZhanCheListCallBack=callBack;
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var obj:Object={player_id: userInfoVO.player_id};
			ConnDebug.send(CommandEnum.getAllZhanCheList, obj);
		}

		private function getAllZhanCheListResult(data:*):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.getAllZhanCheList, getAllZhanCheListResult);

			if (data.hasOwnProperty("errors"))
			{
				trace(data.errors);
//				sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString("errors:getAllZhanCheListResult"));
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
			
			isChaoShi=false;
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
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:loginRoomResult"));
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
		 *	新玩家进入房间   (广播)
		 *
		 */
		private function newPlayerEnterResult(pg:RoomSocketIn):void
		{
//			RoomProtocol.deleteProtocolFunction(CommandEnum.ROOM2CLIENT_PLAYER_ENTER, newPlayerEnterResult);
			
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:ROOM2CLIENT_PLAYER_ENTER"));
				return;
			}
			
			if(pg.bytesAvailable>0)
			{
				pg.body.readInt();
				pg.body.readInt();
				
				if(pg.bytesAvailable>0)
				{
					newUserData=new USER_DATA();
					newUserData.mergeFrom(pg.body);
					var fortPlayer1:PLAYER1=newUserData.player1s[0]
					userData.player1s.push(fortPlayer1);
					sendNotification(BattleFightViewComponentMediator.UPDATE_ITEM_NOTE);
					sendNotification(FightNewPlayerCommand.FIGHT_NEWPLAYER_COMMAND,fortPlayer1);
				}
				
				
			}
			
		}
		
		/**
		 *复活
		 *
		 */
		public function gamerResurgence(fightResVo:FightResurgenceVo,fun:Function=null):void
		{
			if (!RoomProtocol.hasProtocolFunction(CommandEnum.ROOM2CLIENT_OBJECT_REQUEST_RELIVE, gamerResurgenceResult))
				RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_OBJECT_REQUEST_RELIVE, gamerResurgenceResult);
			
			var body:ByteArray=fightResVo.toBy();
//			SocketUtil.writeIdType(fightResVo.idType, body);
			_callBackFun=fun;
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_OBJECT_REQUEST_RELIVE, body);
			RoomSocket.instance.sendMessage(out);
		}
		
		private function gamerResurgenceResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}
			
			var fightResVo:FightResurgenceVo=new FightResurgenceVo();
			fightResVo.toObj(pg.body);
			sendNotification(FightResurgenceCommand.FIGHT_RESURGENCE_COMMAND,fightResVo);
			
			var fightZhanCheFuHuoVO:FightZhanCheFuHuoVO=new FightZhanCheFuHuoVO();
			fightZhanCheFuHuoVO.id=fightResVo.idType;
			fightZhanCheFuHuoVO.isFuHuo=1;
			zhanCheFuHuo(fightZhanCheFuHuoVO);
			
			if(_callBackFun!=null)
				_callBackFun();
			_callBackFun=null;
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
					zhanCheVO.gid=player1.gid;

					setZhanCheProperty(zhanCheVO);
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

						buildingVO.myAttackArea=300;
						buildingVO.attackCoolEndTime=0;
						buildingVO.voType=FightVOTypeEnum.building;
						buildingVO.lockArea=buildingVO.searchArea;
						buildingVO.explodeArea=buildingVO.currentAttackArea + 100; //TODO:ZN 恢复建筑的攻击范围
						buildingVO.name=BattleBuildTypeEnum.getBuildName(buildingVO.type);
					}
				}
			}

			//BUFF
			var buffVO:BUFFER_DEF;
			for (var i2:int=0; i2 < userData.buffers.length; i2++)
			{
				buffVO=userData.buffers[i2];
				setBuffProperty(buffVO,zhanCheVO);
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

		private function setBuffProperty(buffVO:BUFFER_DEF, zhanCheVO:CHARIOT=null):void
		{
			buffVO.uid=buffVO.x+";"+buffVO.y;
			FightDataUtil.dataDic[buffVO.uid]=buffVO;
		
			buffVO.voType=FightVOTypeEnum.item;
		
			FightBuffItemTypeEnum.setItemType(buffVO);
			if (buffVO.itemType == FightBuffItemTypeEnum.liaoJi)
			{
				zhanCheVO=buffVO.wingman[0];
				FightDataUtil.dataDic[zhanCheVO.id]=zhanCheVO;
				setZhanCheProperty(zhanCheVO);
			}
		}


		public function setZhanCheProperty(zhanCheVO:CHARIOT):void
		{
			zhanCheVO.voType=FightVOTypeEnum.zhanChe;
			zhanCheVO.myMoveSpeed=CalculateUtil.fightZhanCheSpeed(zhanCheVO);
//			zhanCheVO.lockArea=zhanCheVO.totalAttackArea;
			//TODO:ZN 恢复战车的锁定范围
			zhanCheVO.lockArea=250;
				
			//挂件
			var guaJianVO:TANKPART;
			for (var k:int=0; k < zhanCheVO.tankparts.length; k++)
			{
				guaJianVO=zhanCheVO.tankparts[k];
				FightDataUtil.dataDic[guaJianVO.id]=guaJianVO;
				guaJianVO.voType=FightVOTypeEnum.guaJia;

//				guaJianVO.myAttackArea=CalculateUtil.fightZhanCheAttackArea(zhanCheVO, guaJianVO);
				guaJianVO.myAttackArea=350;//TODO:ZN 恢复挂件的攻击范围
				guaJianVO.explodeArea=guaJianVO.explodeArea + 100; //TODO:ZN 恢复挂件的爆炸范围
			}
		}


		private function debugUserData():void
		{
			//移动
			var zhanCheVO:CHARIOT=FightDataUtil.getMyChariot();
			zhanCheVO.myMoveSpeed=300;

			//炮塔
//			var player1:PLAYER1=FightDataUtil.getFortPlayer1();
//			var fort:FORT=player1.forts[0];
//			var list:Array=[];
//			var buildVO:FORTBUILDING;
//			for (var i:int=0; i < fort.fortbuildings.length; i++)
//			{
//				buildVO=fort.fortbuildings[i];
//				if (buildVO.type != 3)
//				{
//					fort.fortbuildings.splice(i, 1);
//					i--;
//				}
//				else if (list.length == 0)
//					list.push(buildVO);
//			}
//			fort.fortbuildings=list;
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
		
		//攻击者对象移动
		private function zhanCheMoveResult(pg:RoomSocketIn):void
		{
			var fightMoveVO:FightMoveVO=new FightMoveVO();
			fightMoveVO.toObj(pg.body);
			
			//通知战车移动控制器
			sendNotification(FightMoveCommand.FIGHT_MOVE_COMMAND, fightMoveVO);
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

		// 开火
		private function fireResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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
			//TODU LW:
//			if (StringUtil.isEmpty(fightLockVO.lockedID) && fightLockVO.oldLocked == myID)
			if (StringUtil.isEmpty(fightLockVO.lockedID) || fightLockVO.oldLocked == myID)
				freeContorl(fightLockVO.lockID);

			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_BOARDCAST_MESSAGE, fightLockVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}

		//自定义消息
		private function customMessageResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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
				case FightCustomMessageTypeEnum.MAO_YAN:
				{
					//冒烟
					var fightZhanCheMaoYanVO:FightZhanCheMaoYanVO = new FightZhanCheMaoYanVO();
					fightZhanCheMaoYanVO.toObj(pg.body);
					//通知冒烟控制器
					sendNotification(FightZhanCheMaoYanCommand.FIGHT_ZHAN_CHE_MAO_YAN_COMMAND,fightZhanCheMaoYanVO);
					break;
				}
				case FightCustomMessageTypeEnum.FU_HUO:
				{
					//复活
					var fightZhanCheFuHuoVO:FightZhanCheFuHuoVO=new FightZhanCheFuHuoVO();
					fightZhanCheFuHuoVO.toObj(pg.body);
					//通知复活控制器
					sendNotification(FightZhanCheFuHuoCommand.FIGHT_ZHAN_CHE_FU_HUO_COMMAND,fightZhanCheFuHuoVO);
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

		//爆炸伤害
		private function attackedResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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

		//捡到物品 返回      (广播)
		private function fightItemResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			//TODO:GX 需要恢复正常
			
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
				
				//TODO:ZN 回复
				zhanCheVO.tankparts[0].explodeArea=1000;
			}

			//通知生成小飞机 控制器
			sendNotification(FightCreateFeiJiCommand.CREATE_FEI_JI_COMMAND, playe1);
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

		//请求控制结果    (广播)
		private function getContorlResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				//TODU LW:此处需要屏蔽
				//412请求控制结果
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var id:String=SocketUtil.readIdType(pg.body);
			var myID:String=FightDataUtil.getMyChariot().id.toString();
			var voObj:Object=FightDataUtil.getVO(id);
			if (id != myID && voObj)
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

//		private function freeContorlResult(pg:RoomSocketIn):void
//		{
//			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
//			{
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:freeContorlResult"));
//				return;
//			}
//			var id:String=SocketUtil.readIdType(pg.body);
//			var myID:String=FightDataUtil.getMyChariot().id.toString();
//			var voObj:Object=FightDataUtil.getVO(id);
//			if (id!=myID && voObj)
//				voObj.myAttackID=null;
//		}

		/**
		 *广播开始投票 
		 * @param pg
		 * 
		 */		
		private function voteSatrtUpResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}
			sendNotification(BattleBuyComponentMediator.SHOW_NOTE);
		}
		
		/**
		 *放弃或购买调用接口 
		 * @param buyType
		 * @param cost
		 * 
		 */		
		public function buy(buyType:int,cost:int):void
		{
			var userInforProxy:UserInfoProxy = getProxy(UserInfoProxy);
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(userInforProxy.userInfoVO.player_id, body);
			body.writeUnsignedInt(buyType);//32位
			body.writeUnsignedInt(cost);//32位
			
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_VOTE, body);
			RoomSocket.instance.sendMessage(out);
		}
		
		private function buyResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}
			//TODO LW: 显示谁购买到了此要塞
			//显示谁购买到了此要塞(此处忽略)
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
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
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
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var buildingVO:FORTBUILDING;
			var fort:FORT=FightDataUtil.getFortPlayer1().forts[0];
			for (var i:int=0; i < fort.fortbuildings.length; i++)
			{
				buildingVO=fort.fortbuildings[i];
				if (buildingVO.type == BattleBuildTypeEnum.JI_DI)
				{
					buildingVO.currentEndurance=buildingVO.totalEndurance * 0.05;
					break;
				}
			}
		}

		/**
		 *击毁建筑（炮台）获得荣誉
		 * @param pg
		 *
		 */
		private function dropHonorResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}

			var honorVO:FightHonorVO=new FightHonorVO();
			honorVO.toObj(pg.body);

			var buffVO:BUFFER_DEF=new BUFFER_DEF();
			buffVO.uid=UIDUtil.createUID();
			buffVO.itemType=FightBuffItemTypeEnum.honor;
			buffVO.iconURL=ResEnum.fightBuffItemIcon + buffVO.itemType + ".png";
			buffVO.data=honorVO;
			sendNotification(FightDropHonorCommand.FIGHT_DROP_HONOR_COMMAND, buffVO);
			sendNotification(BattleFightViewComponentMediator.ADDCOUNT_NOTE);
		}
		
		/**
		 * 游戏结束
		 * @param pg
		 *
		 */
		private function finishResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{				
				trace("errors:" + pg.result);
				return;
			}
			
			sendNotification(BattleFightViewComponentMediator.STOPCD_NOTE);
		}
		

		/**
		 *物品掉落
		 * @param pg
		 *
		 */
		private function dropItemResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, "errors:" + pg.result);
				return;
			}
			var buffVO:BUFFER_DEF=new BUFFER_DEF();
			buffVO.mergeFrom(pg.body);
			setBuffProperty(buffVO);
			
			var fightItemComp:FightItemComponent=new FightItemComponent();
			fightItemComp.itemVO=buffVO;

			var fightMed:BattleFightMediator=getMediator(BattleFightMediator);

			fightMed.comp.buildCompList.push(fightItemComp);
			fightMed.comp.compIDDic[buffVO.uid]=fightItemComp;
			fightMed.comp.allCompList.push(fightItemComp);

			fightMed.comp.buildSp.addChild(fightItemComp);
		}
		
		/**
		 * 游戏超时结束
		 * @param pg
		 *
		 */
		private function finishTimeOutResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:finishTimeOutResult"));
				return;
			}
			
			isChaoShi=true;
			sendNotification(BattleFightViewComponentMediator.LOSE_NOTE);
			sendNotification(BattleFightViewComponentMediator.STOPCD_NOTE);
		}
		
		/**
		 *断开连接，赢了才会有战斗结果
		 * @param pg
		 *
		 */
		private function shutDownResult(pg:RoomSocketIn):void
		{
			if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
			{
				trace("errors:" + pg.result);
//				sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:shutDownResult"));
				return;
			}
			
			var fightVictoryRewardVO:FightVictoryRewardVO = new FightVictoryRewardVO();
			//			fightVictoryRewardVO.toObj(pg.body);
			fightVictoryRewardVO.crystal=pg.body.readInt();
			fightVictoryRewardVO.tritium=pg.body.readInt();
			fightVictoryRewardVO.dark=pg.body.readInt();
			fightVictoryRewardVO.dark_crystal=pg.body.readInt();
			fightVictoryRewardVO.resource_type=pg.body.readInt();
			fightVictoryRewardVO.delta=pg.body.readInt();
			fightVictoryRewardVO.bluemap_recipes_type=pg.body.readInt();
			fightVictoryRewardVO.bluemap_recipes_category=pg.body.readInt();
			fightVictoryRewardVO.bluemap_level=pg.body.readInt();
			fightVictoryRewardVO.honour_obtain=pg.body.readInt();
			fightVictoryRewardVO.gain_fort=pg.body.readInt();
			fightVictoryRewardVO.dark_delta=pg.body.readInt();
			fightVictoryRewardVO.dark_crystal_for_relive=pg.body.readInt();
			isCompleteRenWu=true;
			
			if(isChaoShi)
				return;
			sendNotification(BattleVictoryPanelComponentMediator.SHOW_NOTE,fightVictoryRewardVO);
			sendNotification(BattleFightViewComponentMediator.STOPCD_NOTE);
		}
		
		
		/**
		 *战车冒烟
		 * @param fightZhanCheMaoYanVO
		 *
		 */
		public function zhanCheMaoYan(fightZhanCheMaoYanVO:FightZhanCheMaoYanVO):void
		{
//			var myID:String=FightDataUtil.getMyChariot().id.toString();
//			if (fightZhanCheMaoYanVO.id == myID)
//				return;
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_BOARDCAST_MESSAGE, fightZhanCheMaoYanVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}
		
		/**
		 * 战车复活通知小队中其他玩家
		 * @param fightZhanCheMaoYanVO
		 *
		 */
		public function zhanCheFuHuo(fightZhanCheFuHuoVO:FightZhanCheFuHuoVO):void
		{
			var out:RoomSocketOut=new RoomSocketOut(CommandEnum.ROOM2CLIENT_BOARDCAST_MESSAGE, fightZhanCheFuHuoVO.toBy());
			RoomSocket.instance.sendMessage(out);
		}
		
	/******************************************************
	*
	* 功能方法
	*
	* ****************************************************/
	}
}
