package view.ranking
{
	import com.zn.utils.ClassUtil;
	
	import events.ranking.RankingEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.layouts.VTileLayout;
	
	/**
	 *PVP排行第一版面Item点击生成PVP单独的显示排行版面  
	 * @author Administrator
	 * 
	 */	
    public class rankingPvpComponent extends Component
    {
		public var sprite:Sprite;
		public var sprite2:Sprite;
		public var maskSp:Sprite;
		
		public var fanHuiBtn:Button;
		
		public var vsBar:VScrollBar;
		
		public var riBangBtn:Button;
		
		public var zongBangBtn:Button;

		private var container:Container;
		private var containerMySelf:Container;
        public function rankingPvpComponent()
        {
            super(ClassUtil.getObject("view.allView.rankingPvp"));
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			riBangBtn=createUI(Button,"ribang_btn");
			zongBangBtn=createUI(Button,"zongbang_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			sprite=getSkin("sprite");
			sprite2=getSkin("sprite2");
			maskSp=getSkin("mask_mc");
			sortChildIndex();
			
			container=new Container(null);
			container.contentWidth=669;
			container.contentHeight=156;			
			container.layout=new HTileLayout(container);
			container.x=0;
			container.y=0;
			
			containerMySelf=new Container(null);
			containerMySelf.contentWidth=669;
			containerMySelf.contentHeight=140;
			containerMySelf.layout=new HTileLayout(containerMySelf);
			containerMySelf.x=0;
			containerMySelf.y=7;
			
			addContainerMySelf();
			addContainer();
			
			vsBar.viewport=container;
			sprite.addChild(container);
			sprite2.addChild(containerMySelf);
			
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			vsBar.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
			vsBar.addEventListener(MouseEvent.ROLL_OVER,mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OVER,mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
			riBangBtn.addEventListener(MouseEvent.CLICK,riBangClickHandler);
			zongBangBtn.addEventListener(MouseEvent.CLICK,zongBangClickHandler);
        }
		
		private function addContainer():void
		{
			var length:int=20;
			for(var i:int;i<length;i++)
			{
				var item:RankingUserPveItemComponent=new RankingUserPveItemComponent();
				container.add(item);
			}
			container.layout.update();
			vsBar.update();
		}
		
		private function addContainerMySelf():void
		{
			var num:int
			for(var i:int=num;i<num+3;i++)
			{
				var item:RankingUserPveItemComponent=new RankingUserPveItemComponent();
				containerMySelf.add(item);
				if(i==num+1)
				{
					item.isMySelf();
				}
			}
			containerMySelf.layout.update();
		}
		
	/*	private function cleanContainer():void
		{
			while(container.numChildren>0)
			{
				container.removeChildAt(0);
			}
		}*/
		
		protected function riBangClickHandler(event:MouseEvent):void
		{
			maskSp.visible=false;
			sprite2.visible=false;
			container.contentHeight=296;
		}
		
		protected function zongBangClickHandler(event:MouseEvent):void
		{
			maskSp.visible=true;
			sprite2.visible=true;
			container.contentHeight=156;
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vsBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vsBar.alpahaTweenlite(1);
		}
				
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.CLOSE));
		}
	}
}