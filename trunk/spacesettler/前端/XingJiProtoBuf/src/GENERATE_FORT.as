package  {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import RESOURCE_GENERATE;
	import OTHER;
	import BLUEMAP_LEVEL_GENERATE;
	import flash.utils.ByteArray;
	import BUFFER_DEF;
	import BLUEMAP_GENERATE;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class GENERATE_FORT extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FORT_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("GENERATE_FORT.fort_type", "fortType", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var fortType:uint;

		/**
		 *  @private
		 */
		public static const RESOURCES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("GENERATE_FORT.resources", "resources", (10100 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return RESOURCE_GENERATE; });

		[ArrayElementType("RESOURCE_GENERATE")]
		public var resources:Array = [];

		/**
		 *  @private
		 */
		public static const BLUEMAPS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("GENERATE_FORT.bluemaps", "bluemaps", (10200 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return BLUEMAP_GENERATE; });

		[ArrayElementType("BLUEMAP_GENERATE")]
		public var bluemaps:Array = [];

		/**
		 *  @private
		 */
		public static const BLUEMAP_LEVELS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("GENERATE_FORT.bluemap_levels", "bluemapLevels", (10300 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return BLUEMAP_LEVEL_GENERATE; });

		[ArrayElementType("BLUEMAP_LEVEL_GENERATE")]
		public var bluemapLevels:Array = [];

		/**
		 *  @private
		 */
		public static const OTHERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("GENERATE_FORT.others", "others", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return OTHER; });

		[ArrayElementType("OTHER")]
		public var others:Array = [];

		/**
		 *  @private
		 */
		public static const PLACED_BUFFERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("GENERATE_FORT.placed_buffers", "placedBuffers", (10500 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return BUFFER_DEF; });

		[ArrayElementType("BUFFER_DEF")]
		public var placedBuffers:Array = [];

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("GENERATE_FORT.reserved", "reserved", (10600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.fortType);
			for (var resources$index:uint = 0; resources$index < this.resources.length; ++resources$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10100);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.resources[resources$index]);
			}
			for (var bluemaps$index:uint = 0; bluemaps$index < this.bluemaps.length; ++bluemaps$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10200);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.bluemaps[bluemaps$index]);
			}
			for (var bluemapLevels$index:uint = 0; bluemapLevels$index < this.bluemapLevels.length; ++bluemapLevels$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10300);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.bluemapLevels[bluemapLevels$index]);
			}
			for (var others$index:uint = 0; others$index < this.others.length; ++others$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10400);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.others[others$index]);
			}
			for (var placedBuffers$index:uint = 0; placedBuffers$index < this.placedBuffers.length; ++placedBuffers$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10500);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.placedBuffers[placedBuffers$index]);
			}
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
			var fort_type$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (fort_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: GENERATE_FORT.fortType cannot be set twice.');
					}
					++fort_type$count;
					this.fortType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10100:
					this.resources.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new RESOURCE_GENERATE()));
					break;
				case 10200:
					this.bluemaps.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new BLUEMAP_GENERATE()));
					break;
				case 10300:
					this.bluemapLevels.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new BLUEMAP_LEVEL_GENERATE()));
					break;
				case 10400:
					this.others.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new OTHER()));
					break;
				case 10500:
					this.placedBuffers.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new BUFFER_DEF()));
					break;
				case 10600:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: GENERATE_FORT.reserved cannot be set twice.');
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
