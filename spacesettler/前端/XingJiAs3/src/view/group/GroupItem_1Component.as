package view.group
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 * 未加入军团时候的显示军团的ITEM
	 * @author Administrator
	 * 
	 */	
    public class GroupItem_1Component extends Component
    {
		/**
		 *军团人数 
		 */		
		public var peopleNum:Label;
		
		/**
		 *会长名 
		 */		
		public var huiZhang:Label;
		
		/**
		 *排名 
		 */		
		public var paiMing:Label;
		
		/**
		 *军团名 
		 */		
		public var groupName:Label;
		
		public var vip:Sprite;
		
		public var tongPai:Sprite;
		
		public var yinPai:Sprite;
		
		public var jinPai:Sprite;

		public var back:Sprite;		
		
        public function GroupItem_1Component()
        {
            super(ClassUtil.getObject("view.group.GroupItem_1"));
			
			peopleNum=createUI(Label,"renshu_tf");
			huiZhang=createUI(Label,"huizhang_tf");
			paiMing=createUI(Label,"paiming_tf");
			groupName=createUI(Label,"groupname_tf");
			
			vip=getSkin("vip_mc");
			tongPai=getSkin("tongpai_mc");
			yinPai=getSkin("yinpai_mc");
			jinPai=getSkin("jinpai_mc");
			back=getSkin("back_mc");
			back.visible=false;
			vip.visible=false;
			
			sortChildIndex();
        }
		
		public function normal():void
		{
			tongPai.visible=false;
			yinPai.visible=false;
			jinPai.visible=false;
			paiMing.visible=true;		
			
		}
		
		public function first():void
		{
			tongPai.visible=false;
			yinPai.visible=false;
			jinPai.visible=true;
			paiMing.visible=false;
		}
		
		public function second():void
		{
			tongPai.visible=false;
			yinPai.visible=true;
			jinPai.visible=false;
			paiMing.visible=false;
		}
		
		public function thirdly():void
		{
			tongPai.visible=true;
			yinPai.visible=false;
			jinPai.visible=false;
			paiMing.visible=false;
		}
		public function isClick():void
		{
			back.visible=true;
		}
		public function isNotClick():void
		{
			back.visible=false;
		}
    }
}