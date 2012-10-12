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
	public dynamic final class PLAYER_BASE extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("PLAYER_BASE.id", "id", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:UInt64;

		/**
		 *  @private
		 */
		public static const CRYSTAL_OUTPUT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER_BASE.crystal_output", "crystalOutput", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var crystalOutput:uint;

		/**
		 *  @private
		 */
		public static const TRITIUM_OUTPUT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER_BASE.tritium_output", "tritiumOutput", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var tritiumOutput:uint;

		/**
		 *  @private
		 */
		public static const BROKEN_CRYSTAL_OUTPUT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER_BASE.broken_crystal_output", "brokenCrystalOutput", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var brokenCrystalOutput:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("PLAYER_BASE.reserved", "reserved", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10000);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.id);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.crystalOutput);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.tritiumOutput);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.brokenCrystalOutput);
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
			var id$count:uint = 0;
			var crystal_output$count:uint = 0;
			var tritium_output$count:uint = 0;
			var broken_crystal_output$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER_BASE.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10100:
					if (crystal_output$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER_BASE.crystalOutput cannot be set twice.');
					}
					++crystal_output$count;
					this.crystalOutput = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (tritium_output$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER_BASE.tritiumOutput cannot be set twice.');
					}
					++tritium_output$count;
					this.tritiumOutput = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (broken_crystal_output$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER_BASE.brokenCrystalOutput cannot be set twice.');
					}
					++broken_crystal_output$count;
					this.brokenCrystalOutput = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER_BASE.reserved cannot be set twice.');
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
