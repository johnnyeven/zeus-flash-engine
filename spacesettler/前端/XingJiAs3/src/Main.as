package
{
    import com.zn.ResLoader;
    import flash.net.registerClassAlias;
    
    import other.DebugInfo;
    import other.RegisterClass;
    
    import ui.components.Alert;
    import ui.managers.SystemManager;
    import ui.managers.ToolTipManager;

    [SWF(width = "1067", height = "700", backgroundColor = "0xCCCCCC")]
    public class Main extends SystemManager
    {
		public static var debug:Boolean = true;
		
        private var _facade:ApplicationFacade;
		
        public function Main()
        {
         	super();  
        }
		
		public function start():void
		{
			initSet();
			
			_facade = ApplicationFacade.getInstance();
			ResLoader.faced = _facade;
			_facade.startup(this);
		}
		
		private function initSet():void
		{
            Alert.defaultAlertSkinClassName = "assets.skins.AlertSkin";
            ToolTipManager.defalutToolTipSkinClassName = "assets.skins.ToolTipSkin";
			new DebugInfo();
			RegisterClass.registerClass();
		}
	}
}