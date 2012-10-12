package view.ranking
{
	import com.zn.utils.ClassUtil;
	
	import events.ranking.RankingEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.rankingProxy.RankingProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.layouts.VTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.ranking.RankingVo;
	
	/**
	 *排行第一版面Item点击生成通用的显示排行版面 
	 * @author Administrator
	 * 
	 */	
    public class RankingCommonComponent extends Component
    {
		
		public var userName:Label;
		public var junTuan:Label;
		public var showText:Label;
		
		public var yaoSaiMc:Sprite;
		public var junTuanMc:Sprite;
		public var shengWangMc:Sprite;
		public var caiFuMc:Sprite;
		

		public var sprite:Sprite;
		public var sprite2:Sprite;
		public var maskSp:Sprite;
		public var fanHuiBtn:Button;
		public var riBangBtn:Button;
		public var zongBangBtn:Button;
		public var vsBar:VScrollBar;
		
		private var container:Container;
		private var containerMySelf:Container;
		private var page:int;
		private var _type:String;
		
		private var rankingProxy:RankingProxy;
		private var userProxy:UserInfoProxy;
        public function RankingCommonComponent()
        {
            super(ClassUtil.getObject("view.allView.RankingCommon"));
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			riBangBtn=createUI(Button,"ribang_btn");
			zongBangBtn=createUI(Button,"zongbang_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			userName=createUI(Label,"text_1");
			junTuan=createUI(Label,"text_2");
			showText=createUI(Label,"text_3");
			
			yaoSaiMc=getSkin("yaosai_mc");
			junTuanMc=getSkin("juntuan_mc");
			shengWangMc=getSkin("shengwang_mc");
			caiFuMc=getSkin("caifu_mc");
		
			
			sprite=getSkin("sprite");
			sprite2=getSkin("sprite2");
			maskSp=getSkin("mask_mc");
			sortChildIndex();
			
			rankingProxy=ApplicationFacade.getProxy(RankingProxy);
			userProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			yaoSaiMc.visible=false;
			junTuanMc.visible=false;
			shengWangMc.visible=false;
			caiFuMc.visible=false;
			
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
			cleanAndAdd();
			
			
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
		
		private function addContainer(arr:Array,cont:Container):void
		{			
			var length:int=arr.length;
			for(var i:int;i<length;i++)
			{
				var rankingVo:RankingVo=arr[i];				
				var item:RankingUserItemComponent=new RankingUserItemComponent();
				item.userNameText.text=rankingVo.nickname;
				item.junTuanText.text=rankingVo.legion_name;
				if(rankingVo.id==userProxy.userInfoVO.player_id)
				{
					item.isMySelf();
				}
				
				if(rankingVo.vip_level>0)
				{
					item.vipMc.visible=true;
				}else
				{
					item.vipMc.visible=false;
				}
				
				item.xianShiText.text=rankingVo.show.toString();
				
				if(rankingVo.rank==1)
				{
					item.yinPaiMc.visible=false;
					item.jinPaiMc.visible=true;
					item.tongPaiMc.visible=false;
					item.paiMingText.visible=false;
				}else if(rankingVo.rank==2)
				{
					item.yinPaiMc.visible=true;
					item.jinPaiMc.visible=false;
					item.tongPaiMc.visible=false;
					item.paiMingText.visible=false;
				}else if(rankingVo.rank==3)
				{
					item.yinPaiMc.visible=false;
					item.jinPaiMc.visible=false;
					item.tongPaiMc.visible=true;
					item.paiMingText.visible=false;
				}else
				{
					item.paiMingText.text=rankingVo.rank.toString();
					item.yinPaiMc.visible=false;
					item.jinPaiMc.visible=false;
					item.tongPaiMc.visible=false;
				}
				cont.add(item);
			}
			cont.layout.update();
			vsBar.update();
		}
		
		private function add():void
		{			
			addContainer(rankingProxy.rankingArr,container);
			addContainer(rankingProxy.myRankingArr,containerMySelf);
		}
		
		private function cleanContainer():void
		{
			while(containerMySelf.num>0)
			{
				DisposeUtil.dispose(containerMySelf.removeAt(0));
			}
			while(container.num>0)
			{
				DisposeUtil.dispose(container.removeAt(0));
			}
		}
		
		protected function riBangClickHandler(event:MouseEvent):void
		{
			maskSp.visible=false;
			sprite2.visible=false;
			container.contentHeight=vsBar.height=296;
			if(_type=="yaosai")
				dispatchEvent(new RankingEvent(RankingEvent.DAYLIST_FORTERESS));
			if(_type=="shengwang")
				dispatchEvent(new RankingEvent(RankingEvent.DAYLIST_REPUTATION));
			
			
		}
		
		public function cleanAndAdd():void
		{
			cleanContainer();
			add();
		}
		
		protected function zongBangClickHandler(event:MouseEvent):void
		{
			maskSp.visible=true;
			sprite2.visible=true;
			container.contentHeight=vsBar.height=156;
			if(_type=="yaosai")
				dispatchEvent(new RankingEvent(RankingEvent.LIST_FORTERESS));
			if(_type=="shengwang")
				dispatchEvent(new RankingEvent(RankingEvent.LIST_REPUTATION));
			
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
		
		public function showCaiFu(type:String):void
		{
			_type=type;
			userName.text="玩家";
			junTuan.text="军团";
			showText.text="财富值";
			yaoSaiMc.visible=false;
			junTuanMc.visible=false;
			shengWangMc.visible=false;
			caiFuMc.visible=true;
		}
		
		public function showJunTuan(type:String):void
		{
			_type=type;
			userName.text="军团";
			junTuan.text="军团长";
			showText.text="军团声望";
			yaoSaiMc.visible=false;
			junTuanMc.visible=true;
			shengWangMc.visible=false;
			caiFuMc.visible=false;
		}
		
		public function showShengWang(type:String):void
		{
			_type=type;
			userName.text="玩家";
			junTuan.text="军团";
			showText.text="声望";
			yaoSaiMc.visible=false;
			junTuanMc.visible=false;
			shengWangMc.visible=true;
			caiFuMc.visible=false;
		}
		
		public function showYaoSai(type:String):void
		{
			_type=type;
			userName.text="玩家";
			junTuan.text="军团";
			showText.text="占领要塞";
			yaoSaiMc.visible=true;
			junTuanMc.visible=false;
			shengWangMc.visible=false;
			caiFuMc.visible=false;
		}
	}
}