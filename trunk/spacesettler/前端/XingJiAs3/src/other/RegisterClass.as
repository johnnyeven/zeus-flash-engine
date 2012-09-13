package other
{
    import flash.geom.Point;
    import flash.net.registerClassAlias;

    public class RegisterClass
    {
        public static function registerClass():void
        {	
			registerClassAlias("flash.geom.Point",Point);
        }
    }
}
