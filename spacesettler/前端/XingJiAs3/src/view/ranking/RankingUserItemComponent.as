package view.ranking
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *通用的用户ITEM显示 
	 * @author Administrator
	 * 
	 */	
	public class RankingUserItemComponent extends Component
	{
		/**
		 *vip图标 
		 */				
		public var vipMc:Sprite;
		
		/**
		 *铜牌图标 
		 */		
		public var tongPaiMc:Sprite;
		
		/**
		 * 银牌
		 */		
		public var yinPaiMc:Sprite;
		
		/**
		 *金牌 
		 */		
		public var jinPaiMc:Sprite;
		
		/**
		 *上升图标 
		 */		
		public var upMc:Sprite;
		
		/**
		 *下降 
		 */		
		public var downMc:Sprite;
		
		/**
		 *底板选项框 
		 */		
		public var backMc:Sprite;
		
		/**
		 *玩家 
		 */		
		public var userNameText:Label;
		
		/**
		 *军团 
		 */		
		public var junTuanText:Label;
		
		/**
		 *阵营 
		 */		
		public var zhenYingText:Label;
		
		/**
		 *显示 
		 */		
		public var xianShiText:Label;
		
		/**
		 *上升或者下降的名次显示 
		 */		
		public var upOrDownText:Label;
		
		/**
		 *排名 
		 */		
		public var paiMingText:Label;
		public function RankingUserItemComponent()
		{
			super(ClassUtil.getObject("view.allView.ranking_item_1"));
			
			userNameText=createUI(Label,"username_tf");
			junTuanText=createUI(Label,"juntuan_tf");
			zhenYingText=createUI(Label,"zhengying_tf");
			xianShiText=createUI(Label,"zong_tf");
			upOrDownText=createUI(Label,"up_down_tf");
			paiMingText=createUI(Label,"paiming_tf");
			
			vipMc=getSkin("vip_mc");
			tongPaiMc=getSkin("tongpai_mc");
			yinPaiMc=getSkin("yinpai_mc");
			jinPaiMc=getSkin("jinpai_mc");
			upMc=getSkin("up_mc");
			downMc=getSkin("down_mc");
			backMc=getSkin("back_mc");
			
			sortChildIndex();
			
			notMySelf();
		}
		
		public function isMySelf():void
		{
			upMc.visible=true;
			downMc.visible=true;
			upOrDownText.visible=true;
			backMc.visible=true;
			userNameText.color=0xffffff;
			junTuanText.color=0xffffff;
			zhenYingText.color=0xffffff;
			xianShiText.color=0xffffff;
			upMc.visible=true;
			downMc.visible=true;
			upOrDownText.visible=true;
		}
		 
		public function notMySelf():void
		{
			upMc.visible=false;
			downMc.visible=false;
			upOrDownText.visible=false;
			backMc.visible=false;
			userNameText.color=0x0099ff;
			junTuanText.color=0x0099ff;
			zhenYingText.color=0x0099ff;
			xianShiText.color=0x0099ff;
			upMc.visible=false;
			downMc.visible=false;
			upOrDownText.visible=false;
		}
				
	}
}