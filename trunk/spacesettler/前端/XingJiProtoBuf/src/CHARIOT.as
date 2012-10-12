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
	import TANKPART;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class CHARIOT extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("CHARIOT.id", "id", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:UInt64;

		/**
		 *  @private
		 */
		public static const PLAYER_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("CHARIOT.player_id", "playerId", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var playerId:UInt64;

		/**
		 *  @private
		 */
		public static const CATEGORY:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.category", "category", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var category:int;

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.type", "type", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var type:int;

		/**
		 *  @private
		 */
		public static const ENHANCED:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.enhanced", "enhanced", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var enhanced:int;

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.level", "level", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:int;

		/**
		 *  @private
		 */
		public static const VALUE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.value", "value", (10600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var value:int;

		/**
		 *  @private
		 */
		public static const MAIN_SLOT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.main_slot", "mainSlot", (10700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var mainSlot:int;

		/**
		 *  @private
		 */
		public static const VICE_SLOT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.vice_slot", "viceSlot", (10800 << 3) | com.netease.protobuf.WireType.VARINT);

		public var viceSlot:int;

		/**
		 *  @private
		 */
		public static const MEDIUM_SLOT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.medium_slot", "mediumSlot", (10900 << 3) | com.netease.protobuf.WireType.VARINT);

		public var mediumSlot:int;

		/**
		 *  @private
		 */
		public static const SMALL_SLOT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.small_slot", "smallSlot", (11000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var smallSlot:int;

		/**
		 *  @private
		 */
		public static const BASIC_ATTACK_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_attack_speed", "basicAttackSpeed", (11100 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicAttackSpeed:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_ATTACK_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_attack_speed", "totalAttackSpeed", (11200 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalAttackSpeed:Number;

		/**
		 *  @private
		 */
		public static const BASIC_SEARCH_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_search_area", "basicSearchArea", (11300 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicSearchArea:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_SEARCH_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_search_area", "totalSearchArea", (11400 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalSearchArea:Number;

		/**
		 *  @private
		 */
		public static const BASIC_ATTACK_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_attack_area", "basicAttackArea", (11500 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicAttackArea:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_ATTACK_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_attack_area", "totalAttackArea", (11600 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalAttackArea:Number;

		/**
		 *  @private
		 */
		public static const BASIC_ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_endurance", "basicEndurance", (11700 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicEndurance:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_endurance", "totalEndurance", (11800 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalEndurance:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.current_endurance", "currentEndurance", (11900 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentEndurance:Number;

		/**
		 *  @private
		 */
		public static const BASIC_WEIGHT:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_weight", "basicWeight", (12000 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicWeight:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_WEIGHT:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_weight", "totalWeight", (12100 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalWeight:Number;

		/**
		 *  @private
		 */
		public static const WEIGHT_IN_USE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.weight_in_use", "weightInUse", (12200 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var weightInUse:Number;

		/**
		 *  @private
		 */
		public static const BASIC_ENERGY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_energy", "basicEnergy", (12300 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicEnergy:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_ENERGY:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_energy", "totalEnergy", (12400 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalEnergy:Number;

		/**
		 *  @private
		 */
		public static const ENERGY_IN_USE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.energy_in_use", "energyInUse", (12500 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var energyInUse:Number;

		/**
		 *  @private
		 */
		public static const BASIC_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_speed", "basicSpeed", (12600 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicSpeed:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_speed", "totalSpeed", (12700 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalSpeed:Number;

		/**
		 *  @private
		 */
		public static const BASIC_REPAIR_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_repair_speed", "basicRepairSpeed", (12800 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicRepairSpeed:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_REPAIR_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.current_repair_speed", "currentRepairSpeed", (12900 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentRepairSpeed:Number;

		/**
		 *  @private
		 */
		public static const BASIC_SHIELD:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.basic_shield", "basicShield", (13000 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var basicShield:Number;

		/**
		 *  @private
		 */
		public static const TOTAL_SHIELD:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.total_shield", "totalShield", (13100 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var totalShield:Number;

		/**
		 *  @private
		 */
		public static const CURRENT_SHIELD:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("CHARIOT.current_shield", "currentShield", (13200 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var currentShield:Number;

		/**
		 *  @private
		 */
		public static const INVINCIBLE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("CHARIOT.invincible", "invincible", (13300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var invincible:int;

		/**
		 *  @private
		 */
		public static const RECOVERY_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("CHARIOT.recovery_at", "recoveryAt", (13400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var recoveryAt:uint;

		/**
		 *  @private
		 */
		public static const CREATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("CHARIOT.created_at", "createdAt", (13500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var createdAt:uint;

		/**
		 *  @private
		 */
		public static const UPDATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("CHARIOT.updated_at", "updatedAt", (13600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var updatedAt:uint;

		/**
		 *  @private
		 */
		public static const TANKPARTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("CHARIOT.tankparts", "tankparts", (13700 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return TANKPART; });

		[ArrayElementType("TANKPART")]
		public var tankparts:Array = [];

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("CHARIOT.reserved", "reserved", (13800 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.category);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.enhanced);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.level);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10600);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.value);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10700);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.mainSlot);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10800);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.viceSlot);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10900);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.mediumSlot);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11000);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.smallSlot);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11100);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicAttackSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11200);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalAttackSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11300);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicSearchArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11400);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalSearchArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11500);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicAttackArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11600);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalAttackArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11700);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11800);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11900);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentEndurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12000);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicWeight);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12100);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalWeight);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12200);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.weightInUse);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12300);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicEnergy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12400);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalEnergy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12500);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.energyInUse);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12600);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12700);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12800);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicRepairSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 12900);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentRepairSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 13000);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.basicShield);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 13100);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.totalShield);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 13200);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.currentShield);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13300);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.invincible);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13400);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.recoveryAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.createdAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.updatedAt);
			for (var tankparts$index:uint = 0; tankparts$index < this.tankparts.length; ++tankparts$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 13700);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.tankparts[tankparts$index]);
			}
			if (hasReserved) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 13800);
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
			var category$count:uint = 0;
			var type$count:uint = 0;
			var enhanced$count:uint = 0;
			var level$count:uint = 0;
			var value$count:uint = 0;
			var main_slot$count:uint = 0;
			var vice_slot$count:uint = 0;
			var medium_slot$count:uint = 0;
			var small_slot$count:uint = 0;
			var basic_attack_speed$count:uint = 0;
			var total_attack_speed$count:uint = 0;
			var basic_search_area$count:uint = 0;
			var total_search_area$count:uint = 0;
			var basic_attack_area$count:uint = 0;
			var total_attack_area$count:uint = 0;
			var basic_endurance$count:uint = 0;
			var total_endurance$count:uint = 0;
			var current_endurance$count:uint = 0;
			var basic_weight$count:uint = 0;
			var total_weight$count:uint = 0;
			var weight_in_use$count:uint = 0;
			var basic_energy$count:uint = 0;
			var total_energy$count:uint = 0;
			var energy_in_use$count:uint = 0;
			var basic_speed$count:uint = 0;
			var total_speed$count:uint = 0;
			var basic_repair_speed$count:uint = 0;
			var current_repair_speed$count:uint = 0;
			var basic_shield$count:uint = 0;
			var total_shield$count:uint = 0;
			var current_shield$count:uint = 0;
			var invincible$count:uint = 0;
			var recovery_at$count:uint = 0;
			var created_at$count:uint = 0;
			var updated_at$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10100:
					if (player_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.playerId cannot be set twice.');
					}
					++player_id$count;
					this.playerId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10200:
					if (category$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.category cannot be set twice.');
					}
					++category$count;
					this.category = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10300:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10400:
					if (enhanced$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.enhanced cannot be set twice.');
					}
					++enhanced$count;
					this.enhanced = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10500:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10600:
					if (value$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.value cannot be set twice.');
					}
					++value$count;
					this.value = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10700:
					if (main_slot$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.mainSlot cannot be set twice.');
					}
					++main_slot$count;
					this.mainSlot = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10800:
					if (vice_slot$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.viceSlot cannot be set twice.');
					}
					++vice_slot$count;
					this.viceSlot = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10900:
					if (medium_slot$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.mediumSlot cannot be set twice.');
					}
					++medium_slot$count;
					this.mediumSlot = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11000:
					if (small_slot$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.smallSlot cannot be set twice.');
					}
					++small_slot$count;
					this.smallSlot = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11100:
					if (basic_attack_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicAttackSpeed cannot be set twice.');
					}
					++basic_attack_speed$count;
					this.basicAttackSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11200:
					if (total_attack_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalAttackSpeed cannot be set twice.');
					}
					++total_attack_speed$count;
					this.totalAttackSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11300:
					if (basic_search_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicSearchArea cannot be set twice.');
					}
					++basic_search_area$count;
					this.basicSearchArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11400:
					if (total_search_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalSearchArea cannot be set twice.');
					}
					++total_search_area$count;
					this.totalSearchArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11500:
					if (basic_attack_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicAttackArea cannot be set twice.');
					}
					++basic_attack_area$count;
					this.basicAttackArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11600:
					if (total_attack_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalAttackArea cannot be set twice.');
					}
					++total_attack_area$count;
					this.totalAttackArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11700:
					if (basic_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicEndurance cannot be set twice.');
					}
					++basic_endurance$count;
					this.basicEndurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11800:
					if (total_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalEndurance cannot be set twice.');
					}
					++total_endurance$count;
					this.totalEndurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11900:
					if (current_endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.currentEndurance cannot be set twice.');
					}
					++current_endurance$count;
					this.currentEndurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12000:
					if (basic_weight$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicWeight cannot be set twice.');
					}
					++basic_weight$count;
					this.basicWeight = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12100:
					if (total_weight$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalWeight cannot be set twice.');
					}
					++total_weight$count;
					this.totalWeight = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12200:
					if (weight_in_use$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.weightInUse cannot be set twice.');
					}
					++weight_in_use$count;
					this.weightInUse = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12300:
					if (basic_energy$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicEnergy cannot be set twice.');
					}
					++basic_energy$count;
					this.basicEnergy = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12400:
					if (total_energy$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalEnergy cannot be set twice.');
					}
					++total_energy$count;
					this.totalEnergy = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12500:
					if (energy_in_use$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.energyInUse cannot be set twice.');
					}
					++energy_in_use$count;
					this.energyInUse = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12600:
					if (basic_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicSpeed cannot be set twice.');
					}
					++basic_speed$count;
					this.basicSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12700:
					if (total_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalSpeed cannot be set twice.');
					}
					++total_speed$count;
					this.totalSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12800:
					if (basic_repair_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicRepairSpeed cannot be set twice.');
					}
					++basic_repair_speed$count;
					this.basicRepairSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12900:
					if (current_repair_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.currentRepairSpeed cannot be set twice.');
					}
					++current_repair_speed$count;
					this.currentRepairSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 13000:
					if (basic_shield$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.basicShield cannot be set twice.');
					}
					++basic_shield$count;
					this.basicShield = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 13100:
					if (total_shield$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.totalShield cannot be set twice.');
					}
					++total_shield$count;
					this.totalShield = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 13200:
					if (current_shield$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.currentShield cannot be set twice.');
					}
					++current_shield$count;
					this.currentShield = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 13300:
					if (invincible$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.invincible cannot be set twice.');
					}
					++invincible$count;
					this.invincible = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 13400:
					if (recovery_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.recoveryAt cannot be set twice.');
					}
					++recovery_at$count;
					this.recoveryAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 13500:
					if (created_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.createdAt cannot be set twice.');
					}
					++created_at$count;
					this.createdAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 13600:
					if (updated_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.updatedAt cannot be set twice.');
					}
					++updated_at$count;
					this.updatedAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 13700:
					this.tankparts.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new TANKPART()));
					break;
				case 13800:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: CHARIOT.reserved cannot be set twice.');
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
