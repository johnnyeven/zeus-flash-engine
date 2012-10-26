package mediator.cangKu
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.factory.FactoryEnum;
    import enum.item.ItemEnum;
    
    import events.buildingView.AddViewEvent;
    import events.cangKu.ChaKanEvent;
    import events.cangKu.DonateEvent;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    import mediator.factory.FactoryChangeComponentMediator;
    import mediator.factory.FactoryMakeAndServiceComponentMediator;
    import mediator.factory.FactoryStrengthenComponentMediator;
    import mediator.prompt.PromptSureMediator;
    
    import mx.binding.utils.ChangeWatcher;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.group.GroupProxy;
    import proxy.packageView.PackageViewProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import view.cangKu.CangkuPackageViewComponent;
    import view.factory.FactoryMakeAndServiceComponent;
    
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.GuaJianInfoVO;
    import vo.cangKu.ItemVO;
    import vo.cangKu.ZhanCheInfoVO;

    /**
     *模板
     * @author zn
     *
     */
    public class CangkuPackageViewComponentMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "CangkuPackageViewComponentMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";
		
        public static const UPDATA_LIST:String = "updata_list";
		
		private var packageProxy:PackageViewProxy;
		private var userProxy:UserInfoProxy;
		private var groupProxy:GroupProxy;
        public function CangkuPackageViewComponentMediator()
        {
            super(NAME, new CangkuPackageViewComponent(ClassUtil.getObject("cangKuPackage_view")));
			
			packageProxy=getProxy(PackageViewProxy);
			groupProxy=getProxy(GroupProxy);
			userProxy=getProxy(UserInfoProxy);
			if(!groupProxy.groupInfoVo)
				groupProxy.refreshGroup();
			
            comp.med = this;
            level = 1;
            comp.addEventListener(AddViewEvent.CLOSE_EVENT, closeHandler);
            comp.addEventListener(ChaKanEvent.ADDCHAKANVIEW_EVENT, addChaKanViewHandler);
            comp.addEventListener(ChaKanEvent.ZHUANGPEI_EVENT, zhuangPeiHandler);
            comp.addEventListener(ChaKanEvent.WEIXIU_EVENT, weiXiuHandler);
            comp.addEventListener(ChaKanEvent.QIANGHUA_EVENT, qiangHuaHandler);
            comp.addEventListener(DonateEvent.DONATE_EVENT, addDonateViewHandler);
            comp.addEventListener(DonateEvent.DESTROY_EVENT, destroyHandler);
            comp.addEventListener(DonateEvent.USE_EVENT, useHandler);
            comp.addEventListener(DonateEvent.ADDSPACE_EVENT, addSpaceHandler);
        }
		
        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ DESTROY_NOTE,UPDATA_LIST];
        }

        /**
         *消息处理
         * @param note
         *
         */
        override public function handleNotification(note:INotification):void
        {
            switch (note.getName())
            {
                case DESTROY_NOTE:
                {
                    //销毁对象
                    destroy();
                    break;
                }
                case UPDATA_LIST:
                {
					comp.itemVOListChange(packageProxy.itemVOList);
                    break;
                }
            }
        }

        /**
         *获取界面
         * @return
         *
         */
        protected function get comp():CangkuPackageViewComponent
        {
            return viewComponent as CangkuPackageViewComponent;
        }

        protected function closeHandler(event:AddViewEvent):void
        {
            sendNotification(DESTROY_NOTE);
        }

        protected function addChaKanViewHandler(event:ChaKanEvent):void
        {
            var packageProxy:PackageViewProxy =getProxy(PackageViewProxy);
            if (event.itemVO.item_type == ItemEnum.Chariot)
            {
				packageProxy.getChariotInfo(event.itemVO.id, function():void
                {
                    sendNotification(ChaKanZhanCheViewComponentMediator.SHOW_NOTE);
                });
            }
            if (event.itemVO.item_type == ItemEnum.TankPart)
            {
				packageProxy.getTankPartInfo(event.itemVO.id, function():void
                {
					sendNotification(ChaKanGuaJianViewComponentMediator.SHOW_NOTE);
                });
            }
            if(event.itemVO.item_type == ItemEnum.recipes)
            {
				packageProxy.chakanVO=event.itemVO;
                sendNotification(ChaKanTuZhiViewComponentMediator.SHOW_NOTE);
            }
			if(event.itemVO.item_type == ItemEnum.item)
			{
				packageProxy.chakanVO=event.itemVO;
				sendNotification(ChaKanDaoJuViewComponentMediator.SHOW_NOTE);
			}
        }

        protected function addDonateViewHandler(event:DonateEvent):void
        {
			
			
			var obj:Object={};
			var selectedItemVO:BaseItemVO=event.tempInfo as BaseItemVO;
			var count:int;
			if(selectedItemVO.item_type==ItemEnum.Chariot)
			{
				var vo1:ZhanCheInfoVO=event.tempInfo as ZhanCheInfoVO;
				count=vo1.dark_matter_value;
			}else if(selectedItemVO.item_type==ItemEnum.TankPart)
			{
				var vo2:GuaJianInfoVO=event.tempInfo as GuaJianInfoVO;
				count=vo2.dark_matter_value;
			}
			
			obj.name=selectedItemVO.name;
			obj.count=count;
			obj.okCallBack=function():void
			{
				packageProxy.groupDonate(userProxy.userInfoVO.legion_id,selectedItemVO.id,count,
										selectedItemVO.item_type,function():void
										{
											var obj1:Object={};
											obj1.infoLable=MultilanguageManager.getString("juanxian");
											obj1.showLable=MultilanguageManager.getString("juanxianchenggong");
											sendNotification(PromptSureMediator.SHOW_NOTE,obj1);
											
										});
				
			}
			
            sendNotification(DonateViewComponentMediator.SHOW_NOTE, obj);
        }
        protected function destroyHandler(event:DonateEvent):void
		{
			var selectedItemVO:BaseItemVO=event.tempInfo as BaseItemVO;
			var obj:Object={};
			obj.infoLable=MultilanguageManager.getString("destroyItem");
			obj.showLable=MultilanguageManager.getString("destroyIteminfo");
			obj.okCallBack=function():void
			{
				packageProxy.destroyItem(selectedItemVO.id,selectedItemVO.item_type);
			}
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
		
		protected function useHandler(event:DonateEvent):void
		{
			var itemVo:BaseItemVO=event.tempInfo as BaseItemVO;
			packageProxy.useItem(itemVo.id,function():void
			{
				var obj:Object={};
				obj.showLable=MultilanguageManager.getString("useItem");
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			});			
		}
		
		protected function addSpaceHandler(event:DonateEvent):void
		{
			packageProxy.addSpace(ItemEnum.count,function():void
			{
				var obj:Object={};
				obj.showLable=MultilanguageManager.getString("addItem");
				sendNotification(PromptSureMediator.SHOW_NOTE,obj);
			});
		}	
		
		
		protected function qiangHuaHandler(event:ChaKanEvent):void
		{
			packageProxy.getChariotInfo(event.itemVO.id, function():void
			{
				sendNotification(FactoryStrengthenComponentMediator.SHOW_NOTE);
			});
		}
		
		protected function weiXiuHandler(event:ChaKanEvent):void
		{
			packageProxy.getChariotInfo(event.itemVO.id, function():void
			{
				var obj:Object={};
				obj.type=FactoryEnum.WEIXIU_FACTORY;
				sendNotification(FactoryMakeAndServiceComponentMediator.SHOW_NOTE,obj);
			});
		}
		
		protected function zhuangPeiHandler(event:ChaKanEvent):void
		{
			packageProxy.getChariotInfo(event.itemVO.id, function():void
			{
				sendNotification(FactoryChangeComponentMediator.SHOW_NOTE);
			});
		}		
		
		
		
    }
}
