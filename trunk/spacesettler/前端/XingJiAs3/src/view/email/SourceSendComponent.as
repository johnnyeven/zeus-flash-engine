package view.email
{
	import com.zn.utils.ClassUtil;
	
	import flash.text.TextField;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	import vo.email.SourceItemVO;
	
	/**
	 *资源库存
	 * @author lw
	 *
	 */
    public class SourceSendComponent extends Window
    {
		public var closeBtn:Button;
		public var okBtn:Button;
		public var sourceImage:LoaderImage;
		public var countTxt:TextField;
		public var costLabel:Label;
		
		private var container:Container;
		private var userInforProxy:UserInfoProxy;
        public function SourceSendComponent()
        {
            super(ClassUtil.getObject("view.email.SourceSendSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			container = new Container(null);
			container.contentWidth = 312;
			container.contentHeight = 190;
			container.layout = new HTileLayout(container);
			container.x = 19;
			container.y = 45;
			addChild(container);
			
			closeBtn = createUI(Button,"closeBtn");
			okBtn = createUI(Button,"okBtn");
			sourceImage = createUI(LoaderImage,"sourceImage");
			countTxt = getSkin("countTxt");
			costLabel = createUI(Label,"costLabel");
			
			sortChildIndex();
			var arr:Array = [];
			var sourceItemVO1:SourceItemVO = new SourceItemVO();
//			    sourceItemVO1.attachment_type = userInforProxy.userInfoVO.
			var sourceItemVO2:SourceItemVO = new SourceItemVO();
			var sourceItemVO3:SourceItemVO = new SourceItemVO();
			arr.push(sourceItemVO1,sourceItemVO2,sourceItemVO3);
			setData(arr);
        }
		
		private function setData(data:Array):void
		{
			
		}
    }
}