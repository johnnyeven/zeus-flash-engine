package mediator.loader
{
    import com.greensock.TweenLite;
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    
    import flash.display.DisplayObject;
    
    import mediator.BaseMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    import ui.managers.PopUpManager;
    import ui.utils.UIUtil;
    
    import view.loader.LoaderBarComponent;

    /**
     *加载界面
     * @author zn
     *
     */
    public class LoaderBarMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "LoaderBarMediator";

        private var _title:String;
        public function LoaderBarMediator()
        {
            super(NAME,new LoaderBarComponent());
        }

        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ ResLoader.SHOW_LOADER_BAR_NOTE,
                     ResLoader.HIDE_LOADER_BAR_NOTE,
                     ResLoader.SET_LOADER_BAR_PROGRESS_NOTE,
                     ResLoader.SET_LOADER_BAR_TITLE_NOTE,
					 ResLoader.LOADER_ERROR_NOTE];
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
                case ResLoader.SHOW_LOADER_BAR_NOTE:
                {
                    //显示加载条
                    showLoaderBar();
                    break;
                }
                case ResLoader.HIDE_LOADER_BAR_NOTE:
                {
                    //隐藏加载条
                    hideLoaderBar();
                    break;
                }
                case ResLoader.SET_LOADER_BAR_PROGRESS_NOTE:
                {
                    //设置加载进度
                    setLoaderProgress(note);
                    break;
                }
                case ResLoader.SET_LOADER_BAR_TITLE_NOTE:
                {
                    //设置加载标题
                    setLoaderTitle(String(note.getBody()));
                    break;
                }
				case ResLoader.LOADER_ERROR_NOTE:
				{
					//加载错误
					break;
				}
            }
        }

        /**
         *设置加载标题
         * @param param0
         *
         */
        private function setLoaderTitle(title:String):void
        {
			_title=title;
            comp.titleInfo=title;
        }

        /**
         *显示加载条
         * @return
         *
         */
        private function showLoaderBar():void
        {
			(comp as DisplayObject).alpha=0.2;
            PopUpManager.addPopUp(comp as DisplayObject, true);
            UIUtil.centerUI(comp as DisplayObject);
			TweenLite.to(comp as DisplayObject,1,{alpha:1});
        }

        /**
         *隐藏加载条
         *
         */
        private function hideLoaderBar():void
        {
            PopUpManager.removePopUp(comp as DisplayObject);
            clean();
        }


        /**
         *设置加载进度
         * @param note
         *
         */
        private function setLoaderProgress(note:INotification):void
        {
			var event:LoaderEvent=note.getBody() as LoaderEvent;
            var percent:Number = Number(event.bytesLoaded/event.bytesTotal);
            comp.percent = percent;
			comp.titleInfo=_title+" "+event.index+"/"+event.total;
        }

        /**
         *清理数据
         *
         */
        private function clean():void
        {
            comp.percent = 0;
        }

        /**
         *获取界面
         * @return
         *
         */
        protected function get comp():LoaderBarComponent
        {
            return viewComponent as LoaderBarComponent;
        }
    }
}