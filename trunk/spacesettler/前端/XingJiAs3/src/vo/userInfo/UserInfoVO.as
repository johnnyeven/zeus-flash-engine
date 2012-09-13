package vo.userInfo
{
    import ui.vo.ValueObject;

    [Bindable]
    public class UserInfoVO extends ValueObject
    {

        public var id:String;

        public var userName:String;

        public var level:int;

        public var exp:int;

        public var nextExp:int;

        public var gold:int;

        public var rmb:int;

        public var headURL:String;
		
		/**
		 *阵营 
		 */		
		public var camp:int=1;
    }
}
