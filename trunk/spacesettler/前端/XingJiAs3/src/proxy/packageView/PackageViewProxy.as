package proxy.packageView
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.net.Protocol;
    import com.zn.utils.ObjectUtil;
    import com.zn.utils.StringUtil;
    import com.zn.utils.XMLUtil;
    
    import enum.command.CommandEnum;
    import enum.item.ItemEnum;
    
    import flash.display.DisplayObject;
    import flash.net.URLRequestMethod;
    
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import proxy.content.ContentProxy;
    import proxy.scienceResearch.ScienceResearchProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import utils.battle.CalculateUtil;
    
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.GuaJianInfoVO;
    import vo.cangKu.ItemVO;
    import vo.cangKu.RecipesStudyConditionVO;
    import vo.cangKu.ZhanCheInfoVO;
    import vo.scienceResearch.ScienceResearchVO;

    /**
     *仓库
     * @author zn
     *
     */
    public class PackageViewProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "PackageViewProxy";

        private var _packageViewViewCallBack:Function;

        public var packageXML:XML;

        public var tuZhiXML:XML;
		
		public var itemXML:XML;

        public var itemVOList:Array = [];

        public var chakanVO:BaseItemVO;

        private var _chariotInfoCallBack:Function;

        private var _getTankPartInfoCallBack:Function;

        public function PackageViewProxy(data:Object = null)
        {
            super(NAME, data);

            packageXML = XMLUtil.getXML("package.xml");
            tuZhiXML = XMLUtil.getXML("recipes.xml");
			itemXML = XMLUtil.getXML("items.xml");
        }

        /**
         *获取仓库列表
         * @param callBack
         *
         */
        public function packageViewView(callBack:Function = null):void
        {
			var scienceProxy:ScienceResearchProxy=getProxy(ScienceResearchProxy);
			scienceProxy.getScienceResearchInfor(function():void
			{
				//先获取科技
				if (!Protocol.hasProtocolFunction(CommandEnum.getPackageInfo, packageViewResult))
					Protocol.registerProtocol(CommandEnum.getPackageInfo, packageViewResult);
				
				_packageViewViewCallBack = callBack;
				
				var playerID:String = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
				var obj:Object = { player_id: playerID };
				ConnDebug.send(CommandEnum.getPackageInfo, obj, ConnDebug.HTTP, URLRequestMethod.GET);
			});
        }

        private function packageViewResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.getPackageInfo, packageViewResult);
			Protocol.deleteProtocolFunction(CommandEnum.useItem, packageViewResult);
			Protocol.deleteProtocolFunction(CommandEnum.destroyItem, packageViewResult);
			Protocol.deleteProtocolFunction(CommandEnum.addSpace, packageViewResult);
			Protocol.deleteProtocolFunction(CommandEnum.groupDonate, packageViewResult);
            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString(data.errors));
                _packageViewViewCallBack = null;
                return;
            }
			
			var userProxy:UserInfoProxy=getProxy(UserInfoProxy);
			if(data.prestige)
				userProxy.userInfoVO.prestige=int(data.prestige);
			if(data.vip_level)
				userProxy.userInfoVO.vip_level=data.vip_level;
			if(data.dark_crystal)
				userProxy.userInfoVO.dark_crystal=data.dark_crystal;
            itemVOList = [];

            var zhanCheInfoVO:ZhanCheInfoVO;
            var guaJianVO:GuaJianInfoVO;
            var itemVO:ItemVO;

            for each (var objItem:Object in data["package"])
            {
                switch (objItem.item_type)
                {
                    case ItemEnum.Chariot:
                    {
                        zhanCheInfoVO = createZhanCheVO(objItem);
                        zhanCheInfoVO.level = objItem.level;
                        zhanCheInfoVO.value = objItem.value;
                        zhanCheInfoVO.dark_matter_value = objItem.dark_matter_value;

                        itemVOList.push(zhanCheInfoVO);
                        break;
                    }
                    case ItemEnum.TankPart:
                    {
                        guaJianVO = createGuaJianVO(objItem);
                        guaJianVO.level = objItem.level;
                        guaJianVO.slot_type = objItem.slot_type;
                        guaJianVO.value = objItem.value;
                        guaJianVO.dark_matter_value = objItem.dark_matter_value;
                        guaJianVO.is_mounted = objItem.is_mounted;

                        itemVOList.push(guaJianVO);
                        break;
                    }
                    case ItemEnum.recipes:
                    {
                        itemVO = createTuZhiVO(objItem);

                        itemVO.can_use = objItem.can_use;
                        itemVO.tank_part_type = objItem.tank_part_type;

                        itemVOList.push(itemVO);
                        break;
                    }
                    case ItemEnum.item:
                    {
                        itemVO = createDaoJuVO(objItem);

                        itemVO.in_using = objItem.in_using;
                        itemVO.time = objItem.time;
                        itemVO.vip_level = objItem.vip_level;
                        itemVO.crystal_inc = objItem.crystal_inc;
                        itemVO.tritium_inc = objItem.tritium_inc;
                        itemVO.broken_crystal_inc = objItem.broken_crystal_inc;
                        itemVO.discount = objItem.discount;

                        itemVOList.push(itemVO);
                        break;
                    }
                    default:
                    {
                        itemVOList.push(null);
                    }
                }
            }

            itemVOList.sortOn("item_type");
			
			sendNotification(CangkuPackageViewComponentMediator.UPDATA_LIST);
			
            if (_packageViewViewCallBack != null)
                _packageViewViewCallBack();
            _packageViewViewCallBack = null;
        }
		
		
		/**
		 *捐献军团 
		 * @param player_id 用户ID
		 * @param legion_id 军团ID
		 * @param id  物品ID
		 * @param count  暗物质数量
		 * @param type 物品类型
		 * @param callBack  返回函数
		 * 
		 */		
		public function groupDonate(legion_id:String,id:String,count:int,type:String,callBack:Function=null):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.groupDonate, packageViewResult))
				Protocol.registerProtocol(CommandEnum.groupDonate, packageViewResult);
			
			_packageViewViewCallBack = callBack;
			
			var playerID:String = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			var obj:Object = { player_id: playerID,legion_id:legion_id, id:id,count:count,type:type};
			ConnDebug.send(CommandEnum.groupDonate, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}
		
		
		/**
		 *图纸学习  道具使用
		 * @param id
		 * @param callBack
		 * 
		 */		
        public function useItem(id:String, callBack:Function = null):void
		{
			_packageViewViewCallBack = callBack;
			if (!Protocol.hasProtocolFunction(CommandEnum.useItem, packageViewResult))
				Protocol.registerProtocol(CommandEnum.useItem, packageViewResult);
			
			var playerID:String = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			
			var obj:Object = {player_id:playerID, item_id: id };
			ConnDebug.send(CommandEnum.useItem, obj, ConnDebug.HTTP, URLRequestMethod.POST);
		}

        /**
         *销毁道具
         * @param id 道具ID
         * @param callBack
         *
         */
        public function destroyItem(id:String,item_type:String, callBack:Function = null):void
        {
			_packageViewViewCallBack = callBack;
            if (!Protocol.hasProtocolFunction(CommandEnum.destroyItem, packageViewResult))
                Protocol.registerProtocol(CommandEnum.destroyItem, packageViewResult);
			
			var playerID:String = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			
            var obj:Object = {player_id:playerID, item_id: id,item_type:item_type };
            ConnDebug.send(CommandEnum.destroyItem, obj, ConnDebug.HTTP, URLRequestMethod.POST);
        }
		
        /**
         *购买仓库空间
         * @param callBack
         *
         */
        public function addSpace(count:int, callBack:Function = null):void
        {
			_packageViewViewCallBack = callBack;
            if (!Protocol.hasProtocolFunction(CommandEnum.addSpace, packageViewResult))
                Protocol.registerProtocol(CommandEnum.addSpace, packageViewResult);
			
			var playerID:String = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			
            var obj:Object = {player_id:playerID, count: count };
            ConnDebug.send(CommandEnum.addSpace, obj, ConnDebug.HTTP, URLRequestMethod.POST);
        }
		
        /**
         *获取战车详细信息
         * @param id
         * @param callBack
         *
         */
        public function getChariotInfo(id:String, callBack:Function = null):void
        {
            _chariotInfoCallBack = callBack;
            if (!Protocol.hasProtocolFunction(CommandEnum.getChariotInfo, chariotResult))
                Protocol.registerProtocol(CommandEnum.getChariotInfo, chariotResult);

            var obj:Object = { chariot_id: id };
            ConnDebug.send(CommandEnum.getChariotInfo, obj, ConnDebug.HTTP, URLRequestMethod.POST);
        }

        private function chariotResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.getChariotInfo, chariotResult);

            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString(data.errors));
                return;
            }

            var objDic:Object = ObjectUtil.CreateDic(itemVOList, BaseItemVO.FIELD_ID);
            var itemVO:ZhanCheInfoVO = objDic[data.id];

            if (itemVO)
                setZhanCheInfo(itemVO, data);

            chakanVO = itemVO;

            if (_chariotInfoCallBack != null)
                _chariotInfoCallBack();
            _chariotInfoCallBack = null;
        }

        /**
         *获取挂件详细信息
         * @param id
         * @param callBack
         *
         */
        public function getTankPartInfo(id:String, callBack:Function = null):void
        {
            _getTankPartInfoCallBack = callBack;
            if (!Protocol.hasProtocolFunction(CommandEnum.getTankPartInfo, tankPartResult))
                Protocol.registerProtocol(CommandEnum.getTankPartInfo, tankPartResult);

            var obj:Object = { tank_part_id: id };
            ConnDebug.send(CommandEnum.getTankPartInfo, obj, ConnDebug.HTTP, URLRequestMethod.POST);
        }

        private function tankPartResult(data:Object):void
        {
            Protocol.deleteProtocolFunction(CommandEnum.getTankPartInfo, tankPartResult);

            if (data.hasOwnProperty("errors"))
            {
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString(data.errors));
                return;
            }

            var objDic:Object = ObjectUtil.CreateDic(itemVOList, BaseItemVO.FIELD_ID);
            var itemVO:GuaJianInfoVO = objDic[data.id];

            if (itemVO)
                setGuaJianInfo(itemVO, data);

            chakanVO = itemVO;

            if (_getTankPartInfoCallBack != null)
                _getTankPartInfoCallBack();
            _getTankPartInfoCallBack = null;
        }

        /******************************************************
         *
         * 功能方法
         *
         * ****************************************************/

        public function createZhanCheVO(obj:Object):ZhanCheInfoVO
        {
            var itemVO:ZhanCheInfoVO = new ZhanCheInfoVO();

            itemVO.id = obj.id;
            itemVO.item_type = obj.item_type;
            itemVO.category = obj.category;
            itemVO.enhanced = obj.enhanced;
            itemVO.type = obj.type;
            setBaseItemName(itemVO, packageXML);

            var contentProxy:ContentProxy = getProxy(ContentProxy);
            if (contentProxy.contentData.chariots[itemVO.category] &&
                contentProxy.contentData.chariots[itemVO.category][itemVO.enhanced] &&
                contentProxy.contentData.chariots[itemVO.category][itemVO.enhanced][itemVO.type])
            {
                var cObj:Object = contentProxy.contentData.chariots[itemVO.category][itemVO.enhanced][itemVO.type];

                itemVO.time = cObj.cost.time;
                itemVO.crystal = cObj.cost.crystal;
                itemVO.tritium = cObj.cost.tritium;
                itemVO.broken_crystal = cObj.cost.broken_crystal;
                itemVO.dark_crystal = cObj.cost.dark_crystal;

                itemVO.value = cObj.property.value;
                itemVO.level = cObj.property.level;
                itemVO.attack_speed = cObj.property.attack_speed;
                itemVO.search_area = cObj.property.search_area;
                itemVO.attack_area = cObj.property.attack_area;
                itemVO.endurance = cObj.property.endurance;
                itemVO.weight = cObj.property.weight;
                itemVO.energy = cObj.property.energy;
                itemVO.speed = cObj.property.speed;
                itemVO.big_slot = cObj.property.big_slot;
                itemVO.medium_slot = cObj.property.medium_slot;
                itemVO.small_slot = cObj.property.small_slot;
                itemVO.age_level = cObj.property.age_level;

                itemVO.max_attack_speed = cObj.improve_property.max_attack_speed;
                itemVO.max_search_area = cObj.improve_property.max_search_area;
                itemVO.max_attack_area = cObj.improve_property.max_attack_area;
                itemVO.max_endurance = cObj.improve_property.max_endurance;
                itemVO.max_weight = cObj.improve_property.max_weight;
                itemVO.max_energy = cObj.improve_property.max_energy;
                itemVO.max_speed = cObj.improve_property.max_speed;
                itemVO.attack_speed_inc = cObj.improve_property.attack_speed_inc;
                itemVO.search_area_inc = cObj.improve_property.search_area_inc;
                itemVO.attack_area_inc = cObj.improve_property.attack_area_inc;
                itemVO.endurance_inc = cObj.improve_property.endurance_inc;
                itemVO.weight_inc = cObj.improve_property.weight_inc;
                itemVO.energy_inc = cObj.improve_property.energy_inc;
                itemVO.speed_inc = cObj.improve_property.speed_inc;
            }
            return itemVO;
        }

        public function setBaseItemName(itemVO:BaseItemVO, rootXML:XML):void
        {
            var xml:XML;
            if (rootXML == packageXML)
                xml = rootXML.fight.(category == itemVO.category && enhanced == itemVO.enhanced && type == itemVO.type)[0];
            else if (rootXML == tuZhiXML)
            {
                xml = rootXML.recipes.(category == itemVO.category && enhanced == itemVO.enhanced && type == itemVO.type)[0];

                if (xml != null)
                    (itemVO as ItemVO).description = xml.des;
            }

            if (xml != null)
                itemVO.name = xml.name;
        }

        public function createGuaJianVO(obj:Object):GuaJianInfoVO
        {
            var guaJianInfoVO:GuaJianInfoVO = new GuaJianInfoVO();

            guaJianInfoVO.id = obj.id;
            guaJianInfoVO.item_type = obj.item_type;
            guaJianInfoVO.category = obj.category;
            guaJianInfoVO.enhanced = obj.enhanced;
            guaJianInfoVO.type = obj.type;
            setBaseItemName(guaJianInfoVO, packageXML);

            var contentProxy:ContentProxy = getProxy(ContentProxy);
            if (contentProxy.contentData.tank_parts[guaJianInfoVO.category] &&
                contentProxy.contentData.tank_parts[guaJianInfoVO.category][guaJianInfoVO.enhanced] &&
                contentProxy.contentData.tank_parts[guaJianInfoVO.category][guaJianInfoVO.enhanced][guaJianInfoVO.type])
            {
                var cObj:Object = contentProxy.contentData.tank_parts[guaJianInfoVO.category][guaJianInfoVO.enhanced][guaJianInfoVO.type];

                guaJianInfoVO.time = cObj.cost.time;
                guaJianInfoVO.crystal = cObj.cost.crystal;
                guaJianInfoVO.tritium = cObj.cost.tritium;
                guaJianInfoVO.broken_crystal = cObj.cost.broken_crystal;
                guaJianInfoVO.dark_crystal = cObj.cost.dark_crystal;

                guaJianInfoVO.caliber = cObj.property.caliber;
                guaJianInfoVO.value = cObj.property.value;
                guaJianInfoVO.level = cObj.property.level;
                guaJianInfoVO.slot_type = cObj.property.slot_type;
                guaJianInfoVO.attack_type = cObj.property.attack_type;
                guaJianInfoVO.attack = cObj.property.attack;
                guaJianInfoVO.attack_cool_down = cObj.property.attack_cool_down;
                guaJianInfoVO.energy = cObj.property.energy;
                guaJianInfoVO.explode_area = cObj.property.explode_area;
                guaJianInfoVO.sort = cObj.property.sort;
                guaJianInfoVO.endurance = cObj.property.endurance;
                guaJianInfoVO.damage_desc_type = cObj.property.damage_desc_type;
                guaJianInfoVO.damage_desc = cObj.property.damage_desc;
            }
            return guaJianInfoVO;
        }

        public function createTuZhiVO(obj:Object):ItemVO
        {
            var itemInfoVO:ItemVO = new ItemVO();

            itemInfoVO.id = obj.id;
            itemInfoVO.item_type = obj.item_type;
            itemInfoVO.category = obj.category;
            itemInfoVO.enhanced = obj.enhanced;
            itemInfoVO.type = obj.type;
            itemInfoVO.recipe_type = obj.recipe_type;
            setBaseItemName(itemInfoVO, tuZhiXML);

			//获取科技需求
            var contentProxy:ContentProxy = getProxy(ContentProxy);
			var techProxy:ScienceResearchProxy=getProxy(ScienceResearchProxy);
			var techDicObj:Object=ObjectUtil.CreateDic(techProxy.reaearchList,ScienceResearchVO.FIELD_SCIENCE_TYPE);
			
            var key:String = StringUtil.formatString("{0}:{1}:{2}:{3}", itemInfoVO.recipe_type, itemInfoVO.category, itemInfoVO.enhanced, itemInfoVO.type);
            if (contentProxy.contentData.recipes[key])
            {
                var cObj:Object = contentProxy.contentData.recipes[key];

                var techVO:ScienceResearchVO;
				var hasTechVO:ScienceResearchVO;
                for (var i:int = 0; i < cObj.conditions.length; i++)
                {
					techVO=contentProxy.getScienceResearchInfo(cObj.conditions[i].science_type, cObj.conditions[i].science_level);
					hasTechVO=techDicObj[techVO.science_type];
					
					if(hasTechVO)
						techVO.currentLevel=hasTechVO.level;
					
                    itemInfoVO.techVOList.push(techVO);
                }
            }
			itemInfoVO.createTechPropertyDes();
			
			//获取要生产的挂件或战车信息
            var obj:Object;
            obj = new Object();
            obj.category = itemInfoVO.category;
            obj.enhanced = itemInfoVO.enhanced;
            obj.type = itemInfoVO.type;

            if (itemInfoVO.recipe_type == 1)
            {
                //战车
                obj.item_type = ItemEnum.Chariot;
                itemInfoVO.zhanCheVO = createZhanCheVO(obj);
                itemInfoVO.zhanCheVO.createPropertyDes();
            }
            else if (itemInfoVO.recipe_type == 2)
            {
                //挂件
                obj.item_type = ItemEnum.TankPart;
                itemInfoVO.guaJianVO = createGuaJianVO(obj);
                itemInfoVO.guaJianVO.createPropertyDes();
            }

            return itemInfoVO;
        }

        public function createDaoJuVO(obj:Object):ItemVO
        {
            var itemInfoVO:ItemVO = new ItemVO();

            itemInfoVO.id = obj.id;
            itemInfoVO.item_type = obj.item_type;
            itemInfoVO.category = obj.category;

            var contentProxy:ContentProxy = getProxy(ContentProxy);
            if (contentProxy.contentData.items[itemInfoVO.category])
            {
                var cObj:Object = contentProxy.contentData.items[itemInfoVO.category];

                itemInfoVO.key = cObj.key;
                itemInfoVO.name = cObj.name;
                itemInfoVO.description = cObj.description;
            }

            return itemInfoVO;
        }

        /**
         *设置战车详细信息
         * @param itemVO
         * @param obj
         *
         */
        public function setZhanCheInfo(itemVO:ZhanCheInfoVO, obj:Object):void
        {
            itemVO.player_id = obj.player_id;
            itemVO.level = obj.level;
            itemVO.value = obj.value;
            itemVO.vice_slot = obj.vice_slot;
            itemVO.medium_slot = obj.medium_slot;
            itemVO.small_slot = obj.small_slot;
            itemVO.total_attack_speed = obj.total_attack_speed;
            itemVO.total_search_area = obj.total_search_area;
            itemVO.total_attack_area = obj.total_attack_area;
            itemVO.total_endurance = obj.total_endurance;
            itemVO.total_weight = obj.total_weight;
            itemVO.total_energy = obj.total_energy;
            itemVO.total_shield = obj.total_shield;
            itemVO.total_speed = obj.total_speed;
            itemVO.current_endurance = obj.current_endurance;
            itemVO.current_repair_speed = obj.current_repair_speed;
            itemVO.energy_in_use = obj.energy_in_use;
            itemVO.recycle_price_broken_crystal = obj.recycle_price.broken_crystal;
            itemVO.repair_cost_broken_crystal = obj.repair_cost.broken_crystal;

            var guaJianVO:GuaJianInfoVO;

            for (var i:int = 0; i < obj.slots.length; i++)
            {
                guaJianVO = new GuaJianInfoVO();
                setGuaJianInfo(guaJianVO, obj.slots[i]);
                itemVO.guaJianItemVOList.push(guaJianVO);
            }

            CalculateUtil.zhanChe(itemVO);
        }

        /**
         *设置挂件信息
         * @param obj
         * @return
         *
         */
        public function setGuaJianInfo(itemVO:GuaJianInfoVO, obj:Object):void
        {
            itemVO.id = obj.id;
            itemVO.enhanced = obj.enhanced;
            itemVO.type = obj.type;
            itemVO.player_id = obj.player_id;
            itemVO.level = obj.level;
            itemVO.value = obj.value;
            itemVO.slot_type = obj.slot_type;
            itemVO.energy = obj.energy;
            itemVO.weight = obj.weight;
            itemVO.attack_type = obj.attack_type;
            itemVO.attack_cool_down = obj.attack_cool_down;
            itemVO.explode_area = obj.explode_area;
            itemVO.attack = obj.attack;
            itemVO.damage_desc_type = obj.damage_desc_type;
            itemVO.damage_desc = obj.damage_desc;
            itemVO.endurance = obj.endurance;
            itemVO.energy_supply = obj.energy_supply;
            itemVO.speed = obj.speed;
            itemVO.repair_speed = obj.repair_speed;
            itemVO.area = obj.area;
            itemVO.attack_speed = obj.attack_speed;
            itemVO.attack_area = obj.attack_area;
            itemVO.dark_matter_value = obj.dark_matter_value;
            itemVO.chariot_id = obj.chariot_id;
            itemVO.is_mounted = obj.is_mounted;
            itemVO.disable = obj.disable;
            itemVO.shield = obj.shield;

            itemVO.createPropertyDes();
        }
    }
}
