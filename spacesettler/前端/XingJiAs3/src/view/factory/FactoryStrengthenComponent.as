package view.factory
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	import enum.factory.FactoryEnum;
	
	import events.factory.FactoryEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.CheckBox;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.cangKu.ZhanCheInfoVO;
	
    public class FactoryStrengthenComponent extends Component
    {
		public var fanhui_btn:Button;
		
		public var pingfen_tf:Label;
		public var level_tf:Label;
		public var title_tf:Label;
		
		//插槽数量的TF
		public var tf_3:Label;
		public var tf_2:Label;
		public var tf_1:Label;
		//1-5的强化条
		public var bar_5:ProgressBar;
		public var bar_4:ProgressBar;
		public var bar_3:ProgressBar;
		public var bar_2:ProgressBar;
		public var bar_1:ProgressBar;
		//1-5 对应的强化按钮
		public var btn_5:Button;
		public var btn_4:Button;
		public var btn_3:Button;
		public var btn_2:Button;
		public var btn_1:Button;
		
		//左边到右边的属性
		public var text_3:Label;
		public var text_6:Label;
		public var text_5:Label;
		public var text_2:Label;
		public var text_4:Label;
		public var text_1:Label;
		
		//强化条对应显示
		public var show_1:Label;
		public var show_2:Label;
		public var show_3:Label;
		public var show_4:Label;
		public var show_5:Label;
		
		public var mc_1:Sprite;
		public var mc_2:Sprite;
		public var mc_3:Sprite;
		public var mc_4:Sprite;
		public var mc_5:Sprite;
		
		public var sprite:LoaderImage;
		
		public var num_1:Label;
		public var num_2:Label;
		public var num_3:Label;
		public var num_4:Label;
		public var num_5:Label;
		
		public var box1:CheckBox;
		public var box2:CheckBox;
		public var box3:CheckBox;
		
		private var _count:int=1;
        public function FactoryStrengthenComponent()
        {
            super(ClassUtil.getObject("view.factory.FactoryStrengthenSkin"));
			
			fanhui_btn=createUI(Button,"fanhui_btn");
			sprite=createUI(LoaderImage,"sprite");
			btn_1=createUI(Button,"btn_1");
			btn_2=createUI(Button,"btn_2");
			btn_3=createUI(Button,"btn_3");
			btn_4=createUI(Button,"btn_4");
			btn_5=createUI(Button,"btn_5");
				
			pingfen_tf=createUI(Label,"pingfen_tf");
			level_tf=createUI(Label,"level_tf");
			title_tf=createUI(Label,"title_tf");
				
			tf_3=createUI(Label,"tf_3");
			tf_2=createUI(Label,"tf_2");
			tf_1=createUI(Label,"tf_1");
			
			num_1=createUI(Label,"num_1");
			num_2=createUI(Label,"num_2");
			num_3=createUI(Label,"num_3");
			num_4=createUI(Label,"num_4");
			num_5=createUI(Label,"num_5");
			
			box1=createUI(CheckBox,"box1");
			box2=createUI(CheckBox,"box2");
			box3=createUI(CheckBox,"box3");
			
			box1.selected=true;
			box2.selected=box3.selected=false;
			
			text_1=createUI(Label,"text_1");
			text_2=createUI(Label,"text_2");
			text_3=createUI(Label,"text_3");
			text_4=createUI(Label,"text_4");
			text_5=createUI(Label,"text_5");
			text_6=createUI(Label,"text_6");
			
			show_1=createUI(Label,"show_1");
			show_2=createUI(Label,"show_2");
			show_3=createUI(Label,"show_3");
			show_4=createUI(Label,"show_4");
			show_5=createUI(Label,"show_5");
				
			bar_1=createUI(ProgressBar,"bar_1");
			bar_2=createUI(ProgressBar,"bar_2");
			bar_3=createUI(ProgressBar,"bar_3");
			bar_4=createUI(ProgressBar,"bar_4");
			bar_5=createUI(ProgressBar,"bar_5");
				
			mc_1=getSkin("mc_1");
			mc_2=getSkin("mc_2");
			mc_3=getSkin("mc_3");
			mc_4=getSkin("mc_4");
			mc_5=getSkin("mc_5");
			
			sortChildIndex();
			
			upData(FactoryEnum.CURRENT_ZHANCHE_VO);
			
			fanhui_btn.addEventListener(MouseEvent.CLICK,closeHandler);
			btn_1.addEventListener(MouseEvent.CLICK,btn_1Handler);
			btn_2.addEventListener(MouseEvent.CLICK,btn_2Handler);
			btn_3.addEventListener(MouseEvent.CLICK,btn_3Handler);
			btn_4.addEventListener(MouseEvent.CLICK,btn_4Handler);
			btn_5.addEventListener(MouseEvent.CLICK,btn_5Handler);
			
			bar_1.percent=0;
			bar_2.percent=0;
			bar_3.percent=0;
			bar_4.percent=0;
			bar_5.percent=0;
			
			mc_1.visible=false;
			mc_2.visible=false;
			mc_3.visible=false;
			mc_4.visible=false;
			mc_5.visible=false;
			
			setNumLable(_count);
			
			box1.addEventListener(Event.CHANGE,boxChange1Handler);
			box2.addEventListener(Event.CHANGE,boxChange2Handler);
			box3.addEventListener(Event.CHANGE,boxChange3Handler);
			
//			upData(FactoryEnum.CURRENT_ZHANCHE_VO);
        }
		
		protected function boxChange1Handler(event:Event):void
		{
			if(box1.selected==true)
			{
				_count=1;
				box2.selected=box3.selected=false;
			}
			changeBox();
		}
		
		private function changeBox():void
		{
			if(box1.selected==false&&box3.selected==false&&box2.selected==false)
			{
				box1.selected=true;
				_count=1;
				box2.selected=box3.selected=false;
			}
			setNumLable(_count);
		}
		
		protected function boxChange2Handler(event:Event):void
		{
			if(box2.selected==true)
			{
				_count=5;
				box1.selected=box3.selected=false;
			}
			changeBox();
		}
		
		protected function boxChange3Handler(event:Event):void
		{
			if(box3.selected==true)
			{
				_count=10;
				box1.selected=box2.selected=false;
			}
			changeBox();
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.CLOSE_EVENT));
		}
		
		protected function btn_1Handler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.QIANGHUA_EVENT,null,FactoryEnum.ATTACK_SPEED,_count));
		}
		
		protected function btn_2Handler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.QIANGHUA_EVENT,null,FactoryEnum.ARRACK_AREA,_count));
		}
		
		protected function btn_3Handler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.QIANGHUA_EVENT,null,FactoryEnum.ENDURANCE,_count));
		}
		
		protected function btn_4Handler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.QIANGHUA_EVENT,null,FactoryEnum.ENERGY,_count));	
		}
		
		protected function btn_5Handler(event:MouseEvent):void
		{
			dispatchEvent(new FactoryEvent(FactoryEvent.QIANGHUA_EVENT,null,FactoryEnum.SPEED,_count));
		}
		
		public function upData(info:ZhanCheInfoVO):void
		{
			sprite.source=ResEnum.senceEquipment+info.item_type+"_"+info.category+".png";
			
			pingfen_tf.text=info.value.toString();
			level_tf.text=info.level.toString();
			title_tf.text=info.name;
			tf_1.text=info.big_slot.toString();
			tf_2.text=info.medium_slot.toString();
			tf_3.text=info.small_slot.toString();
			text_1.text=info.attack.toString();
			text_4.text=info.total_shield.toString();
			
			var str1:String=(info.damageDescShiDan*100).toFixed(1);
			var str2:String=(info.damageDescJiGuang*100).toFixed(1);
			var str3:String=(info.damageDescDianCi*100).toFixed(1);
			var str4:String=(info.damageDescAnNeng*100).toFixed(1);
			
			text_2.text=str1+"%";
			text_3.text=str3+"%";
			text_5.text=str2+"%";
			text_6.text=str4+"%";
			
			show_1.text=info.total_attack_speed.toString()+"/"+info.max_attack_speed.toString();
			show_2.text=info.total_attack_area .toString()+"/"+info.max_attack_area.toString();
			show_3.text=info.total_endurance .toString()+"/"+info.max_endurance.toString();
			show_4.text=info.total_energy .toString()+"/"+info.max_energy.toString();
			show_5.text=info.total_speed .toString()+"/"+info.max_speed.toString();
			
			if(info.total_attack_speed>=info.max_attack_speed)
			{
				btn_1.visible=false;
				mc_1.visible=true;				
			}
			
			if(info.total_attack_area>=info.max_attack_area)
			{
				btn_2.visible=false;
				mc_2.visible=true;				
			}
			
			if(info.total_endurance>=info.max_endurance)
			{
				btn_3.visible=false;
				mc_3.visible=true;				
			}
			
			if(info.total_energy>=info.max_energy)
			{
				btn_4.visible=false;
				mc_4.visible=true;				
			}
			
			if(info.total_speed>=info.max_speed)
			{
				btn_5.visible=false;
				mc_5.visible=true;				
			}
			
			
			bar_1.percent=info.total_attack_speed/info.max_attack_speed;
			bar_2.percent=info.total_attack_area/info.max_attack_area;
			bar_3.percent=info.total_endurance/info.max_endurance;
			bar_4.percent=info.total_energy/info.max_energy;
			bar_5.percent=info.total_speed/info.max_speed;
		}
		
		private function setNumLable(num:int):void
		{
			num_1.text=num_2.text=num_3.text=num_4.text=num_5.text="X"+String(num);
		}
    }
}