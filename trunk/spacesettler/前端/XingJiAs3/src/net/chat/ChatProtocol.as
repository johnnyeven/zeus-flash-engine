package net.chat
{
	import flash.utils.Dictionary;

	public class ChatProtocol
	{
		//key:* 	,	value:array:Function
		private static var _protocolDic:Dictionary = new Dictionary();
		
		/**
		 *注册协议
		 * @param commandId
		 * @param callFunction
		 *
		 */
		public static function registerProtocol(commandId:*, callFunction:Function):void
		{
			if (!_protocolDic[commandId])
				_protocolDic[commandId] = new Vector.<Function>();
			
			_protocolDic[commandId].push(callFunction);
		}
		
		/**
		 *删除协议
		 * @param commandId
		 *
		 */
		public static function deleteProtocol(commandId:*):void
		{
			delete _protocolDic[commandId];
		}
		
		/**
		 * 注销协议中的方法
		 * @param commandId
		 * @param callFunction
		 *
		 */
		public static function deleteProtocolFunction(commandId:*, callFunction:Function):void
		{
			if (_protocolDic[commandId])
			{
				var v:Vector.<Function> = Vector.<Function>(_protocolDic[commandId]);
				
				var index:int = v.indexOf(callFunction);
				if (index != -1)
					v.splice(index, 1);
			}
		}
		
		/**
		 *根据协议获取注册的方法列表
		 * @param commandId
		 * @return
		 *
		 */
		public static function getProtocolFunctionList(commandId:*):Vector.<Function>
		{
			if (_protocolDic[commandId])
				return Vector.<Function>(_protocolDic[commandId]);
			else
				return new Vector.<Function>();
		}
		
		/**
		 *是否已注册这个协议 
		 * @param commandId
		 * @param callFunction
		 * @return 
		 * 
		 */		
		public static function hasProtocolFunction(commandId:*, callFunction:Function):Boolean
		{
			if (_protocolDic[commandId])
			{
				var v:Vector.<Function> = Vector.<Function>(_protocolDic[commandId]);
				
				var index:int = v.indexOf(callFunction);
				if (index != -1)
					return true;
			}
			
			return false;
		}
	}
}