package  {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import PLAYER;
	import flash.utils.ByteArray;
	import FORT;
	import CHARIOT;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class PLAYER1 extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("PLAYER1.players", "players", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return PLAYER; });

		[ArrayElementType("PLAYER")]
		public var players:Array = [];

		/**
		 *  @private
		 */
		public static const FORTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("PLAYER1.forts", "forts", (10100 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return FORT; });

		[ArrayElementType("FORT")]
		public var forts:Array = [];

		/**
		 *  @private
		 */
		public static const CHARIOTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("PLAYER1.chariots", "chariots", (10200 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return CHARIOT; });

		[ArrayElementType("CHARIOT")]
		public var chariots:Array = [];

		/**
		 *  @private
		 */
		public static const GID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER1.gid", "gid", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var gid:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("PLAYER1.reserved", "reserved", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			for (var players$index:uint = 0; players$index < this.players.length; ++players$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10000);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.players[players$index]);
			}
			for (var forts$index:uint = 0; forts$index < this.forts.length; ++forts$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10100);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.forts[forts$index]);
			}
			for (var chariots$index:uint = 0; chariots$index < this.chariots.length; ++chariots$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10200);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.chariots[chariots$index]);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.gid);
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10400);
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
			var gid$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					this.players.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new PLAYER()));
					break;
				case 10100:
					this.forts.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new FORT()));
					break;
				case 10200:
					this.chariots.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new CHARIOT()));
					break;
				case 10300:
					if (gid$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER1.gid cannot be set twice.');
					}
					++gid$count;
					this.gid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER1.reserved cannot be set twice.');
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
