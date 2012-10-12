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
	public dynamic final class BLUEMAP_GENERATE extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("BLUEMAP_GENERATE.name", "name", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var name:String;

		/**
		 *  @private
		 */
		public static const BASE_FACTOR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_GENERATE.base_factor", "baseFactor", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var baseFactor:uint;

		/**
		 *  @private
		 */
		public static const ON_DESTROY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_GENERATE.on_destroy", "onDestroy", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var onDestroy:uint;

		/**
		 *  @private
		 */
		public static const REQUIRE_FORBUILDING_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_GENERATE.require_forbuilding_type", "requireForbuildingType", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var requireForbuildingType:uint;

		/**
		 *  @private
		 */
		public static const RECIPES_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_GENERATE.recipes_type", "recipesType", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var recipesType:uint;

		/**
		 *  @private
		 */
		public static const RECIPES_CATEGORY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BLUEMAP_GENERATE.recipes_category", "recipesCategory", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var recipesCategory:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("BLUEMAP_GENERATE.reserved", "reserved", (10600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.baseFactor);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.onDestroy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.requireForbuildingType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.recipesType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.recipesCategory);
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10600);
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
			var base_factor$count:uint = 0;
			var on_destroy$count:uint = 0;
			var require_forbuilding_type$count:uint = 0;
			var recipes_type$count:uint = 0;
			var recipes_category$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10100:
					if (base_factor$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.baseFactor cannot be set twice.');
					}
					++base_factor$count;
					this.baseFactor = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (on_destroy$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.onDestroy cannot be set twice.');
					}
					++on_destroy$count;
					this.onDestroy = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (require_forbuilding_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.requireForbuildingType cannot be set twice.');
					}
					++require_forbuilding_type$count;
					this.requireForbuildingType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (recipes_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.recipesType cannot be set twice.');
					}
					++recipes_type$count;
					this.recipesType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10500:
					if (recipes_category$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.recipesCategory cannot be set twice.');
					}
					++recipes_category$count;
					this.recipesCategory = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10600:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: BLUEMAP_GENERATE.reserved cannot be set twice.');
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
