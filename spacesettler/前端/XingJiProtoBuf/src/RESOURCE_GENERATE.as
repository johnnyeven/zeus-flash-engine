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
	public dynamic final class RESOURCE_GENERATE extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("RESOURCE_GENERATE.name", "name", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var name:String;

		/**
		 *  @private
		 */
		public static const BASE_VOLUME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("RESOURCE_GENERATE.base_volume", "baseVolume", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var baseVolume:uint;

		/**
		 *  @private
		 */
		public static const ON_DESTROY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("RESOURCE_GENERATE.on_destroy", "onDestroy", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var onDestroy:uint;

		/**
		 *  @private
		 */
		public static const FACTOR_RESULT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("RESOURCE_GENERATE.factor_result", "factorResult", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var factorResult:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("RESOURCE_GENERATE.reserved", "reserved", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.name);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.baseVolume);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.onDestroy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.factorResult);
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
			var name$count:uint = 0;
			var base_volume$count:uint = 0;
			var on_destroy$count:uint = 0;
			var factor_result$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: RESOURCE_GENERATE.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10100:
					if (base_volume$count != 0) {
						throw new flash.errors.IOError('Bad data format: RESOURCE_GENERATE.baseVolume cannot be set twice.');
					}
					++base_volume$count;
					this.baseVolume = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (on_destroy$count != 0) {
						throw new flash.errors.IOError('Bad data format: RESOURCE_GENERATE.onDestroy cannot be set twice.');
					}
					++on_destroy$count;
					this.onDestroy = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (factor_result$count != 0) {
						throw new flash.errors.IOError('Bad data format: RESOURCE_GENERATE.factorResult cannot be set twice.');
					}
					++factor_result$count;
					this.factorResult = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: RESOURCE_GENERATE.reserved cannot be set twice.');
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
