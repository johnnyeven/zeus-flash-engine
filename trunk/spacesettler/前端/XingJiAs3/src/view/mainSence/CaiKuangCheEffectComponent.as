package view.mainSence
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.ClassUtil;
    
    import enum.BuildTypeEnum;
    
    import events.buildEvent.CaiKuangCheEffectEvent;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.geom.Point;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.BuildProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.core.Component;
    
    import vo.BuildInfoVo;
    import vo.userInfo.UserInfoVO;

    /**
     *采矿车特效
     * @author zn
     *
     */
    public class CaiKuangCheEffectComponent extends Component
    {
        public static const OUT:String = "out";

        public static const CAI:String = "cai";

        public static const BACK:String = "back";

        public var count:int = 0;

        public var che_1:MovieClip;

        public var che_2:MovieClip;

        public var che_3:MovieClip;

        public var che_4:MovieClip;

        public var che_5:MovieClip;

        public var tweenLiteDic:Object = {};

        public var oldPoint:Point;

        public var che_1_old_point:Point;

        public var che_1_cai_point:Point;

        public var che_1_back_point:Point;
		
		public var time1:int=3;
		
		public var che_2_old_point:Point;
		
		public var che_2_cai_point:Point;
		
		public var che_2_back_point:Point;
		
		public var time2:int=4;

		public var che_3_old_point:Point;
		
		public var che_3_cai_point:Point;
		
		public var che_3_back_point:Point;
		public var time3:int=5;
		
		public var che_4_old_point:Point;
		
		public var che_4_cai_point:Point;
		
		public var che_4_back_point:Point;
		public var time4:int=4.5;
		
		public var che_5_old_point:Point;
		
		public var che_5_cai_point:Point;
		
		public var che_5_back_point:Point;
		public var time5:int=3;
		
        public var backCount:int;

        public function CaiKuangCheEffectComponent()
        {
            super(null);
			
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
        }
		
		protected function addToStageHandler(event:Event):void
		{
			init();			
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			for each (var tweenLite:TweenLite in tweenLiteDic) 
			{
				tweenLite.kill();
			}
			tweenLiteDic=null;
		}


        public function init():void
        {
            che_1_old_point = globalToLocal(new Point(315, 498));
            che_1_cai_point = globalToLocal(new Point(315, 562));
            che_1_back_point = globalToLocal(new Point(315, 498));

			che_2_old_point = globalToLocal(new Point(300, 466));
			che_2_cai_point = globalToLocal(new Point(237, 551));
			che_2_back_point = globalToLocal(new Point(290, 488));
			
			che_3_old_point = globalToLocal(new Point(291, 477));
			che_3_cai_point = globalToLocal(new Point(163, 542));
			che_3_back_point = globalToLocal(new Point(279, 483));
			
			che_4_old_point = globalToLocal(new Point(285, 472));
			che_4_cai_point = globalToLocal(new Point(159, 500));
			che_4_back_point = globalToLocal(new Point(273, 477));
			
			che_4_old_point = globalToLocal(new Point(285, 472));
			che_4_cai_point = globalToLocal(new Point(159, 500));
			che_4_back_point = globalToLocal(new Point(273, 477));
			
			che_5_old_point = globalToLocal(new Point(276, 464));
			che_5_cai_point = globalToLocal(new Point(152, 448));
			che_5_back_point = globalToLocal(new Point(272, 479));
			
            var buildVo:BuildInfoVo = BuildProxy(ApplicationFacade.getProxy(BuildProxy)).getBuild(BuildTypeEnum.KUANGCHANG);
            cwList.push(BindingUtils.bindSetter(levelChange, buildVo, "level"));
        }

        private function levelChange(value:*):void
        {
			if(value>4)
				value=4;
			
			var userInfoVO:UserInfoVO=UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			
            switch (value)
            {
//				case 5:
//				{
//					if (che_5 == null)
//					{
//						che_5 = ClassUtil.getObject("sence"+userInfoVO.camp+".caiKuangChe_5");
//						che_5.gotoAndStop(OUT);
//						che_5.x = che_5_old_point.x;
//						che_5.y = che_5_old_point.y;
//						tweenLiteDic[5] = TweenLite.to(che_5, time5, { x:che_5_cai_point.x, y: che_5_cai_point.y, ease: Linear.easeNone, onComplete: outComplete, onCompleteParams: [ che_5 ]});
//						addChild(che_5);
//					}
//				}
				case 4:
				{
					if (che_4 == null)
					{
						che_4 = ClassUtil.getObject("sence"+userInfoVO.camp+".caiKuangChe_4");
						che_4.gotoAndStop(OUT);
						che_4.x = che_4_old_point.x;
						che_4.y = che_4_old_point.y;
						tweenLiteDic[4] = TweenLite.to(che_4, time4, { x: che_4_cai_point.x, y: che_4_cai_point.y, ease: Linear.easeNone, onComplete: outComplete, onCompleteParams: [ che_4 ]});
						addChild(che_4);
					}
				}
				case 3:
				{
					if (che_3 == null)
					{
						che_3 = ClassUtil.getObject("sence"+userInfoVO.camp+".caiKuangChe_3");
						che_3.gotoAndStop(OUT);
						che_3.x = che_3_old_point.x;
						che_3.y = che_3_old_point.y;
						tweenLiteDic[3] = TweenLite.to(che_3, time3, { x:che_3_cai_point.x, y: che_3_cai_point.y, ease: Linear.easeNone, onComplete: outComplete, onCompleteParams: [ che_3 ]});
						addChild(che_3);
					}
				}
				case 2:
				{
					if (che_2 == null)
					{
						che_2 = ClassUtil.getObject("sence"+userInfoVO.camp+".caiKuangChe_2");
						che_2.gotoAndStop(OUT);
						che_2.x = che_2_old_point.x;
						che_2.y = che_2_old_point.y;
						tweenLiteDic[2] = TweenLite.to(che_2, time2, { x:che_2_cai_point.x, y: che_2_cai_point.y, ease: Linear.easeNone, onComplete: outComplete, onCompleteParams: [ che_2 ]});
						addChild(che_2);
					}
				}
                case 1:
                {
                    if (che_1 == null)
                    {
                        che_1 = ClassUtil.getObject("sence"+userInfoVO.camp+".caiKuangChe_1");
                        che_1.gotoAndStop(OUT);
                        che_1.x = che_1_old_point.x;
                        che_1.y = che_1_old_point.y;
                        tweenLiteDic[1] = TweenLite.to(che_1, time1, { x: che_1_cai_point.x, y: che_1_cai_point.y, ease: Linear.easeNone, onComplete: outComplete, onCompleteParams: [ che_1 ]});
                        addChild(che_1);
                    }
                }
            }
			
			if(che_5)
				addChild(che_5);
			if(che_4)
				addChild(che_4);
			if(che_3)
				addChild(che_3);
			if(che_2)
				addChild(che_2);
			if(che_1)
				addChild(che_1);
        }

        private function outComplete(che:MovieClip):void
        {
            che.gotoAndStop(CAI);

            var p:Point;
			var time:int;
            timeout(function():void
            {
                che.gotoAndStop(BACK);
                switch (che)
                {
                    case che_1:
                    {
                        p = che_1_back_point;
						time=time1;
                        break;
                    }
					case che_2:
					{
						p = che_2_back_point;
						time=time2;
						break;
					}
					case che_3:
					{
						p = che_3_back_point;
						time=time3;
						break;
					}
					case che_4:
					{
						p = che_4_back_point;
						time=time4;
						break;
					}
					case che_5:
					{
						p = che_5_back_point;
						time=time5;
						break;
					}
                }
                tweenLiteDic[1] = TweenLite.to(che, time, { x: p.x, y: p.y, ease: Linear.easeNone, onComplete: backComplete, onCompleteParams: [ che ]});
            }, 2000);
        }

        private function backComplete(che:MovieClip):void
        {
            var p:Point;
			var time:int;
            timeout(function():void
            {
                che.gotoAndStop(OUT);
                switch (che)
                {
                    case che_1:
                    {
                        p = che_1_cai_point;
						time=time1;
                        break;
                    }
                    case che_2:
                    {
                        p = che_2_cai_point;
						time=time2;
                        break;
                    }
                    case che_3:
                    {
                        p = che_3_cai_point;
						time=time3;
						time=3;
                        break;
                    }
                    case che_4:
                    {
                        p = che_4_cai_point;
						time=time4;
                        break;
                    }
                    case che_5:
                    {
                        p = che_5_cai_point;
						time=time5;
                        break;
                    }
                }
                tweenLiteDic[1] = TweenLite.to(che, time, { x: p.x, y: p.y, ease: Linear.easeNone, onComplete: outComplete, onCompleteParams: [ che ]});

				backCount=Math.max(0,--backCount);
                dispatchEvent(new Event(CaiKuangCheEffectEvent.OUT_EVENT));
            }, 2000);
			backCount++;
            dispatchEvent(new Event(CaiKuangCheEffectEvent.BACK_EVENT));
        }
    }
}
