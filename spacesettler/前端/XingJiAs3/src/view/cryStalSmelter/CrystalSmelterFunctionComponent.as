package view.cryStalSmelter
{
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	
	import events.crystalSmelter.CrystalSmelterEvent;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.Window;
	import ui.core.Component;
	
	import utils.GlobalUtil;
	
	import vo.BuildInfoVo;
	
	/**
	 * 熔炼（晶体冶炼厂）
	 * @author lw
	 *
	 */
    public class CrystalSmelterFunctionComponent extends Window
    {
		public var levelLabel:Label;
		
		public var shuiJingOutPutLabel:Label;
		
		public var shuiJinngTotalLabel:Label;
		
		public var anWuZhiTotalLabel:Label;
		
		public var smeltBtn:Button;
		
		public var close_button:Button;
		
		public var info_button:Button;
		
        public function CrystalSmelterFunctionComponent()
        {
            super(ClassUtil.getObject("view.crystalSmelter.CrystalSmelterFunction"));
			
			levelLabel = createUI(Label,"levelLabel");
			shuiJingOutPutLabel = createUI(Label,"shuiJingOutPutLabel");
			shuiJinngTotalLabel = createUI(Label,"shuiJinngTotalLabel");
			anWuZhiTotalLabel = createUI(Label,"anWuZhiTotalLabel");
			
			smeltBtn = createUI(Button,"smeltBtn");
			close_button = createUI(Button,"close_button");
			info_button = createUI(Button,"info_button");
			
			sortChildIndex();
			
			removeCWList();
			
			var buildProxy:BuildProxy = ApplicationFacade.getProxy(BuildProxy);
			var buildInfoVO:BuildInfoVo = buildProxy.getBuild(BuildTypeEnum.KUANGCHANG);
			cwList.push(BindingUtils.bindProperty(levelLabel,"text",buildInfoVO,"level"));
			var userInforProxy:UserInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
			cwList.push(BindingUtils.bindSetter(shuiJingOutPutLabelChange,userInforProxy,["userInfoVO","crystal_output"]));
			cwList.push(BindingUtils.bindSetter(shuiJinngTotalLabelChange,userInforProxy,["userInfoVO","crystal"]));
			cwList.push(BindingUtils.bindSetter(anWuZhiTotalLabelChange,userInforProxy,["userInfoVO","broken_crysta"]));
			
			smeltBtn.addEventListener(MouseEvent.CLICK,smeltBtn_clickHAndler);
			close_button.addEventListener(MouseEvent.CLICK,closeButton_clickHAndler);
			info_button.addEventListener(MouseEvent.CLICK,infoBtn_clickHandler);
        }
		
		private function shuiJingOutPutLabelChange(value:*):void
		{
			shuiJingOutPutLabel.text=int(value).toString();
		}
		private function shuiJinngTotalLabelChange(value:*):void
		{
			GlobalUtil.resLabelChange(shuiJinngTotalLabel,value);
		}
		private function anWuZhiTotalLabelChange(value:*):void
		{
			GlobalUtil.resLabelChange(anWuZhiTotalLabel,value);
		}
		
		protected function infoBtn_clickHandler(event:MouseEvent):void
		{
		   dispatchEvent(new CrystalSmelterEvent(CrystalSmelterEvent.INFOR_EVENT));
		}
		
		protected function closeButton_clickHAndler(event:MouseEvent):void
		{
		   dispatchEvent(new CrystalSmelterEvent(CrystalSmelterEvent.CLOSE_EVENT));
		}
		
		protected function smeltBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new CrystalSmelterEvent(CrystalSmelterEvent.SMELTER_EVENT));
		}
	}
}