package view.mainSence
{
    import com.zn.utils.ClassUtil;
    
    import enum.MainSenceEnum;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import proxy.BuildProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.components.LoaderImage;
    import ui.core.Component;
    
    import vo.BuildInfoVo;

    /**
     *主场景
     * @author zn
     *
     */
    public class MainSenceComponent extends Component
    {
        private var _userInfoProxy:UserInfoProxy;

        public var xingQiuSp:Sprite;
		public var puBuSp:Sprite;
		public var dengGuangSp:Sprite;
		public var guanDaoSp:Sprite;
		
		public var jiDiSp:Sprite;
		public var chuanQinSp:Sprite;
		public var anNengDianChangSp:Sprite;
		public var cangKuSp:Sprite;
		public var kuangChangSp:Sprite;
		public var keJiSp:Sprite;
		public var junGongChangSp:Sprite;
		public var shiJianJiQiSp:Sprite;

        public var xingQiuLoaderImage:LoaderImage;
		public var puBuLoaderImage:LoaderImage;
		public var dengGuangLoaderImage:LoaderImage;
		public var guanDaoLoaderImage:LoaderImage;
		
		
		private var _arr:Array=[];
        public function MainSenceComponent()
        {
            _userInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
            super(ClassUtil.getObject("MainSence_" + _userInfoProxy.userInfoVO.camp));

            xingQiuSp = getSkin("xingQiuSp");
			puBuSp=getSkin("puBuSp");
			dengGuangSp=getSkin("dengGuangSp");
			guanDaoSp=getSkin("guanDaoSp");
			
			jiDiSp=getSkin("sprite_1");
			chuanQinSp=getSkin("sprite_2");
			anNengDianChangSp=getSkin("sprite_3");
			cangKuSp=getSkin("sprite_4");
			kuangChangSp=getSkin("sprite_5");
			keJiSp=getSkin("sprite_6");
			junGongChangSp=getSkin("sprite_7");
			shiJianJiQiSp=getSkin("sprite_8");

            sortChildIndex();

            xingQiuLoaderImage = new LoaderImage();
            xingQiuLoaderImage.source = MainSenceEnum.xingQiuURL;
            xingQiuSp.addChild(xingQiuLoaderImage);
			
			puBuLoaderImage=new LoaderImage();
			puBuLoaderImage.source=MainSenceEnum.puBuURL;
			puBuSp.addChild(puBuLoaderImage);
			
			dengGuangLoaderImage=new LoaderImage();
			dengGuangLoaderImage.source=MainSenceEnum.dengGuangURL;
			dengGuangSp.addChild(dengGuangLoaderImage);
			
			guanDaoLoaderImage=new LoaderImage();
			guanDaoLoaderImage.source=MainSenceEnum.guanDaoURL;
			guanDaoSp.addChild(guanDaoLoaderImage);
			
			setSprite();
        }
		
		private function addMouseClick(sp:Sprite):void
		{
			sp.addEventListener(MouseEvent.CLICK,doClickHandler);	
		}
		
		protected function doClickHandler(event:MouseEvent):void
		{
			var sp:Sprite=event.target as Sprite;
			if(sp==jiDiSp)
			{
				
			}
		}
		
		private function setSprite():void
		{
			var buildInfoProxy:BuildProxy=ApplicationFacade.getProxy(BuildProxy);
			var length:int=buildInfoProxy.buildArr.length;
			for(var i:int;i<length;i++)
			{
				var buildInfoVo:BuildInfoVo=buildInfoProxy.buildArr[i];
				var buildComp:BuildComponent=new BuildComponent();
				buildComp.buildInfoVo=buildInfoVo;
				
				if(buildInfoVo.type==1)
				{
					jiDiSp.addChild(buildComp);
					addMouseClick(jiDiSp);
					_arr[1]=buildComp;
				}
				else if(buildInfoVo.type==2)
				{
					chuanQinSp.addChild(buildComp);	
					addMouseClick(chuanQinSp);
					_arr[2]=buildComp;
				}
				else if(buildInfoVo.type==3)
				{
					anNengDianChangSp.addChild(buildComp);	
					addMouseClick(anNengDianChangSp);
					_arr[3]=buildComp;
				}
				else if(buildInfoVo.type==4)
				{
					cangKuSp.addChild(buildComp);	
					addMouseClick(cangKuSp);
					_arr[4]=buildComp;
				}
				else if(buildInfoVo.type==5)
				{
					kuangChangSp.addChild(buildComp);	
					addMouseClick(kuangChangSp);
					_arr[5]=buildComp;
				}
				else if(buildInfoVo.type==6)
				{
					keJiSp.addChild(buildComp);	
					addMouseClick(keJiSp);
					_arr[6]=buildComp;
				}
				else if(buildInfoVo.type==7)
				{
					junGongChangSp.addChild(buildComp);	
					addMouseClick(junGongChangSp);
					_arr[7]=buildComp;
				}
				else if(buildInfoVo.type==8)
				{
					shiJianJiQiSp.addChild(buildComp);	
					addMouseClick(shiJianJiQiSp);
					_arr[8]=buildComp;
				}
				
			}

			
		}
    }
}
