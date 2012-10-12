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
	public dynamic final class BLUEMAP_LEVEL_GENERATE extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BASE_FACTOR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_LEVEL_GENERATE.base_factor", "baseFactor", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var baseFactor:uint;

		/**
		 *  @private
		 */
		public static const ON_DESTROY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_LEVEL_GENERATE.on_destroy", "onDestroy", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var onDestroy:uint;

		/**
		 *  @private
		 */
		public static const REQUIRED_FORBUILDING_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_LEVEL_GENERATE.required_forbuilding_level", "requiredForbuildingLevel", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var requiredForbuildingLevel:uint;

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_LEVEL_GENERATE.level", "level", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("BLUEMAP_LEVEL_GENERATE.reserved", "reserved", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.baseFactor);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.onDestroy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.requiredForbuildingLevel);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.level);
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
			var base_factor$count:uint = 0;
			var on_destroy$count:uint = 0;
			var required_forbuilding_level$count:uint = 0;
			var level$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (base_factor$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_LEVEL_GENERATE.baseFactor cannot be set twice.');
					}
					++base_factor$count;
					this.baseFactor = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10100:
					if (on_destroy$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_LEVEL_GENERATE.onDestroy cannot be set twice.');
					}
					++on_destroy$count;
					this.onDestroy = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (required_forbuilding_level$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_LEVEL_GENERATE.requiredForbuildingLevel cannot be set twice.');
					}
					++required_forbuilding_level$count;
					this.requiredForbuildingLevel = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_LEVEL_GENERATE.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_LEVEL_GENERATE.reserved cannot be set twice.');
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
