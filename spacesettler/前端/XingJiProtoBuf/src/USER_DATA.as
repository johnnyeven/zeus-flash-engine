package  {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	import BUFFER_DEF;
	import PLAYER1;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class USER_DATA extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYER1S:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("USER_DATA.player1s", "player1s", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return PLAYER1; });

		[ArrayElementType("PLAYER1")]
		public var player1s:Array = [];

		/**
		 *  @private
		 */
		public static const BUFFERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("USER_DATA.buffers", "buffers", (10100 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return BUFFER_DEF; });

		[ArrayElementType("BUFFER_DEF")]
		public var buffers:Array = [];

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("USER_DATA.reserved", "reserved", (10200 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var reserved$field:flash.utils.ByteArray;

		public function clearReserved():void {
			reserved$field = null;
		}

		public function get hasReserved():Boolean {
			return reserved$field != null;
		}

		public function set reserved(value:flash.utils.ByteArray):void {
			reserved$field = value;
		}

		public function get reserved():flash.utils.ByteArray {
			return reserved$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var player1s$index:uint = 0; player1s$index < this.player1s.length; ++player1s$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10000);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.player1s[player1s$index]);
			}
			for (var buffers$index:uint = 0; buffers$index < this.buffers.length; ++buffers$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10100);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.buffers[buffers$index]);
			}
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10200);
				com.netease.protobuf.WriteUtils.write$TYPE_BYTES(output, reserved$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					this.player1s.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new PLAYER1()));
					break;
				case 10100:
					this.buffers.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new BUFFER_DEF()));
					break;
				case 10200:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: USER_DATA.reserved cannot be set twice.');
					}
					++reserved$count;
					this.reserved = com.netease.protobuf.ReadUtils.read$TYPE_BYTES(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
