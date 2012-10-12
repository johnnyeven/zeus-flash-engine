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
	import RESOURCE_OUTPUT;
	import CHARIOT;
	import FORTBUILDING;
	import GENERATE_FORT;
	import POSITION;
	import TANKPART;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class ALL_CONFIGURE extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FORTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.forts", "forts", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return GENERATE_FORT; });

		[ArrayElementType("GENERATE_FORT")]
		public var forts:Array = [];

		/**
		 *  @private
		 */
		public static const NPCS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.npcs", "npcs", (10100 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return CHARIOT; });

		[ArrayElementType("CHARIOT")]
		public var npcs:Array = [];

		/**
		 *  @private
		 */
		public static const NPC_TANKPARTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.npc_tankparts", "npcTankparts", (10200 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return TANKPART; });

		[ArrayElementType("TANKPART")]
		public var npcTankparts:Array = [];

		/**
		 *  @private
		 */
		public static const TURRET_CENTERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.turret_centers", "turretCenters", (10300 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return FORTBUILDING; });

		[ArrayElementType("FORTBUILDING")]
		public var turretCenters:Array = [];

		/**
		 *  @private
		 */
		public static const TURRETS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.turrets", "turrets", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return FORTBUILDING; });

		[ArrayElementType("FORTBUILDING")]
		public var turrets:Array = [];

		/**
		 *  @private
		 */
		public static const POSITIONS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.positions", "positions", (10500 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return POSITION; });

		[ArrayElementType("POSITION")]
		public var positions:Array = [];

		/**
		 *  @private
		 */
		public static const OUTPUTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.outputs", "outputs", (10600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return RESOURCE_OUTPUT; });

		[ArrayElementType("RESOURCE_OUTPUT")]
		public var outputs:Array = [];

		/**
		 *  @private
		 */
		public static const PICKUP_POSS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.pickup_poss", "pickupPoss", (10700 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return POSITION; });

		[ArrayElementType("POSITION")]
		public var pickupPoss:Array = [];

		/**
		 *  @private
		 */
		public static const BUFFER_TANKPARTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("ALL_CONFIGURE.buffer_tankparts", "bufferTankparts", (10800 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return TANKPART; });

		[ArrayElementType("TANKPART")]
		public var bufferTankparts:Array = [];

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("ALL_CONFIGURE.reserved", "reserved", (10900 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			for (var forts$index:uint = 0; forts$index < this.forts.length; ++forts$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10000);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.forts[forts$index]);
			}
			for (var npcs$index:uint = 0; npcs$index < this.npcs.length; ++npcs$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10100);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.npcs[npcs$index]);
			}
			for (var npcTankparts$index:uint = 0; npcTankparts$index < this.npcTankparts.length; ++npcTankparts$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10200);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.npcTankparts[npcTankparts$index]);
			}
			for (var turretCenters$index:uint = 0; turretCenters$index < this.turretCenters.length; ++turretCenters$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10300);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.turretCenters[turretCenters$index]);
			}
			for (var turrets$index:uint = 0; turrets$index < this.turrets.length; ++turrets$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10400);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.turrets[turrets$index]);
			}
			for (var positions$index:uint = 0; positions$index < this.positions.length; ++positions$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10500);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.positions[positions$index]);
			}
			for (var outputs$index:uint = 0; outputs$index < this.outputs.length; ++outputs$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10600);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.outputs[outputs$index]);
			}
			for (var pickupPoss$index:uint = 0; pickupPoss$index < this.pickupPoss.length; ++pickupPoss$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10700);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.pickupPoss[pickupPoss$index]);
			}
			for (var bufferTankparts$index:uint = 0; bufferTankparts$index < this.bufferTankparts.length; ++bufferTankparts$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10800);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.bufferTankparts[bufferTankparts$index]);
			}
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10900);
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
					this.forts.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new GENERATE_FORT()));
					break;
				case 10100:
					this.npcs.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new CHARIOT()));
					break;
				case 10200:
					this.npcTankparts.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new TANKPART()));
					break;
				case 10300:
					this.turretCenters.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new FORTBUILDING()));
					break;
				case 10400:
					this.turrets.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new FORTBUILDING()));
					break;
				case 10500:
					this.positions.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new POSITION()));
					break;
				case 10600:
					this.outputs.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new RESOURCE_OUTPUT()));
					break;
				case 10700:
					this.pickupPoss.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new POSITION()));
					break;
				case 10800:
					this.bufferTankparts.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new TANKPART()));
					break;
				case 10900:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: ALL_CONFIGURE.reserved cannot be set twice.');
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
