package proxy.battle
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;

    import controller.battle.fight.FightFireCommand;
    import controller.battle.fight.FightLockCommand;
    import controller.battle.fight.FightZhanCheMoveCommand;

    import enum.battle.GameServerErrorEnum;
    import enum.command.CommandEnum;
    import enum.item.ItemEnum;

    import flash.events.Event;
    import flash.utils.ByteArray;

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

    import vo.battle.BattleRoomVO;
    import vo.battle.fight.FightFireVO;
    import vo.battle.fight.FightLockVO;
    import vo.battle.fight.FightMoveVO;
    import vo.cangKu.ZhanCheInfoVO;
    import vo.userInfo.UserInfoVO;

    /**
     *战场
     * @author zn
     *
     */
    public class BattleProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "BattleProxy";

        private var _getAllZhanCheListCallBack:Function;

        private var _enterBattleCallBack:Function;

        private var _enterBattleZhanCheID:String;

        /**
         * 玩家所有战车
         * value:ZhanCheInfoVO
         */
        [Bindable]
        public var allZhanCheList:Array = [];

        public var roomVO:BattleRoomVO;

        public var userData:USER_DATA;

        public function BattleProxy(data:Object = null)
        {
            super(NAME, data);

            RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_MOVING_HISTORY, moveHistoryResult);
            RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_FIRE, fireResult);
            RoomProtocol.registerProtocol(CommandEnum.ROOM2CLIENT_LOCK, lockResult);
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

            _getAllZhanCheListCallBack = callBack;
            var userInfoVO:UserInfoVO = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
            var obj:Object = { player_id: userInfoVO.player_id };
            NetHttpConn.send(CommandEnum.getAllZhanCheList, obj);
        }

        private function getAllZhanCheListResult(data:*):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.getAllZhanCheList, getAllZhanCheListResult);

            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString("errors:getAllZhanCheListResult"));
                _getAllZhanCheListCallBack = null;
                return;
            }

            var list:Array = [];
            var tanks:Array = data.tanks;
            var packageProxy:PackageViewProxy = getProxy(PackageViewProxy);
            var zhanCheVO:ZhanCheInfoVO;
            for (var i:int = 0; i < tanks.length; i++)
            {
                tanks[i].item_type = ItemEnum.Chariot;
                zhanCheVO = packageProxy.createZhanCheVO(tanks[i]);
                packageProxy.setZhanCheInfo(zhanCheVO, tanks[i]);
                zhanCheVO.total_shield = data.total_shield;
                list.push(zhanCheVO);
            }

            allZhanCheList = list;

            if (_getAllZhanCheListCallBack != null)
                _getAllZhanCheListCallBack();
            _getAllZhanCheListCallBack = null;
        }

        /**
         *进入战场
         * @param id
         * @param param1
         *
         */
        public function enterBattle(id:String, callBack:Function):void
        {

            _enterBattleCallBack = callBack;
            _enterBattleZhanCheID = id;

            var plantioidProxy:PlantioidProxy = getProxy(PlantioidProxy);
            plantioidProxy.getPlantioidInfo(PlantioidProxy.selectedVO.id, function():void
            {
                GamerServerSocket.instance.addEventListener(Event.CONNECT, connectComplete);
                GamerServerSocket.instance.connectServer(LoginProxy.selectedServerVO.server_game_id, LoginProxy.selectedServerVO.server_game_port);
            });
        }

        protected function connectComplete(event:Event):void
        {
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

            var userInfoVO:UserInfoVO = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;

            var body:ByteArray = ClientSocket.getBy();
            SocketUtil.writeIdType(userInfoVO.player_id, body);
            Protocol.writeByStr(userInfoVO.session_key, body);

            var out:GamerServerSocketOut = new GamerServerSocketOut(CommandEnum.GAME2CLIENT_LOGIN, body);
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
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:GAME2CLIENT_LOGIN_RESULT"));
                _enterBattleCallBack = null;
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

            var userInfoVO:UserInfoVO = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;

            var body:ByteArray = ClientSocket.getBy();
            SocketUtil.writeIdType(userInfoVO.player_id, body); //攻击者id
            SocketUtil.writeIdType(_enterBattleZhanCheID, body); //攻击者tank_id
            SocketUtil.writeIdType(PlantioidProxy.selectedVO.player_id, body); //防守者id
            SocketUtil.writeIdType(PlantioidProxy.selectedVO.id, body); //要塞id

            var out:GamerServerSocketOut = new GamerServerSocketOut(CommandEnum.GAME2CLIENT_REQUEST_ROOM, body);
            GamerServerSocket.instance.sendMessage(out);
        }

        private function requestRoomResult(pg:GamerServerSocketIn):void
        {
            GamerServerProtocol.deleteProtocolFunction(CommandEnum.GAME2CLIENT_REQUEST_ROOM_RESULT, requestRoomResult);

            if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:requestRoomResult"));
                _enterBattleCallBack = null;
                return;
            }

            var roomVO:BattleRoomVO = new BattleRoomVO();
            roomVO.gid = pg.body.readInt();
            roomVO.hall_server_index = pg.body.readInt();
            roomVO.room_type = pg.body.readInt();
            roomVO.room_index = pg.body.readInt();
            roomVO.server_address_ipv4 = pg.body.readInt();
            roomVO.server_listen_port = pg.body.readInt();
            roomVO.passport = pg.body.readInt();

            this.roomVO = roomVO;

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

            var userInfoVO:UserInfoVO = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;

            var body:ByteArray = ClientSocket.getBy();
            SocketUtil.writeIdType(userInfoVO.player_id, body);
            SocketUtil.writeIdType(_enterBattleZhanCheID, body);
            body.writeUnsignedInt(roomVO.gid);
            body.writeUnsignedInt(roomVO.room_index);
            body.writeUnsignedInt(roomVO.passport);
            body.writeUnsignedInt(0x20120518);

            var out:RoomSocketOut = new RoomSocketOut(CommandEnum.ROOM2CLIENT_LOGIN, body);
            RoomSocket.instance.sendMessage(out);
        }

        private function loginRoomResult(pg:RoomSocketIn):void
        {
            RoomProtocol.deleteProtocolFunction(CommandEnum.ROOM2CLIENT_LOGIN_RESULT, loginRoomResult);

            if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:loginRoomResult"));
                _enterBattleCallBack = null;
                return;
            }

            roomVO.room_startup = pg.body.readInt();
            roomVO.room_will_shutdown_at = pg.body.readInt();

            userData = new USER_DATA();
            userData.mergeFrom(pg.body);
            initUserData();
            debugUserData();

            if (_enterBattleCallBack != null)
                _enterBattleCallBack();
            _enterBattleCallBack = null;
        }

        /**
         *设置数据
         *
         */
        private function initUserData():void
        {
            var player1:PLAYER1;

            for (var i:int = 0; i < userData.player1s.length; i++)
            {
                player1 = userData.player1s[i];

                //战车
                var zhanCheVO:CHARIOT;
                for (var j:int = 0; j < player1.chariots.length; j++)
                {
                    //移动速度
                    zhanCheVO = player1.chariots[j];
                    zhanCheVO.moveSpeed = CalculateUtil.fightZhanCheSpeed(zhanCheVO);

                    //挂件
                    var guaJianVO:TANKPART;
                    for (var k:int = 0; k < zhanCheVO.tankparts.length; k++)
                    {
                        guaJianVO = zhanCheVO.tankparts[k];
                        guaJianVO.attackArea = CalculateUtil.fightZhanCheAttackArea(zhanCheVO, guaJianVO);
                    }
                }
            }
        }

        private function debugUserData():void
        {
            var zhanCheVO:CHARIOT = FightDataUtil.getMyChariot();
            zhanCheVO.moveSpeed = 300;


            var player1:PLAYER1 = FightDataUtil.getFortPlayer1();
            var fort:FORT = player1.forts[0];
            var list:Array = [];
            var buildVO:FORTBUILDING;
            for (var i:int = 0; i < fort.fortbuildings.length; i++)
            {
                buildVO = fort.fortbuildings[i];
                if (buildVO.type != 3)
                {
                    fort.fortbuildings.splice(i, 1);
                    i--;
                }
                else if (list.length == 0)
                    list.push(buildVO);
            }
            fort.fortbuildings = list;
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
            var out:RoomSocketOut = new RoomSocketOut(CommandEnum.ROOM2CLIENT_MOVING, moveVO.toBy());
            RoomSocket.instance.sendMessage(out);
        }

        /**
         *可移动对象移动历史
         *
         */
        private function moveHistoryResult(pg:RoomSocketIn):void
        {
            var fightMoveVO:FightMoveVO = new FightMoveVO();
            var nb_history:int = pg.body.readUnsignedInt();
            fightMoveVO.toObj(pg.body);

            //通知战车移动控制器
            sendNotification(FightZhanCheMoveCommand.FIGHT_ZHAN_CHE_MOVE_COMMAND, fightMoveVO);
        }

        /**
         *开火
         * @param fireVO
         *
         */
        public function fire(fireVO:FightFireVO):void
        {
            var out:RoomSocketOut = new RoomSocketOut(CommandEnum.ROOM2CLIENT_FIRE, fireVO.toBy());
            RoomSocket.instance.sendMessage(out);
        }

        private function fireResult(pg:RoomSocketIn):void
        {
            if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:fireResult"));
                return;
            }

            var fireVO:FightFireVO = new FightFireVO();
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
            var out:RoomSocketOut = new RoomSocketOut(CommandEnum.ROOM2CLIENT_LOCK, fightLockVO.toBy());
            RoomSocket.instance.sendMessage(out);
        }

        private function lockResult(pg:RoomSocketIn):void
        {
            if (pg.result != GameServerErrorEnum.RESULT_SUCCESS)
            {
                sendNotification(PromptMediator.SHOW_INFO_NOTE, MultilanguageManager.getString("errors:lockResult"));
                return;
            }

            var lockVO:FightLockVO = new FightLockVO();
            lockVO.toObj(pg.body);

            //通知锁定控制器
            sendNotification(FightLockCommand.FIGHT_LOCK_COMMAND, lockVO);
        }

    /******************************************************
 *
         * 功能方法
      *
    * ****************************************************/
    }
}
