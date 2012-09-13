package sim
{
    import com.zn.LocalSharedObject;
    
    import enum.CommandEnum;
    
    import sim.vo.SimVO;

    public class SimLogin
    {

        public static var userName:String;

        private static var _so:LocalSharedObject;

		public static var simVO:SimVO;
		
        public static function login(obj:Object):void
        {
            userName = obj.userName;
            _so = LocalSharedObject.getLocal(userName);
            clean();

			simVO = _so.data[userName];
            if (!simVO)
            {
				simVO = new SimVO();

//                createFishPort();
//                createTaskVO();
//                createFishFarm();
//                createShip();
//                createOrnament();
//                createProp();
//                createFishFryVO();
//                createAchieveVO();
//                createMapVO();

                save();
            }

			SimHttpConn.serverToClient(CommandEnum.LOGIN,null,0);
        }

        public static function save():void
        {
        	_so.save(userName, simVO);
        }

        public static function clean():void
        {
            _so.clear();
        }

//        private static function createFishPort():void
//        {
//            userVO.fishPort = new FishPortVO();
//            userVO.fishPort.zoneCount = 0;
//            userVO.fishPort.zoneMaxCount = 30;
//        }
//
//        private static function createTaskVO():void
//        {
//            userVO.taskVO = new TaskVO();
//
//            var taskItemVO:TaskItemVO = new TaskItemVO();
//            taskItemVO.iconURL = "zh_CN/images/taskIcon/1.png";
//            taskItemVO.state = TaskStateEnum.NEW_TYPE;
//            taskItemVO.des = "收费多少大法师打发斯蒂芬是打发斯蒂芬发斯蒂芬";
//
//            var awardItemVO:AwardItemVO = new AwardItemVO();
//            awardItemVO.type = AwardTypeEnum.GOLD;
//            awardItemVO.num = 100;
//            taskItemVO.awardItemList.push(awardItemVO);
//
//            userVO.taskVO.taskVOList.push(taskItemVO);
//        }
//
//        private static function createFishFarm():void
//        {
//            var fishFarmVO:FishFarmVO = new FishFarmVO();
//
//            fishFarmVO.ornamentVO = new FishFarmOrnamentVO();
//            fishFarmVO.ornamentVO.bgOrnamentVO = new OrnamentItemVO();
//            fishFarmVO.ornamentVO.bgOrnamentVO.url = "zh_CN/images/ornament/1.jpg";
//
//            fishFarmVO.ornamentVO.zone = 0;
//            fishFarmVO.ornamentVO.zoneMax = 10;
//
//            userVO.fishFarmVO = fishFarmVO;
//        }
//
//        private static function createShip():void
//        {
//            var shipVO:ShipItemVO = new ShipItemVO();
//            shipVO.nameURL = "zh_CN/images/shipName/1.png";
//            shipVO.url = "zh_CN/images/ship/1.png";
//            shipVO.level = 1;
//            shipVO.bottomPoint = new Point(56, 110);
//            shipVO.visibleRadius = 200;
//            shipVO.moveSpeed = 300;
//            shipVO.durableMAX = 100;
//            shipVO.durable = 0;
//
//            userVO.shipVO = new ShipVO();
//            userVO.shipVO.currentShipItemVO = shipVO;
//
//            var nextShipVO:ShipItemVO = new ShipItemVO();
//            nextShipVO.nameURL = "zh_CN/images/shipName/1.png";
//            nextShipVO.url = "zh_CN/images/ship/1.png";
//            nextShipVO.level = 1;
//            userVO.shipVO.currentShipItemVO.nextShipItemVO = nextShipVO;
//
//            shipVO.fishNet = new FishNetVO();
//            shipVO.fishNet.catchRadius = 50;
//            shipVO.fishNet.url = "zh_CN/images/yuWang/1.zip";
//            shipVO.fishNet.fileName = "1";
//            shipVO.fishNet.attackClassName = "yw_1";
//            shipVO.fishNet.expandMCClassName = "yw";
//            shipVO.fishNet.expandMCkFrame = 5;
//            shipVO.fishNet.expandMCFrameRate = 15;
//            shipVO.fishNet.shouWangClassName = "sw";
//        }
//
//        private static function createOrnament():void
//        {
//            userVO.ornamentVO = new OrnamentVO();
//
//            var ornamentItemVO:OrnamentItemVO = new OrnamentItemVO();
//            ornamentItemVO.price = 100;
//            ornamentItemVO.sortType = OrnamentTypeEnum.NEW_TYPE;
//            userVO.ornamentVO.shopVOList.push(ornamentItemVO);
//        }
//
//        private static function createProp():void
//        {
//            userVO.propVO = new PropVO();
//        }
//
//        private static function createFishFryVO():void
//        {
//            userVO.fishFryVO = new FishFryVO();
//        }
//
//        private static function createAchieveVO():void
//        {
//            userVO.achieveVO = new AchieveVO();
//        }
//
//        private static function createMapVO():void
//        {
//            userVO.mapVO = new MapVO();
//            userVO.mapVO.currentMapItemVO = new MapItemVO();
//            userVO.mapVO.currentMapItemVO.id = "1";
//            userVO.mapVO.currentMapItemVO.name = "西海";
//            userVO.mapVO.currentMapItemVO.nameIconURL = "zh_CN/images/catchFishSeaName/1.png";
//            userVO.mapVO.currentMapItemVO.bgURL = "zh_CN/images/catchFishBG/1.jpg";
//
//            userVO.mapVO.mapList.push(userVO.mapVO.currentMapItemVO);
//        }
    }
}
