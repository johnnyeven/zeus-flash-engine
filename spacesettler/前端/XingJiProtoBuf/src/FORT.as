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
	import FORTBUILDING;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class FORT extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("FORT.id", "id", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:UInt64;

		/**
		 *  @private
		 */
		public static const PLAYER_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("FORT.player_id", "playerId", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var playerId:UInt64;

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.level", "level", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:uint;

		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.x", "x", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var x:uint;

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.y", "y", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var y:uint;

		/**
		 *  @private
		 */
		public static const Z:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.z", "z", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var z:uint;

		/**
		 *  @private
		 */
		public static const FORT_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.fort_type", "fortType", (10600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var fortType:uint;

		/**
		 *  @private
		 */
		public static const LAST_ATTACKED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.last_attacked_at", "lastAttackedAt", (10700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var lastAttackedAt:uint;

		/**
		 *  @private
		 */
		public static const FORT_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("FORT.fort_name", "fortName", (10800 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var fortName:String;

		/**
		 *  @private
		 */
		public static const BATTLE_STATUS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("FORT.battle_status", "battleStatus", (10900 << 3) | com.netease.protobuf.WireType.VARINT);

		public var battleStatus:int;

		/**
		 *  @private
		 */
		public static const BATTLE_IP_ADDR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.battle_ip_addr", "battleIpAddr", (11000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var battleIpAddr:uint;

		/**
		 *  @private
		 */
		public static const BATTLE_PORT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.battle_port", "battlePort", (11100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var battlePort:uint;

		/**
		 *  @private
		 */
		public static const BATTLE_PASSPORT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.battle_passport", "battlePassport", (11200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var battlePassport:uint;

		/**
		 *  @private
		 */
		public static const BATTLE_ROOM_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.battle_room_id", "battleRoomId", (11300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var battleRoomId:uint;

		/**
		 *  @private
		 */
		public static const CREATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.created_at", "createdAt", (11400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var createdAt:uint;

		/**
		 *  @private
		 */
		public static const UPDATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORT.updated_at", "updatedAt", (11500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var updatedAt:uint;

		/**
		 *  @private
		 */
		public static const FORTBUILDINGS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("FORT.fortbuildings", "fortbuildings", (11600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return FORTBUILDING; });

		[ArrayElementType("FORTBUILDING")]
		public var fortbuildings:Array = [];

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("FORT.reserved", "reserved", (11700 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.playerId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.level);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.x);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.y);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.z);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.fortType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10700);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.lastAttackedAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10800);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.fortName);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10900);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.battleStatus);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11000);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.battleIpAddr);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.battlePort);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.battlePassport);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.battleRoomId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.createdAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.updatedAt);
			for (var fortbuildings$index:uint = 0; fortbuildings$index < this.fortbuildings.length; ++fortbuildings$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 11600);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.fortbuildings[fortbuildings$index]);
			}
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 11700);
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
			var player_id$count:uint = 0;
			var level$count:uint = 0;
			var x$count:uint = 0;
			var y$count:uint = 0;
			var z$count:uint = 0;
			var fort_type$count:uint = 0;
			var last_attacked_at$count:uint = 0;
			var fort_name$count:uint = 0;
			var battle_status$count:uint = 0;
			var battle_ip_addr$count:uint = 0;
			var battle_port$count:uint = 0;
			var battle_passport$count:uint = 0;
			var battle_room_id$count:uint = 0;
			var created_at$count:uint = 0;
			var updated_at$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10100:
					if (player_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.playerId cannot be set twice.');
					}
					++player_id$count;
					this.playerId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10200:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10500:
					if (z$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.z cannot be set twice.');
					}
					++z$count;
					this.z = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10600:
					if (fort_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.fortType cannot be set twice.');
					}
					++fort_type$count;
					this.fortType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10700:
					if (last_attacked_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.lastAttackedAt cannot be set twice.');
					}
					++last_attacked_at$count;
					this.lastAttackedAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10800:
					if (fort_name$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.fortName cannot be set twice.');
					}
					++fort_name$count;
					this.fortName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10900:
					if (battle_status$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.battleStatus cannot be set twice.');
					}
					++battle_status$count;
					this.battleStatus = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11000:
					if (battle_ip_addr$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.battleIpAddr cannot be set twice.');
					}
					++battle_ip_addr$count;
					this.battleIpAddr = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11100:
					if (battle_port$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.battlePort cannot be set twice.');
					}
					++battle_port$count;
					this.battlePort = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11200:
					if (battle_passport$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.battlePassport cannot be set twice.');
					}
					++battle_passport$count;
					this.battlePassport = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11300:
					if (battle_room_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.battleRoomId cannot be set twice.');
					}
					++battle_room_id$count;
					this.battleRoomId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11400:
					if (created_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.createdAt cannot be set twice.');
					}
					++created_at$count;
					this.createdAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11500:
					if (updated_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.updatedAt cannot be set twice.');
					}
					++updated_at$count;
					this.updatedAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11600:
					this.fortbuildings.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new FORTBUILDING()));
					break;
				case 11700:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORT.reserved cannot be set twice.');
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
