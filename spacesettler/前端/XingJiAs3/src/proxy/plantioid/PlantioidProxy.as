package proxy.plantioid
{
    import com.zn.net.Protocol;
    import com.zn.utils.DateFormatter;
    
    import enum.command.CommandEnum;
    
    import flash.geom.Point;
    import flash.net.URLRequestMethod;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import other.ConnDebug;
    
    import vo.plantioid.FortsInforVO;

    /**
     *小行星带
     * @author zn
     *
     */
    public class PlantioidProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "PlantioidProxy";

        private var _getPlantioidListByXYCallBack:Function;

        /*
        小行星带列表
        value:FortsInforVO
        */
        [Bindable]
        public var plantioidList:Array = [];

		[Bindable]
        public var currentX:int = 0;

		[Bindable]
        public var currentY:int = 0;
		
		private var _tempPoint:Point;

        public function PlantioidProxy(data:Object = null)
        {
            super(NAME, data);

            Protocol.registerProtocol(CommandEnum.getPlantioidList, getPlantioidListByXYResult);
        }

        /**
         *获取小行星带
         * @param x
         * @param y
         * @param callBack
         *
         */
        public function getPlantioidListByXY(x:int, y:int, callBack:Function = null):void
        {
            _getPlantioidListByXYCallBack = callBack;

			_tempPoint=new Point(x,y);
            var obj:Object = { x: x, y: y };
            ConnDebug.send(CommandEnum.getPlantioidList, obj, ConnDebug.HTTP, URLRequestMethod.GET);
        }

        private function getPlantioidListByXYResult(data:*):void
        {
			currentX = _tempPoint.x;
			currentY = _tempPoint.y;
			
            var list:Array = [];
            var obj:Object;
            var fortVO:FortsInforVO;

            var currentTime:Number = data.current_time;

            for (var i:int = 0; i < data.forts.length; i++)
            {
                obj = data.forts[i];

                fortVO = new FortsInforVO();
                fortVO.id = obj.id;
                fortVO.level = obj.level;
                fortVO.z = obj.z;

                fortVO.x = currentX;
                fortVO.y = currentY;

                fortVO.protected_until = obj.protected_until;
                fortVO.protectedEndTime = DateFormatter.currentTime + (fortVO.protected_until - currentTime)*1000;
                fortVO.fort_type = obj.fort_type;
                fortVO.player_id = obj.player_id;
                fortVO.fort_name = obj.fort_name;
                fortVO.resources = obj.resources;
                fortVO.age_level = obj.age_level;
                fortVO.campID = obj.campID;
                fortVO.updateType();

                list.push(fortVO);
            }

            plantioidList = list;

            if (_getPlantioidListByXYCallBack != null)
                _getPlantioidListByXYCallBack();
            _getPlantioidListByXYCallBack = null;
        }

    /***********************************************************
     *
     * 功能方法
     *
     * ****************************************************/

    }
}
