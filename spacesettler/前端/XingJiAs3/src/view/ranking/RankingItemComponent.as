package view.ranking
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	public class RankingItemComponent extends Component
	{
		public var pveMC:Sprite;
		public var caiFuMC:Sprite;
		public var junTuanMC:Sprite;
		public var geRenMC:Sprite;
		public var yaoSaiMC:Sprite;
		
		public var titleText:Label;
		
		public var timeText:Label;
		public var zongBangText:Label;
		public var riBangText:Label;
		
		
		public var backMc:Sprite;
		/**
		 *排行第一版面的点击ITEM 
		 * @param skin
		 * 
		 */		
		public function RankingItemComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			pveMC=getSkin("pve_mc");
			caiFuMC=getSkin("caifu_mc");
			junTuanMC=getSkin("juntuan_mc");
			geRenMC=getSkin("geren_mc");
			yaoSaiMC=getSkin("yaosai_mc");
			backMc=getSkin("backMc");
			
			titleText=createUI(Label,"title_tf");
			timeText=createUI(Label,"shijian_tf");
			zongBangText=createUI(Label,"zongbang_tf");
			riBangText=createUI(Label,"ribang_tf");
			
			pveMC.visible=false;
			caiFuMC.visible=false;
			junTuanMC.visible=false;
			geRenMC.visible=false;
			yaoSaiMC.visible=false;
			backMc.visible=false;
		}
		
		public function showPve():void
		{
			pveMC.visible=true;
			caiFuMC.visible=false;
			junTuanMC.visible=false;
			geRenMC.visible=false;
			yaoSaiMC.visible=false;	
			backMc.visible=true;	
			titleText.text="PVP";
		}
		
		public function showCaiFu():void
		{
			pveMC.visible=false;
			caiFuMC.visible=true;
			junTuanMC.visible=false;
			geRenMC.visible=false;
			yaoSaiMC.visible=false;	
			titleText.text="财富榜";
		}
		
		public function showJunTuan():void
		{
			pveMC.visible=false;
			caiFuMC.visible=false;
			junTuanMC.visible=true;
			geRenMC.visible=false;
			yaoSaiMC.visible=false;	
			titleText.text="军团声望";
		}
		
		public function showGeRen():void
		{
			pveMC.visible=false;
			caiFuMC.visible=false;
			junTuanMC.visible=false;
			geRenMC.visible=true;
			yaoSaiMC.visible=false;		
			titleText.text="个人声望";
		}
		
		public function showYaoSai():void
		{
			pveMC.visible=false;
			caiFuMC.visible=false;
			junTuanMC.visible=false;
			geRenMC.visible=false;
			yaoSaiMC.visible=true;	
			titleText.text="要塞占领";
		}
	}
}