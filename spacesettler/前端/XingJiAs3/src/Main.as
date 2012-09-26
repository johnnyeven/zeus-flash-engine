package
{
    import com.zn.ResLoader;
    import com.zn.utils.BitmapUtil;
    import com.zn.utils.ClassUtil;
    
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.net.registerClassAlias;
    import flash.system.Security;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import flash.ui.MouseCursorData;
    
    import other.DebugInfo;
    import other.RegisterClass;
    
    import ui.components.Alert;
    import ui.managers.SystemManager;
    import ui.managers.ToolTipManager;

    [SWF(width = "1067", height = "600")]
    public class Main extends SystemManager
    {
		public static var debug:Boolean = true;
		
        private var _facade:ApplicationFacade;
		
        public function Main()
        {
         	super();  
			
			Security.allowDomain("*");
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
			
			setMouseCursor(1);
		}
		
		public static function setMouseCursor(camp:int):void
		{
			var mouseData:MouseCursorData=new MouseCursorData();
			mouseData.data=new Vector.<BitmapData>();
			mouseData.data.push(BitmapUtil.drawBitmapData(ClassUtil.getObject("cursor.Click")));
			Mouse.registerCursor(MouseCursor.BUTTON,mouseData);
			
			mouseData = new MouseCursorData();
			mouseData.data = new Vector.<BitmapData>();
			mouseData.data.push(BitmapUtil.drawBitmapData(ClassUtil.getObject("cursor.Camp"+camp)));
			Mouse.registerCursor(MouseCursor.ARROW, mouseData);
			
			Mouse.cursor=MouseCursor.ARROW;
		}
	}
}