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
	import CHARIOT;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class BUFFER_DEF extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BUFFER_DEF.type", "type", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var type:uint;

		/**
		 *  @private
		 */
		public static const SUB_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BUFFER_DEF.sub_type", "subType", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var subType:uint;

		/**
		 *  @private
		 */
		public static const INDEX:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BUFFER_DEF.index", "index", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var index:uint;

		/**
		 *  @private
		 */
		public static const DELTA:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BUFFER_DEF.delta", "delta", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var delta:uint;

		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BUFFER_DEF.x", "x", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var x:uint;

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("BUFFER_DEF.y", "y", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var y:uint;

		/**
		 *  @private
		 */
		public static const WINGMAN:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("BUFFER_DEF.wingman", "wingman", (10600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return CHARIOT; });

		[ArrayElementType("CHARIOT")]
		public var wingman:Array = [];

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("BUFFER_DEF.reserved", "reserved", (10700 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.subType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.index);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.delta);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.x);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.y);
			for (var wingman$index:uint = 0; wingman$index < this.wingman.length; ++wingman$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10600);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.wingman[wingman$index]);
			}
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10700);
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
			var type$count:uint = 0;
			var sub_type$count:uint = 0;
			var index$count:uint = 0;
			var delta$count:uint = 0;
			var x$count:uint = 0;
			var y$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10100:
					if (sub_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.subType cannot be set twice.');
					}
					++sub_type$count;
					this.subType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (index$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.index cannot be set twice.');
					}
					++index$count;
					this.index = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (delta$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.delta cannot be set twice.');
					}
					++delta$count;
					this.delta = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10500:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10600:
					this.wingman.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new CHARIOT()));
					break;
				case 10700:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: BUFFER_DEF.reserved cannot be set twice.');
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
