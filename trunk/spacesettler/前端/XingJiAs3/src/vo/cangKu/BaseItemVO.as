package vo.cangKu
{
    import com.zn.utils.StringUtil;
    
    import enum.ResEnum;
    import enum.item.ItemEnum;
    
    import ui.vo.ValueObject;

    [Bindable]
    /**
     *物品基类
     * @author zn
     *
     */
    public class BaseItemVO extends ValueObject
    {
        public static const FIELD_ID:String = "id";
		
		public static const MONEY:int=1;

        /**
         *ID
         */
        public var id:String;

        /**
         *挂件名字
         */
        public var name:String;

        /**
         *类型  "Chariot" "TankPart" "item" "recipes"
         */
        public var item_type:String;

		/**
		 *类型 (int)
		 */
		public var itemType:int;
		/**
		 * 道具标识
		 */
		public var key:String;
        /**
         *挂件分类
         */
        public var category:int;

        /**
         *强化类型
         */
        public var enhanced:int;

        /**
         * 型号
         */
        public var type:int;
		/**
		 * 需要的条件
		 */
		public var conditions:Array = [];
		/**
		 * 需要的科技类型
		 */
		public var science_type:int;
		/**
		 * 需要的科技等级
		 */
		public var science_level:int;
		/**
		 * 道具介绍
		 */
		public var description:String;
		
		/**
		 * 评分
		 */
		public var value:int;
		
		/**
		 * 等级
		 */
		public var level:int;
		
		/**
		 * 选中的物品数量
		 */
		public var count:int = 1;

        private var _iconURL:String = "";

        public function get iconURL():String
        {
            if (StringUtil.isEmpty(_iconURL))
            {
                switch (item_type)
                {
                    case ItemEnum.Chariot:
                    case ItemEnum.TankPart:
                    {
                        _iconURL = ResEnum.senceEquipment + item_type + "_" + category + ".png";
                        break;
                    }
                    case ItemEnum.recipes:
                    {
                        _iconURL = ResEnum.getRecipeURL;
                        break;
                    }
                    case ItemEnum.item:
                    {
                        _iconURL = ResEnum.getItemURL;
                        break;
                    }
                }
            }

            return _iconURL;
        }
    }
}
