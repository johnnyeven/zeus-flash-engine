package view.ranking
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *PVP单独的用户ITEM显示 
	 * @author Administrator
	 * 
	 */	
	public class RankingUserPveItemComponent extends Component
	{
		
		public var vipMc:Sprite;
		public var tongPaiMc:Sprite;
		public var yinPaiMc:Sprite;
		public var jinPaiMc:Sprite;
		public var upMc:Sprite;
		public var downMc:Sprite;
		public var backMc:Sprite;
		
		public var userNameText:Label;
		public var junTuanText:Label;
		public var zhenYingText:Label;
		public var xianShiText:Label;
		public var upOrDownText:Label;
		public var paiMingText:Label;
		
		public var victoryNum:Label;
		public var failNum:Label;
		public var victoryProbability:Label;
		
		public function RankingUserPveItemComponent()
		{
			super(ClassUtil.getObject("view.allView.ranking_item_2"));
			
			userNameText=createUI(Label,"username_tf");
			junTuanText=createUI(Label,"juntuan_tf");
			zhenYingText=createUI(Label,"zhenying_tf");
			xianShiText=createUI(Label,"zong_tf");
			upOrDownText=createUI(Label,"up_down_tf");
			paiMingText=createUI(Label,"paiming_tf");
			victoryNum=createUI(Label,"shengli_tf");
			failNum=createUI(Label,"shibai_tf");
			victoryProbability=createUI(Label,"shenglv_tf");
			
			vipMc=getSkin("vip_mc");
			tongPaiMc=getSkin("tongpai_mc");
			yinPaiMc=getSkin("yinpai_mc");
			jinPaiMc=getSkin("jinpai_mc");
			upMc=getSkin("up_mc");
			downMc=getSkin("down_mc");
			backMc=getSkin("back_mc");
			
			
			tongPaiMc.visible=false;
			yinPaiMc.visible=false;
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
			victoryNum.color=0xffffff;
			/*var str:String = "<p><s color='0xff0000'>{0}</s></p>";
			str = StringUtil.formatString(str,vo.name)*/
			failNum.color=0xffffff;
			victoryProbability.color=0xffffff;
			
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
			victoryNum.color=0x0099ff;
			failNum.color=0x0099ff;
			victoryProbability.color=0x0099ff;
		}
		
		public function showClick(bool:Boolean):void
		{
			backMc.visible=bool;
		}
	}
}