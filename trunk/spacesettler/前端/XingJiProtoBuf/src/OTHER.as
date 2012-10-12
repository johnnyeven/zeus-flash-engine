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
	public dynamic final class OTHER extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("OTHER.name", "name", (10000 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var name:String;

		/**
		 *  @private
		 */
		public static const FORT_CENTER_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("OTHER.fort_center_level", "fortCenterLevel", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var fortCenterLevel:uint;

		/**
		 *  @private
		 */
		public static const REFRESH_TIMEOUT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("OTHER.refresh_timeout", "refreshTimeout", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var refreshTimeout:uint;

		/**
		 *  @private
		 */
		public static const TURRET_TYPE:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.turret_type", "turretType", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var turretType:UInt64;

		/**
		 *  @private
		 */
		public static const TURRET_POS:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.turret_pos", "turretPos", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var turretPos:UInt64;

		/**
		 *  @private
		 */
		public static const BUFFER_POS:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.buffer_pos", "bufferPos", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var bufferPos:UInt64;

		/**
		 *  @private
		 */
		public static const FACTOR_ENDURANCE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("OTHER.factor_endurance", "factorEndurance", (10600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var factorEndurance:uint;

		/**
		 *  @private
		 */
		public static const FACTOR_SHIELD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("OTHER.factor_shield", "factorShield", (10700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var factorShield:uint;

		/**
		 *  @private
		 */
		public static const FACTOR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("OTHER.factor", "factor", (10800 << 3) | com.netease.protobuf.WireType.VARINT);

		public var factor:uint;

		/**
		 *  @private
		 */
		public static const NPC_BOMB:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.npc_bomb", "npcBomb", (10900 << 3) | com.netease.protobuf.WireType.VARINT);

		public var npcBomb:UInt64;

		/**
		 *  @private
		 */
		public static const NPC_BOMB_TANKPART:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.npc_bomb_tankpart", "npcBombTankpart", (11000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var npcBombTankpart:UInt64;

		/**
		 *  @private
		 */
		public static const NPC_CHARIOT:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.npc_chariot", "npcChariot", (11100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var npcChariot:UInt64;

		/**
		 *  @private
		 */
		public static const NPC_CHARIOT_TANKPART:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.npc_chariot_tankpart", "npcChariotTankpart", (11200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var npcChariotTankpart:UInt64;

		/**
		 *  @private
		 */
		public static const XYZ:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("OTHER.xyz", "xyz", (11300 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var xyz:String;

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("OTHER.type", "type", (11400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var type:uint;

		/**
		 *  @private
		 */
		public static const FORT_CENTER_INDEX:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("OTHER.fort_center_index", "fortCenterIndex", (11500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var fortCenterIndex:UInt64;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("OTHER.reserved", "reserved", (11600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.fortCenterLevel);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.refreshTimeout);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.turretType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.turretPos);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.bufferPos);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.factorEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10700);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.factorShield);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10800);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.factor);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10900);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.npcBomb);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11000);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.npcBombTankpart);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.npcChariot);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.npcChariotTankpart);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 11300);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.xyz);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.fortCenterIndex);
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 11600);
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
			var fort_center_level$count:uint = 0;
			var refresh_timeout$count:uint = 0;
			var turret_type$count:uint = 0;
			var turret_pos$count:uint = 0;
			var buffer_pos$count:uint = 0;
			var factor_endurance$count:uint = 0;
			var factor_shield$count:uint = 0;
			var factor$count:uint = 0;
			var npc_bomb$count:uint = 0;
			var npc_bomb_tankpart$count:uint = 0;
			var npc_chariot$count:uint = 0;
			var npc_chariot_tankpart$count:uint = 0;
			var xyz$count:uint = 0;
			var type$count:uint = 0;
			var fort_center_index$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10100:
					if (fort_center_level$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.fortCenterLevel cannot be set twice.');
					}
					++fort_center_level$count;
					this.fortCenterLevel = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10200:
					if (refresh_timeout$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.refreshTimeout cannot be set twice.');
					}
					++refresh_timeout$count;
					this.refreshTimeout = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (turret_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.turretType cannot be set twice.');
					}
					++turret_type$count;
					this.turretType = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10400:
					if (turret_pos$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.turretPos cannot be set twice.');
					}
					++turret_pos$count;
					this.turretPos = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10500:
					if (buffer_pos$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.bufferPos cannot be set twice.');
					}
					++buffer_pos$count;
					this.bufferPos = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10600:
					if (factor_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.factorEndurance cannot be set twice.');
					}
					++factor_endurance$count;
					this.factorEndurance = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10700:
					if (factor_shield$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.factorShield cannot be set twice.');
					}
					++factor_shield$count;
					this.factorShield = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10800:
					if (factor$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.factor cannot be set twice.');
					}
					++factor$count;
					this.factor = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10900:
					if (npc_bomb$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.npcBomb cannot be set twice.');
					}
					++npc_bomb$count;
					this.npcBomb = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 11000:
					if (npc_bomb_tankpart$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.npcBombTankpart cannot be set twice.');
					}
					++npc_bomb_tankpart$count;
					this.npcBombTankpart = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 11100:
					if (npc_chariot$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.npcChariot cannot be set twice.');
					}
					++npc_chariot$count;
					this.npcChariot = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 11200:
					if (npc_chariot_tankpart$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.npcChariotTankpart cannot be set twice.');
					}
					++npc_chariot_tankpart$count;
					this.npcChariotTankpart = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 11300:
					if (xyz$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.xyz cannot be set twice.');
					}
					++xyz$count;
					this.xyz = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 11400:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11500:
					if (fort_center_index$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.fortCenterIndex cannot be set twice.');
					}
					++fort_center_index$count;
					this.fortCenterIndex = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 11600:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: OTHER.reserved cannot be set twice.');
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
