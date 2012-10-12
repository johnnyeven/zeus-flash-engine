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
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class SESSION_KEY extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SESSION_KEY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("SESSION_KEY.session_key", "sessionKey", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var sessionKey:String;

		/**
		 *  @private
		 */
		public static const EXPIRED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("SESSION_KEY.expired_at", "expiredAt", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var expiredAt:uint;

		/**
		 *  @private
		 */
		public static const PLAYER_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("SESSION_KEY.player_id", "playerId", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var playerId:UInt64;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("SESSION_KEY.reserved", "reserved", (10300 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10000);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.sessionKey);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.expiredAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.playerId);
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10300);
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
			var session_key$count:uint = 0;
			var expired_at$count:uint = 0;
			var player_id$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (session_key$count != 0) {
						throw new flash.errors.IOError('Bad data format: SESSION_KEY.sessionKey cannot be set twice.');
					}
					++session_key$count;
					this.sessionKey = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10100:
					if (expired_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: SESSION_KEY.expiredAt cannot be set twice.');
					}
					++expired_at$count;
					this.expiredAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (player_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: SESSION_KEY.playerId cannot be set twice.');
					}
					++player_id$count;
					this.playerId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10300:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: SESSION_KEY.reserved cannot be set twice.');
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
