package utils.battle
{
    import com.netease.protobuf.Int64;
    import com.netease.protobuf.WriteUtils;
    import com.netease.protobuf.WritingBuffer;
    import com.zn.utils.StringUtil;
    
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class SocketUtil
    {
        public static function writeIdType(id:String, by:ByteArray):void
        {
            if (StringUtil.isEmpty(id))
                id = "0";

            var int64:Int64 = Int64.parseInt64(id);
            if (by.endian == Endian.LITTLE_ENDIAN)
            {
                by.writeInt(int64.low);
                by.writeInt(int64.high);
            }
            else
            {
				by.writeInt(int64.high);
				by.writeInt(int64.low);
            }
        }

        /**
         *
         * @param by
         * @return
         */
        public static function readIdType(by:ByteArray):String
        {
            return readIdTypeInt64(by).toString();
        }
		
		public static function readIdTypeInt64(by:ByteArray):Int64
		{
			var h:int;
			var l:int;
			
			if (by.endian == Endian.LITTLE_ENDIAN)
			{
				l = by.readInt();
				h = by.readInt();
			}
			else
			{
				h = by.readInt();
				l = by.readInt();
			}
			
			return new Int64(l,h);
		}
    }
}
