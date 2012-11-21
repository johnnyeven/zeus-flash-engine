package view.battle.fight
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Image;
	import ui.components.LoaderImage;
	import ui.core.Component;

	/**
	 *物品
	 * @author zn
	 *
	 */
	public class FightItemComponent extends Component
	{
		private var _itemVO:BUFFER_DEF;

		private var image:LoaderImage;
		
		public var moveTweenLite:TweenLite;

		public function FightItemComponent()
		{
			super(null);
			image=new LoaderImage();
			addChild(image);
			image.loaderCompleteCallBack=function():void
			{
				image.x=-image.width * 0.5;
				image.y=-image.height * 0.5;
			};
			
			mouseChildren=mouseEnabled=false;
		}
		
		public override function dispose():void
		{
			if(moveTweenLite)
				moveTweenLite.kill();
			moveTweenLite=null;
			
			super.dispose();
		}

		public function get itemVO():BUFFER_DEF
		{
			return _itemVO;
		}

		public function set itemVO(value:BUFFER_DEF):void
		{
			_itemVO=value;

			x=itemVO.x;
			y=itemVO.y;

			image.source = itemVO.iconURL;
		}
	}
}
