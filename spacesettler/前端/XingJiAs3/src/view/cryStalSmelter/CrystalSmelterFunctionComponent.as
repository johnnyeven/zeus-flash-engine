package view.cryStalSmelter
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Label;
	import ui.components.Window;
	import ui.core.Component;
	
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
		
		public var shuJingUseLabel:Label;
		
		public var anWuZhiOutPutLabel:Label;
		
        public function CrystalSmelterFunctionComponent()
        {
            super(ClassUtil.getObject("view.crystalSmelter.CrystalSmelterFunction"));
			
			levelLabel = createUI(Label,"levelLabel");
			shuiJingOutPutLabel = createUI(Label,"shuiJingOutPutLabel");
			shuiJinngTotalLabel = createUI(Label,"shuiJinngTotalLabel");
			anWuZhiTotalLabel = createUI(Label,"anWuZhiTotalLabel");
			shuJingUseLabel = createUI(Label,"shuJingUseLabel");
			anWuZhiOutPutLabel = createUI(Label,"anWuZhiOutPutLabel");
			
        }
    }
}