package mediator
{
    import flash.events.Event;
    
    import org.puremvc.as3.interfaces.IMediator;

    /**
     *窗口
     * @author zn
     *
     */
    public class WindowMediator extends BaseMediator implements IMediator
    {
        public function WindowMediator(name:String, viewComponent:Object = null)
        {
            super(name, viewComponent);

            uiComp.addEventListener(Event.CLOSE, closeHandler);
        }

        protected function closeHandler(event:Event):void
        {
			sendNotification("destroy" + getMediatorName() + "Note");
        }

    }
}