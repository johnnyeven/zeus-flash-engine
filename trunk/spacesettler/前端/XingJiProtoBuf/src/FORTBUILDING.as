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
	public dynamic final class FORTBUILDING extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("FORTBUILDING.id", "id", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:UInt64;

		/**
		 *  @private
		 */
		public static const FORT_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("FORTBUILDING.fort_id", "fortId", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var fortId:UInt64;

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.type", "type", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var type:uint;

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.level", "level", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:uint;

		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.x", "x", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var x:uint;

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.y", "y", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var y:uint;

		/**
		 *  @private
		 */
		public static const POWER_SUPPLY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.power_supply", "powerSupply", (10600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var powerSupply:uint;

		/**
		 *  @private
		 */
		public static const POWER_CONSUME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.power_consume", "powerConsume", (10700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var powerConsume:uint;

		/**
		 *  @private
		 */
		public static const ATTACK_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.attack_type", "attackType", (10800 << 3) | com.netease.protobuf.WireType.VARINT);

		public var attackType:uint;

		/**
		 *  @private
		 */
		public static const BASIC_MIN_ATTACK:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.basic_min_attack", "basicMinAttack", (10900 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicMinAttack:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_MIN_ATTACK:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.current_min_attack", "currentMinAttack", (11000 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentMinAttack:Number;

		/**
		 *  @private
		 */
		public static const BASIC_MAX_ATTACK:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.basic_max_attack", "basicMaxAttack", (11100 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicMaxAttack:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_MAX_ATTACK:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.current_max_attack", "currentMaxAttack", (11200 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentMaxAttack:Number;

		/**
		 *  @private
		 */
		public static const BASIC_ATTACK_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.basic_attack_area", "basicAttackArea", (11300 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicAttackArea:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_ATTACK_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.current_attack_area", "currentAttackArea", (11400 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentAttackArea:Number;

		/**
		 *  @private
		 */
		public static const BASIC_ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.basic_endurance", "basicEndurance", (11500 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicEndurance:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.current_endurance", "currentEndurance", (11600 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentEndurance:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.total_endurance", "totalEndurance", (11700 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalEndurance:Number;

		/**
		 *  @private
		 */
		public static const BASIC_REPAIR_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.basic_repair_speed", "basicRepairSpeed", (11800 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicRepairSpeed:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_REPAIR_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.current_repair_speed", "currentRepairSpeed", (11900 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentRepairSpeed:Number;

		/**
		 *  @private
		 */
		public static const ATTACK_RANGE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.attack_range", "attackRange", (12000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var attackRange:uint;

		/**
		 *  @private
		 */
		public static const BASIC_ATTACK_COOL_DOWN:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.basic_attack_cool_down", "basicAttackCoolDown", (12100 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicAttackCoolDown:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_ATTACK_COOL_DOWN:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("FORTBUILDING.current_attack_cool_down", "currentAttackCoolDown", (12200 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentAttackCoolDown:Number;

		/**
		 *  @private
		 */
		public static const RECOVERY_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.recovery_at", "recoveryAt", (12300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var recoveryAt:uint;

		/**
		 *  @private
		 */
		public static const CREATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.created_at", "createdAt", (12400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var createdAt:uint;

		/**
		 *  @private
		 */
		public static const UPDATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.updated_at", "updatedAt", (12500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var updatedAt:uint;

		/**
		 *  @private
		 */
		public static const GID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.gid", "gid", (12600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var gid:uint;

		/**
		 *  @private
		 */
		public static const SEARCH_AREA:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("FORTBUILDING.search_area", "searchArea", (12700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var searchArea:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("FORTBUILDING.reserved", "reserved", (12800 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.fortId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.level);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.x);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.y);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.powerSupply);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10700);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.powerConsume);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10800);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.attackType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 10900);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicMinAttack);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11000);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentMinAttack);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11100);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicMaxAttack);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11200);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentMaxAttack);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11300);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicAttackArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11400);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentAttackArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11500);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11600);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11700);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11800);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicRepairSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11900);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentRepairSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12000);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.attackRange);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12100);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicAttackCoolDown);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12200);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentAttackCoolDown);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12300);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.recoveryAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.createdAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.updatedAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.gid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12700);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.searchArea);
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 12800);
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
			var fort_id$count:uint = 0;
			var type$count:uint = 0;
			var level$count:uint = 0;
			var x$count:uint = 0;
			var y$count:uint = 0;
			var power_supply$count:uint = 0;
			var power_consume$count:uint = 0;
			var attack_type$count:uint = 0;
			var basic_min_attack$count:uint = 0;
			var current_min_attack$count:uint = 0;
			var basic_max_attack$count:uint = 0;
			var current_max_attack$count:uint = 0;
			var basic_attack_area$count:uint = 0;
			var current_attack_area$count:uint = 0;
			var basic_endurance$count:uint = 0;
			var current_endurance$count:uint = 0;
			var total_endurance$count:uint = 0;
			var basic_repair_speed$count:uint = 0;
			var current_repair_speed$count:uint = 0;
			var attack_range$count:uint = 0;
			var basic_attack_cool_down$count:uint = 0;
			var current_attack_cool_down$count:uint = 0;
			var recovery_at$count:uint = 0;
			var created_at$count:uint = 0;
			var updated_at$count:uint = 0;
			var gid$count:uint = 0;
			var search_area$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10100:
					if (fort_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.fortId cannot be set twice.');
					}
					++fort_id$count;
					this.fortId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10200:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10300:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10400:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10500:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10600:
					if (power_supply$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.powerSupply cannot be set twice.');
					}
					++power_supply$count;
					this.powerSupply = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10700:
					if (power_consume$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.powerConsume cannot be set twice.');
					}
					++power_consume$count;
					this.powerConsume = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10800:
					if (attack_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.attackType cannot be set twice.');
					}
					++attack_type$count;
					this.attackType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10900:
					if (basic_min_attack$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.basicMinAttack cannot be set twice.');
					}
					++basic_min_attack$count;
					this.basicMinAttack = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11000:
					if (current_min_attack$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.currentMinAttack cannot be set twice.');
					}
					++current_min_attack$count;
					this.currentMinAttack = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11100:
					if (basic_max_attack$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.basicMaxAttack cannot be set twice.');
					}
					++basic_max_attack$count;
					this.basicMaxAttack = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11200:
					if (current_max_attack$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.currentMaxAttack cannot be set twice.');
					}
					++current_max_attack$count;
					this.currentMaxAttack = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11300:
					if (basic_attack_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.basicAttackArea cannot be set twice.');
					}
					++basic_attack_area$count;
					this.basicAttackArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11400:
					if (current_attack_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.currentAttackArea cannot be set twice.');
					}
					++current_attack_area$count;
					this.currentAttackArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11500:
					if (basic_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.basicEndurance cannot be set twice.');
					}
					++basic_endurance$count;
					this.basicEndurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11600:
					if (current_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.currentEndurance cannot be set twice.');
					}
					++current_endurance$count;
					this.currentEndurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11700:
					if (total_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.totalEndurance cannot be set twice.');
					}
					++total_endurance$count;
					this.totalEndurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11800:
					if (basic_repair_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.basicRepairSpeed cannot be set twice.');
					}
					++basic_repair_speed$count;
					this.basicRepairSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11900:
					if (current_repair_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.currentRepairSpeed cannot be set twice.');
					}
					++current_repair_speed$count;
					this.currentRepairSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12000:
					if (attack_range$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.attackRange cannot be set twice.');
					}
					++attack_range$count;
					this.attackRange = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12100:
					if (basic_attack_cool_down$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.basicAttackCoolDown cannot be set twice.');
					}
					++basic_attack_cool_down$count;
					this.basicAttackCoolDown = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12200:
					if (current_attack_cool_down$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.currentAttackCoolDown cannot be set twice.');
					}
					++current_attack_cool_down$count;
					this.currentAttackCoolDown = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12300:
					if (recovery_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.recoveryAt cannot be set twice.');
					}
					++recovery_at$count;
					this.recoveryAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12400:
					if (created_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.createdAt cannot be set twice.');
					}
					++created_at$count;
					this.createdAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12500:
					if (updated_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.updatedAt cannot be set twice.');
					}
					++updated_at$count;
					this.updatedAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12600:
					if (gid$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.gid cannot be set twice.');
					}
					++gid$count;
					this.gid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12700:
					if (search_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.searchArea cannot be set twice.');
					}
					++search_area$count;
					this.searchArea = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12800:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: FORTBUILDING.reserved cannot be set twice.');
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
