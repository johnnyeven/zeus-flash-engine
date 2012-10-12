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
	public dynamic final class PLAYER extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("PLAYER.id", "id", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:UInt64;

		/**
		 *  @private
		 */
		public static const BASE_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("PLAYER.base_id", "baseId", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var baseId:UInt64;

		/**
		 *  @private
		 */
		public static const SESSION_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("PLAYER.session_id", "sessionId", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var sessionId:UInt64;

		/**
		 *  @private
		 */
		public static const OFFICER_ID:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("PLAYER.officer_id", "officerId", (10300 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var officerId:String;

		/**
		 *  @private
		 */
		public static const NICKNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("PLAYER.nickname", "nickname", (10400 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var nickname:String;

		/**
		 *  @private
		 */
		public static const MILITARY_RANK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER.military_rank", "militaryRank", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var militaryRank:uint;

		/**
		 *  @private
		 */
		public static const HONOUR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER.honour", "honour", (10600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var honour:uint;

		/**
		 *  @private
		 */
		public static const DARK_CRYSTAL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("PLAYER.dark_crystal", "darkCrystal", (10700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var darkCrystal:int;

		/**
		 *  @private
		 */
		public static const DEVICE_TOKEN:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("PLAYER.device_token", "deviceToken", (10800 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var deviceToken:String;

		/**
		 *  @private
		 */
		public static const PLAYER_TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("PLAYER.player_type", "playerType", (10900 << 3) | com.netease.protobuf.WireType.VARINT);

		public var playerType:int;

		/**
		 *  @private
		 */
		public static const CREATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER.created_at", "createdAt", (11000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var createdAt:uint;

		/**
		 *  @private
		 */
		public static const UPDATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("PLAYER.updated_at", "updatedAt", (11100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var updatedAt:uint;

		/**
		 *  @private
		 */
		public static const AGE_LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("PLAYER.age_level", "ageLevel", (11200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var ageLevel:int;

		/**
		 *  @private
		 */
		public static const COLLECTING_FACTORY_COUNT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("PLAYER.collecting_factory_count", "collectingFactoryCount", (11300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var collectingFactoryCount:int;

		/**
		 *  @private
		 */
		public static const PACKAGE_SIZE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("PLAYER.package_size", "packageSize", (11400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var packageSize:int;

		/**
		 *  @private
		 */
		public static const PACKAGE_USE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("PLAYER.package_use", "packageUse", (11500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var packageUse:int;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("PLAYER.reserved", "reserved", (11600 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.baseId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.sessionId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.officerId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.nickname);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.militaryRank);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.honour);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10700);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.darkCrystal);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 10800);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.deviceToken);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10900);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.playerType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11000);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.createdAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11100);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.updatedAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11200);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.ageLevel);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11300);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.collectingFactoryCount);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11400);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.packageSize);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11500);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.packageUse);
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
			var id$count:uint = 0;
			var base_id$count:uint = 0;
			var session_id$count:uint = 0;
			var officer_id$count:uint = 0;
			var nickname$count:uint = 0;
			var military_rank$count:uint = 0;
			var honour$count:uint = 0;
			var dark_crystal$count:uint = 0;
			var device_token$count:uint = 0;
			var player_type$count:uint = 0;
			var created_at$count:uint = 0;
			var updated_at$count:uint = 0;
			var age_level$count:uint = 0;
			var collecting_factory_count$count:uint = 0;
			var package_size$count:uint = 0;
			var package_use$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10100:
					if (base_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.baseId cannot be set twice.');
					}
					++base_id$count;
					this.baseId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10200:
					if (session_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.sessionId cannot be set twice.');
					}
					++session_id$count;
					this.sessionId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10300:
					if (officer_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.officerId cannot be set twice.');
					}
					++officer_id$count;
					this.officerId = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10400:
					if (nickname$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.nickname cannot be set twice.');
					}
					++nickname$count;
					this.nickname = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10500:
					if (military_rank$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.militaryRank cannot be set twice.');
					}
					++military_rank$count;
					this.militaryRank = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10600:
					if (honour$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.honour cannot be set twice.');
					}
					++honour$count;
					this.honour = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10700:
					if (dark_crystal$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.darkCrystal cannot be set twice.');
					}
					++dark_crystal$count;
					this.darkCrystal = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10800:
					if (device_token$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.deviceToken cannot be set twice.');
					}
					++device_token$count;
					this.deviceToken = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 10900:
					if (player_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.playerType cannot be set twice.');
					}
					++player_type$count;
					this.playerType = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11000:
					if (created_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.createdAt cannot be set twice.');
					}
					++created_at$count;
					this.createdAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11100:
					if (updated_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.updatedAt cannot be set twice.');
					}
					++updated_at$count;
					this.updatedAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11200:
					if (age_level$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.ageLevel cannot be set twice.');
					}
					++age_level$count;
					this.ageLevel = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11300:
					if (collecting_factory_count$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.collectingFactoryCount cannot be set twice.');
					}
					++collecting_factory_count$count;
					this.collectingFactoryCount = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11400:
					if (package_size$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.packageSize cannot be set twice.');
					}
					++package_size$count;
					this.packageSize = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11500:
					if (package_use$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.packageUse cannot be set twice.');
					}
					++package_use$count;
					this.packageUse = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11600:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: PLAYER.reserved cannot be set twice.');
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
