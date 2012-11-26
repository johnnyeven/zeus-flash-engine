package view.battle.fightView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.battle.BattleVictoryResourceTypeEnum;
	
	import events.battle.fight.FightPanelEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import proxy.battle.BattleProxy;
	import proxy.packageView.PackageViewProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.VLayout;
	import ui.utils.DisposeUtil;
	
	import vo.battle.fight.FightVictoryRewardVO;
	import vo.cangKu.ItemVO;

	/**
	 * 战斗胜利
	 * @author lw
	 */	
	public class BattleVictoryPanelComponent extends Component
	{
		public var okBtn:Button;
		public var vScrollBar:VScrollBar;
		
		private var container:Container;
		
		private var _detailLabel:Sprite;
		private var _getLabel:Sprite;
		private var _victoryRewardVO:FightVictoryRewardVO;
		private var timer:Timer;
		public function BattleVictoryPanelComponent()
		{
			super(ClassUtil.getObject("battle.BattleVictoryPanelSkin"));
			timer = new Timer(10000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			okBtn=createUI(Button,"ok_btn");
			vScrollBar = createUI(VScrollBar, "vScrollBar");

//			_detailLabel=ClassUtil.getObject("battle.BattleVictoryDetailLabel");
//			_getLabel=ClassUtil.getObject("battle.BattleVictoryGetlLabel");
			
			container =new Container(null);
			container.contentWidth=280;
			container.contentHeight=140;
			container.layout = new VLayout(container);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.x = 146;
			container.y = 188;
			addChild(container);
			
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			addChild(vScrollBar);
			sortChildIndex();
			
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
		}
		
		public function setVictoryData(data:FightVictoryRewardVO):void
		{
			_victoryRewardVO = data;
			timer.start();
			 //根据物品类型来显示物品
			if(_victoryRewardVO.crystal || _victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.jinJing)
			{
				var crystalComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				crystalComp.ziYuan_img.source=ResEnum.getConditionIconURL+"2.png";
				if(_victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.jinJing)
				{
					crystalComp.info_tf.text=MultilanguageManager.getString("crystal") +"x"+ (_victoryRewardVO.crystal + _victoryRewardVO.delta);
				}
				else
				{
					crystalComp.info_tf.text=MultilanguageManager.getString("crystal") +"x"+ _victoryRewardVO.crystal;
				}
				container.add(crystalComp);
				container.layout.update();
				vScrollBar.update();
			}
			if(_victoryRewardVO.dark || _victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.anWuZhi)
			{
				var darkComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				darkComp.ziYuan_img.source=ResEnum.getConditionIconURL+"1.png";
				if(_victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.anWuZhi)
				{
					darkComp.info_tf.text=MultilanguageManager.getString("broken_crysta") +"x"+ (_victoryRewardVO.dark+_victoryRewardVO.delta);
				}
				else
				{
					darkComp.info_tf.text=MultilanguageManager.getString("broken_crysta") +"x"+ _victoryRewardVO.dark;
				}
				
				container.add(darkComp);
				container.layout.update();
				vScrollBar.update();
			}
			if(_victoryRewardVO.tritium || _victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.chuanQing)
			{
			var tritiumComp:BattleVictorySourceItem=new BattleVictorySourceItem();
			tritiumComp.ziYuan_img.source=ResEnum.getConditionIconURL+"3.png";
			if(_victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.chuanQing)
			{
				tritiumComp.info_tf.text=MultilanguageManager.getString("tritium") +"x"+ (_victoryRewardVO.tritium+_victoryRewardVO.delta);
			}
			else
			{
				tritiumComp.info_tf.text=MultilanguageManager.getString("tritium") +"x"+ _victoryRewardVO.tritium;
			}
			
			container.add(tritiumComp);
			container.layout.update();
			vScrollBar.update();
			}
			if(_victoryRewardVO.dark_crystal || _victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.anNengShuiJing)
			{
				var darkCrystalComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				darkCrystalComp.ziYuan_img.source=ResEnum.getConditionIconURL+"8.png";
				if(_victoryRewardVO.resource_type == BattleVictoryResourceTypeEnum.anNengShuiJing)
				{
					darkCrystalComp.info_tf.text=MultilanguageManager.getString("dark_crystal") +"x"+ (_victoryRewardVO.dark_crystal+_victoryRewardVO.delta);
        		}
				else
				{
					darkCrystalComp.info_tf.text=MultilanguageManager.getString("dark_crystal") +"x"+ _victoryRewardVO.dark_crystal;
				}
				
				container.add(darkCrystalComp);
				container.layout.update();
				vScrollBar.update();
			}
			if(_victoryRewardVO.bluemap_level && _victoryRewardVO.bluemap_recipes_type && _victoryRewardVO.bluemap_recipes_category)
			{
				var recipeComp:BattleVictoryRepiceComponent=new BattleVictoryRepiceComponent();
								
				var packageViewProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
				var itemInfoVO:ItemVO = new ItemVO();
				itemInfoVO.category = _victoryRewardVO.bluemap_recipes_category;
				itemInfoVO.enhanced = 1;
				itemInfoVO.type = _victoryRewardVO.bluemap_level;
				itemInfoVO.recipe_type = _victoryRewardVO.bluemap_recipes_type;
				packageViewProxy.setBaseItemName(itemInfoVO,packageViewProxy.tuZhiXML);
								
				recipeComp.iconImg.source=ResEnum.getConditionIconURL+"7.png";;
				recipeComp.nameLabel.text=itemInfoVO.name;
				recipeComp.descripLabel.text=itemInfoVO.description;
				container.add(recipeComp);
				container.layout.update();
				vScrollBar.update();
			}
			
			addDetailItem();
		}
		
		private function addDetailItem():void
		{
			//添加战场奖励Label
			var rewardLabel:Label = new Label();
			rewardLabel.color = 0xFF9900;
			rewardLabel.fontName = "微软雅黑";
			rewardLabel.text = "战场奖励";
			container.add(rewardLabel);
			container.layout.update();
			vScrollBar.update();
			//添加奖励项
			var resourceItem:BattleVictorySourceItem;
			switch(_victoryRewardVO.resource_type)
			{
				case BattleVictoryResourceTypeEnum.jinJing:
				{
		
					resourceItem = new BattleVictorySourceItem();
					resourceItem.ziYuan_img.source=ResEnum.getConditionIconURL+"2.png";
					resourceItem.info_tf.text=MultilanguageManager.getString("crystal") +"x"+ _victoryRewardVO.delta;
					container.add(resourceItem);
					container.layout.update();
					vScrollBar.update();
					break;
				}
				case BattleVictoryResourceTypeEnum.chuanQing:
				{
					
					resourceItem = new BattleVictorySourceItem();
					resourceItem.ziYuan_img.source=ResEnum.getConditionIconURL+"3.png";
					resourceItem.info_tf.text=MultilanguageManager.getString("tritium") +"x"+ _victoryRewardVO.delta;
					container.add(resourceItem);
					container.layout.update();
					vScrollBar.update();
					break;
				}
				case BattleVictoryResourceTypeEnum.anWuZhi:
				{
					resourceItem = new BattleVictorySourceItem();
					resourceItem.ziYuan_img.source=ResEnum.getConditionIconURL+"1.png";
					resourceItem.info_tf.text=MultilanguageManager.getString("broken_crysta") +"x"+ _victoryRewardVO.delta;
					container.add(resourceItem);
					container.layout.update();
					vScrollBar.update();
					break;
				}
				case BattleVictoryResourceTypeEnum.anNengShuiJing:
				{
					resourceItem = new BattleVictorySourceItem();
					resourceItem.ziYuan_img.source=ResEnum.getConditionIconURL+"8.png";
					resourceItem.info_tf.text=MultilanguageManager.getString("dark_crystal") +"x"+ _victoryRewardVO.delta;
					container.add(resourceItem);
					container.layout.update();
					vScrollBar.update();
					break;
				}
			}
			
			if(_victoryRewardVO.bluemap_level && _victoryRewardVO.bluemap_recipes_type && _victoryRewardVO.bluemap_recipes_category)
			{
				var recipeComp:BattleVictoryRepiceComponent=new BattleVictoryRepiceComponent();
				
				var packageViewProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
				var itemInfoVO:ItemVO = new ItemVO();
				itemInfoVO.category = _victoryRewardVO.bluemap_recipes_category;
				itemInfoVO.enhanced = 1;
				itemInfoVO.type = _victoryRewardVO.bluemap_level;
				itemInfoVO.recipe_type = _victoryRewardVO.bluemap_recipes_type;
				packageViewProxy.setBaseItemName(itemInfoVO,packageViewProxy.tuZhiXML);
				
				recipeComp.iconImg.source=ResEnum.getConditionIconURL+"7.png";
				recipeComp.nameLabel.text=itemInfoVO.name;
				recipeComp.descripLabel.text=itemInfoVO.description;
				container.add(recipeComp);
				container.layout.update();
				vScrollBar.update();
			}
			//有拾取物才添加此标题
			if(_victoryRewardVO.crystal || _victoryRewardVO.tritium || _victoryRewardVO.dark || _victoryRewardVO.dark_crystal)
			{
				//添加战场拾取物品Label
				var getRourseInBattleLabel:Label = new Label();
				getRourseInBattleLabel.color = 0xFF9900;
				getRourseInBattleLabel.fontName = "微软雅黑";
				getRourseInBattleLabel.text = "战场拾取";
				container.add(getRourseInBattleLabel);
				container.layout.update();
				vScrollBar.update();
			}
			//根据物品类型来显示物品
			if(_victoryRewardVO.crystal)
			{
				var crystalComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				crystalComp.ziYuan_img.source=ResEnum.getConditionIconURL+"2.png";
				crystalComp.info_tf.text=MultilanguageManager.getString("crystal") +"x"+ _victoryRewardVO.crystal;
				container.add(crystalComp);
				container.layout.update();
				vScrollBar.update();
			}
			if(_victoryRewardVO.dark)
			{
				var darkComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				darkComp.ziYuan_img.source=ResEnum.getConditionIconURL+"1.png";
				darkComp.info_tf.text=MultilanguageManager.getString("broken_crysta") +"x"+ _victoryRewardVO.dark;
				container.add(darkComp);
				container.layout.update();
				vScrollBar.update();
			}
			if(_victoryRewardVO.tritium)
			{
				var tritiumComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				tritiumComp.ziYuan_img.source=ResEnum.getConditionIconURL+"3.png";
				tritiumComp.info_tf.text=MultilanguageManager.getString("tritium") +"x"+ _victoryRewardVO.tritium;
				container.add(tritiumComp);
				container.layout.update();
				vScrollBar.update();
			}
			if(_victoryRewardVO.dark_crystal)
			{
				var darkCrystalComp:BattleVictorySourceItem=new BattleVictorySourceItem();
				darkCrystalComp.ziYuan_img.source=ResEnum.getConditionIconURL+"8.png";
				darkCrystalComp.info_tf.text=MultilanguageManager.getString("dark_crystal") +"x"+ _victoryRewardVO.dark_crystal;
				container.add(darkCrystalComp);
				container.layout.update();
				vScrollBar.update();
			}
			//添加要塞归属
			var whoLabel:Label = new Label();
			whoLabel.color = 0xFF9900;
			whoLabel.fontName = "微软雅黑";
			whoLabel.text = "要塞归属";
			container.add(whoLabel);
			container.layout.update();
			vScrollBar.update();
			//添加要塞归属条目
			var battleVictoryWhoItem:BattleVictoryWhoItem = new BattleVictoryWhoItem();
			if(_victoryRewardVO.gain_fort==1)
				battleVictoryWhoItem.info_tf.text = MultilanguageManager.getString("yaoSaiBelong");
			else
				battleVictoryWhoItem.info_tf.text = "";
			container.add(battleVictoryWhoItem);
			container.layout.update();
			vScrollBar.update();
		}
		
		override public function dispose():void
		{
			if(timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);				
			}
			vScrollBar.removeEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.removeEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			super.dispose();
		}
		
		
		
		protected function okBtnHandler(event:MouseEvent):void
		{
			if(timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);				
			}
			dispatchEvent(new FightPanelEvent(FightPanelEvent.CLOSE_EVENT));
		}
		private function timerHandler(event:TimerEvent):void
		{
			if(timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);				
			}
			if(_victoryRewardVO.gain_fort==1)
			{
				dispatchEvent(new Event("victoryTimerEvent"));
			}
			else
			{
				dispatchEvent(new FightPanelEvent(FightPanelEvent.CLOSE_EVENT));
			}
			
		}
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
	}
}