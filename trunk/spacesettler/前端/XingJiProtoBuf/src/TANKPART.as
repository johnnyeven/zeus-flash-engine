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
	public dynamic final class TANKPART extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("TANKPART.id", "id", (10000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:UInt64;

		/**
		 *  @private
		 */
		public static const CHARIOT_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("TANKPART.chariot_id", "chariotId", (10100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chariotId:UInt64;

		/**
		 *  @private
		 */
		public static const PLAYER_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("TANKPART.player_id", "playerId", (10200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var playerId:UInt64;

		/**
		 *  @private
		 */
		public static const CATEGORY:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.category", "category", (10300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var category:int;

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.type", "type", (10400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var type:int;

		/**
		 *  @private
		 */
		public static const ENHANCED:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.enhanced", "enhanced", (10500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var enhanced:int;

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.level", "level", (10600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:int;

		/**
		 *  @private
		 */
		public static const VALUE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.value", "value", (10700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var value:int;

		/**
		 *  @private
		 */
		public static const SLOT_TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.slot_type", "slotType", (10800 << 3) | com.netease.protobuf.WireType.VARINT);

		public var slotType:int;

		/**
		 *  @private
		 */
		public static const ENERGY:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.energy", "energy", (10900 << 3) | com.netease.protobuf.WireType.VARINT);

		public var energy:int;

		/**
		 *  @private
		 */
		public static const WEIGHT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.weight", "weight", (11000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var weight:int;

		/**
		 *  @private
		 */
		public static const ATTACK_TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.attack_type", "attackType", (11100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var attackType:int;

		/**
		 *  @private
		 */
		public static const ATTACK_COOL_DOWN:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.attack_cool_down", "attackCoolDown", (11200 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var attackCoolDown:Number;

		/**
		 *  @private
		 */
		public static const EXPLODE_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.explode_area", "explodeArea", (11300 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var explodeArea:Number;

		/**
		 *  @private
		 */
		public static const ATTACK:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.attack", "attack", (11400 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var attack:Number;

		/**
		 *  @private
		 */
		public static const ATTACK_SPEED:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.attack_speed", "attackSpeed", (11500 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var attackSpeed:Number;

		/**
		 *  @private
		 */
		public static const ATTACK_AREA:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.attack_area", "attackArea", (11600 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var attackArea:Number;

		/**
		 *  @private
		 */
		public static const DAMAGE_DESC_TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.damage_desc_type", "damageDescType", (11700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var damageDescType:int;

		/**
		 *  @private
		 */
		public static const DAMAGE_DESC:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.damage_desc", "damageDesc", (11800 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var damageDesc:Number;

		/**
		 *  @private
		 */
		public static const ENDURANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("TANKPART.endurance", "endurance", (11900 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var endurance:Number;

		/**
		 *  @private
		 */
		public static const ENERGY_SUPPLY:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.energy_supply", "energySupply", (12000 << 3) | com.netease.protobuf.WireType.VARINT);

		public var energySupply:int;

		/**
		 *  @private
		 */
		public static const SHIELD:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.shield", "shield", (12100 << 3) | com.netease.protobuf.WireType.VARINT);

		public var shield:int;

		/**
		 *  @private
		 */
		public static const SPEED:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.speed", "speed", (12200 << 3) | com.netease.protobuf.WireType.VARINT);

		public var speed:int;

		/**
		 *  @private
		 */
		public static const REPAIR_SPEED:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.repair_speed", "repairSpeed", (12300 << 3) | com.netease.protobuf.WireType.VARINT);

		public var repairSpeed:int;

		/**
		 *  @private
		 */
		public static const AREA:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("TANKPART.area", "area", (12400 << 3) | com.netease.protobuf.WireType.VARINT);

		public var area:int;

		/**
		 *  @private
		 */
		public static const CREATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("TANKPART.created_at", "createdAt", (12500 << 3) | com.netease.protobuf.WireType.VARINT);

		public var createdAt:uint;

		/**
		 *  @private
		 */
		public static const UPDATED_AT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("TANKPART.updated_at", "updatedAt", (12600 << 3) | com.netease.protobuf.WireType.VARINT);

		public var updatedAt:uint;

		/**
		 *  @private
		 */
		public static const CALIBER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("TANKPART.caliber", "caliber", (12700 << 3) | com.netease.protobuf.WireType.VARINT);

		public var caliber:uint;

		/**
		 *  @private
		 */
		public static const RESERVED:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("TANKPART.reserved", "reserved", (12800 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.chariotId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10200);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, this.playerId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10300);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.category);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10400);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10500);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.enhanced);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10600);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.level);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10700);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.value);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10800);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.slotType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10900);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.energy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11000);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.weight);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11100);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.attackType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11200);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.attackCoolDown);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11300);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.explodeArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11400);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.attack);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11500);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.attackSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11600);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.attackArea);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11700);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.damageDescType);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11800);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.damageDesc);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 11900);
			com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.endurance);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12000);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.energySupply);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12100);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.shield);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12200);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.speed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12300);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.repairSpeed);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12400);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.area);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12500);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.createdAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12600);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.updatedAt);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12700);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.caliber);
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
			var chariot_id$count:uint = 0;
			var player_id$count:uint = 0;
			var category$count:uint = 0;
			var type$count:uint = 0;
			var enhanced$count:uint = 0;
			var level$count:uint = 0;
			var value$count:uint = 0;
			var slot_type$count:uint = 0;
			var energy$count:uint = 0;
			var weight$count:uint = 0;
			var attack_type$count:uint = 0;
			var attack_cool_down$count:uint = 0;
			var explode_area$count:uint = 0;
			var attack$count:uint = 0;
			var attack_speed$count:uint = 0;
			var attack_area$count:uint = 0;
			var damage_desc_type$count:uint = 0;
			var damage_desc$count:uint = 0;
			var endurance$count:uint = 0;
			var energy_supply$count:uint = 0;
			var shield$count:uint = 0;
			var speed$count:uint = 0;
			var repair_speed$count:uint = 0;
			var area$count:uint = 0;
			var created_at$count:uint = 0;
			var updated_at$count:uint = 0;
			var caliber$count:uint = 0;
			var reserved$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 10000:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10100:
					if (chariot_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.chariotId cannot be set twice.');
					}
					++chariot_id$count;
					this.chariotId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10200:
					if (player_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.playerId cannot be set twice.');
					}
					++player_id$count;
					this.playerId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10300:
					if (category$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.category cannot be set twice.');
					}
					++category$count;
					this.category = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10400:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10500:
					if (enhanced$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.enhanced cannot be set twice.');
					}
					++enhanced$count;
					this.enhanced = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10600:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10700:
					if (value$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.value cannot be set twice.');
					}
					++value$count;
					this.value = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10800:
					if (slot_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.slotType cannot be set twice.');
					}
					++slot_type$count;
					this.slotType = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10900:
					if (energy$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.energy cannot be set twice.');
					}
					++energy$count;
					this.energy = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11000:
					if (weight$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.weight cannot be set twice.');
					}
					++weight$count;
					this.weight = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11100:
					if (attack_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.attackType cannot be set twice.');
					}
					++attack_type$count;
					this.attackType = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11200:
					if (attack_cool_down$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.attackCoolDown cannot be set twice.');
					}
					++attack_cool_down$count;
					this.attackCoolDown = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11300:
					if (explode_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.explodeArea cannot be set twice.');
					}
					++explode_area$count;
					this.explodeArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11400:
					if (attack$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.attack cannot be set twice.');
					}
					++attack$count;
					this.attack = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11500:
					if (attack_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.attackSpeed cannot be set twice.');
					}
					++attack_speed$count;
					this.attackSpeed = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11600:
					if (attack_area$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.attackArea cannot be set twice.');
					}
					++attack_area$count;
					this.attackArea = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11700:
					if (damage_desc_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.damageDescType cannot be set twice.');
					}
					++damage_desc_type$count;
					this.damageDescType = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11800:
					if (damage_desc$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.damageDesc cannot be set twice.');
					}
					++damage_desc$count;
					this.damageDesc = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 11900:
					if (endurance$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.endurance cannot be set twice.');
					}
					++endurance$count;
					this.endurance = com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input);
					break;
				case 12000:
					if (energy_supply$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.energySupply cannot be set twice.');
					}
					++energy_supply$count;
					this.energySupply = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 12100:
					if (shield$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.shield cannot be set twice.');
					}
					++shield$count;
					this.shield = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 12200:
					if (speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.speed cannot be set twice.');
					}
					++speed$count;
					this.speed = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 12300:
					if (repair_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.repairSpeed cannot be set twice.');
					}
					++repair_speed$count;
					this.repairSpeed = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 12400:
					if (area$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.area cannot be set twice.');
					}
					++area$count;
					this.area = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 12500:
					if (created_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.createdAt cannot be set twice.');
					}
					++created_at$count;
					this.createdAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12600:
					if (updated_at$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.updatedAt cannot be set twice.');
					}
					++updated_at$count;
					this.updatedAt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12700:
					if (caliber$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.caliber cannot be set twice.');
					}
					++caliber$count;
					this.caliber = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12800:
					if (reserved$count != 0) {
						throw new flash.errors.IOError('Bad data format: TANKPART.reserved cannot be set twice.');
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
