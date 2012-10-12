#pragma once

#include <inttypes.h>

#pragma pack(push,4)

#define SERVER_SYSTEM_VERSION 0x20120518

#define FLOAT_ZERO 0.01

#define id_type unsigned long long
#define id_type_format "%llu"

struct HEADER {
    uint32_t length;        //数据包长度，包含sizeof(HEADER)
    uint16_t command;       //命令字
    uint16_t result;        //命令执行结果，参考ERROR_CODE_DEFINE
};

//enum {
//    SERVER_TYPE_GAME = 0,    //游戏服务器
//    SERVER_TYPE_HALL,        //大厅服务器
//    SERVER_TYPE_NB,
//};

enum {
    ROOM_TYPE_PVE = 0,
    ROOM_TYPE_PVP,
    ROOM_TYPE_NB,
};

enum HALL_SERVER_TYPE {
    HALL_SERVER_TYPE_PVE = 0,
    HALL_SERVER_TYPE_PVP,
    HALL_SERVER_TYPE_NB,
};

enum ENUM_ERROR_CODE_DEFINE {
    RESULT_SUCCESS = 0,                     //成功
    
//    RESULT_INVALID_SERVER_TYPE = 1,         //服务器类型无效
//    RESULT_INVALID_ROOM_TYPE = 3,           //房间类型无效
//    RESULT_NO_QUEUE_SERVER = 5,             //队列服务器连接丢失
//    RESULT_REDIS_ERROR = 6,                 //redis服务器错误
//    RESULT_TARGET_PENDING_ATTACK = 7,       //目标正要被攻击，可以稍后再试
//    RESULT_PLAYER_ALREADY_EXIST = 10,       //玩家已经存在
//    RESULT_ALREADY_CONTROLED_BY = 11,       //对象已被控制，已控制的时间已返回，可以超时以后再请求
//    RESULT_UNDER_PROTECTED_DURATION = 12,   //对象处于攻击保护期
//    RESULT_RESOURCE_NOT_ENOUGH = 16,        //资源不够
//    RESULT_NO_PREPARED_CHARIOT = 18,        //没有战车
//    RESULT_ROOM_STARUP_FAILED = 29,
    
    //server system internal using
    RESULT_VERSION_MISMATCH_OR_INVALID_INDEX,            //版本不匹配
    RESULT_SERVER_ALREADY_REGISTERED,  //服务器已注册、服务器id重复
    
    //game server only
    RESULT_NOT_ENOUGH_ROOM = 100,             //房间服务器不够
    RESULT_SELF_ATTACKING_NOT_PERMIT,  //自己攻击自己不允许
    RESULT_INVALID_SESSION_KEY,        //session key 无效
    RESULT_SESSION_KEY_EXPIRED,        //session key 过期
    RESULT_NOT_LOGIN,                  //未登陆
    RESULT_UNKNOW_FORT_STATUS,
    
    RESULT_INVALID_SERVER_CONFIGURE0 = 100,
    RESULT_INVALID_SERVER_CONFIGURE1,
    RESULT_INVALID_SERVER_CONFIGURE2,
    RESULT_INVALID_SERVER_CONFIGURE3,
    RESULT_INVALID_SERVER_CONFIGURE4,

//    RESULT_REDIS_ERROR_CAN_NOT_ACRUIRE_FORT_LOCK = 300,
    RESULT_REDIS_ERROR_QUERY_FORT_FAILED = 300,
    RESULT_REDIS_ERROR_CAN_NOT_UPDATE_FORT_BATTLE_STATUS,
    RESULT_REDIS_ERROR_QUERY_FORT_FAILED_2,
    RESULT_REDIS_ERROR_QUERY_FORTBUILDING_SET_FAILED,
    RESULT_REDIS_ERROR_QUERY_FORTBUILDING_FAILED,
    RESULT_REDIS_ERROR_QUERY_CHARIOT_FAILED,
    RESULT_REDIS_ERROR_QUERY_TANKPART_SET_FAILED,
    RESULT_REDIS_ERROR_QUERY_TANKPART_FAILED,
    RESULT_REDIS_ERROR_QUERY_PLAYER_FAILED,
    RESULT_REDIS_ERROR_QUERY_SESSION_KEY_FAILED,
    
    //hall server only
    RESULT_INVALID_PASSPORT = 400,            //房间通信证错误
    RESULT_INVALID_GID,                //组id无效
    RESULT_INVALID_ROOM,               //房间号无效
    RESULT_INVALID_VOTE_TYPE,          //投票类型无效
    RESULT_TOO_MANY_PLAYERS,           //房间人数超过配置的最大值
    RESULT_INVALID_BUFFER_INDEX,
    RESULT_TARGET_PENDING_ATTACK_TIMEOUT,
    RESULT_OUT_OF_DARK_CRYSTAL,
    RESULT_FORT_WITHOUT_BUILDING,      //要塞没有建筑
    RESULT_OBJECT_NOT_FOUND,           //对象不存在
    RESULT_KEEP_WAIT_FOR,              //请求复活等待时间不够
    RESULT_ROOM_OUT_OF_SERVICE,        //房间未开放
    RESULT_REQUEST_CONTROL_FAILED,     //客户端请求对象移动、开火，对象未被控制

    RESULT_SERVER_INTERNAL_ERROR = 500,
    RESULT_DUPLICATE_REQUEST_FOUND,
    RESULT_APPEND_PLAYER_DATA_ERROR,

    //both game server & hall server
    RESULT_SERIALIZE_ERROR = 500,             //pb序列化错误
};

enum {
    COMMAND_REGISTER_SERVER         = 0,    //注册服务器
    COMMAND_REGISTER_SERVER_RESULT  = 1,    //注册服务器结果
    COMMAND_REQUEST_ROOM            = 2,    //请求房间
    COMMAND_REQUEST_ROOM_RESULT     = 3,    //请求房间结果
    
    COMMAND_MORE_ROOM_READY         = 4,
    COMMAND_QUERY_PLAYER            = 5,    //查询玩家信息
    COMMAND_QUERY_PLAYER_RESULT     = 6,    //查询玩家信息
    COMMAND_UPDATE_GAME_RESULT      = 7,    //游戏结果回写到redis请求
//    COMMAND_REGISTER_ROOM           = 2,    //注册房间
//    COMMAND_REGISTER_ROOM_RESULT    = 3,
    
//    COMMAND_REQUEST_ROOM_RESET      = 6,    //取消已请求到的房间
    
//    COMMAND_SERVER_SHUTDOWN         = 8,    //服务器关闭
//    COMMAND_ROOM_READY              = 10,   //通知所有的game-server房间就绪
//    COMMAND_UNREGISTER_SERVER       = 11,   //注销服务器 hall to queue only
    COMMAND_NB,
};

struct HEADER_COMMAND_REGISTER_SERVER {
    HEADER header;
    uint32_t type;                          //服务器类型 refer to enum HALL_SERVER_TYPE
    uint32_t index;                         //服务器编号
    uint32_t version;                       //系统版本号，SERVER_SYSTEM_VERSION
};

typedef HEADER_COMMAND_REGISTER_SERVER HEADER_COMMAND_REGISTER_SERVER_RESULT;

struct ROOM_CONTEXT {
    uint32_t hall_server_index;             //房间所在的大厅服务器
    uint32_t room_type;                     //房间类型
    uint32_t room_index;                    //房间序号
    uint32_t server_address_ipv4;           //大厅服务器地址
    uint32_t server_listen_port;            //端口
    uint32_t passport;                      //临时通行证号码
};

typedef ROOM_CONTEXT *ROOM_CONTEXT_PTR;

//struct HEADER_COMMAND_REGISTER_ROOM {
//    HEADER header;
//    ROOM_CONTEXT room;
//};
//
//typedef HEADER_COMMAND_REGISTER_ROOM HEADER_COMMAND_REGISTER_ROOM_RESULT;

struct ROOM_REQUEST_CONTEXT {
    uint32_t room_type;
    uint32_t client_index;      //客户端请求序列号
    
    id_type whoami;            //攻击者id
    id_type who;               //防守者id
    id_type where;             //防守者要塞id
};

//请求房间，游戏服务器发送给排队服务器
struct HEADER_COMMAND_REQUEST_ROOM {
    HEADER header;
    ROOM_REQUEST_CONTEXT request;   //详细请求信息
    char data[0];                   //游戏服务器收集的信息，为 USER_DATA 的序列化二进制数据
};

struct HEADER_COMMAND_REQUEST_ROOM_RESULT {
    HEADER header;
    ROOM_REQUEST_CONTEXT request;   //详细请求信息
    ROOM_CONTEXT room[0];
};

////请求房间成功后，排队服务器发送给游戏服务器
//struct HEADER_COMMAND_REQUEST_ROOM_RESULT_TO_GAME_SERVER {
////    HEADER header;
////    ROOM_REQUEST_CONTEXT request;   //原始的请求信息
////    ROOM_CONTEXT room[0];           //已填充完整的房间信息
//    HEADER header;
//    uint32_t to;     //游戏结果数据回写执行的游戏服务器id
//    uint32_t from;
//    ROOM_REQUEST_CONTEXT request;
//    ROOM_CONTEXT room[0];
//};
//
////请求房间成功后，排队服务器发送给大厅服务器
//struct HEADER_COMMAND_REQUEST_ROOM_RESULT_TO_HALL_SERVER {
//    HEADER header;
//    ROOM_REQUEST_CONTEXT request;
//    ROOM_CONTEXT room;          //已填充完整的房间信息
//    uint32_t game_server_index; //请求来自的游戏服务器编号
//    char data[0];          //为 USER_DATA 的序列化二进制数据
//};
//
//struct HEADER_COMMAND_REQUEST_ROOM_RESET {
//    HEADER header;
//    uint32_t to;
//    uint32_t from;
//    ROOM_CONTEXT room[0];
//};

enum ENUM_GAME_RESULT {
    GAME_RESULT_ATTACKER_WIN = 0,
    GAME_RESULT_DEFENDER_WIN,
    GAME_RESULT_ENTER_TIMEOUT,
    GAME_RESULT_NB,
};

struct HEADER_COMMAND_UPDATE_GAME_RESULT {
    HEADER header;
    uint32_t type_of_result;        // = ROOM_TYPE
    uint32_t room_index;
    uint32_t reason;                //reffer to ENUM_GAME_RESULT
    char data[0];                   //为 USER_DATA 的序列化二进制数据
    
};

//typedef HEADER_COMMAND_REGISTER_SERVER HEADER_COMMAND_MORE_ROOM;
typedef HEADER HEADER_COMMAND_MORE_ROOM_READY;

struct HEADER_COMMAND_QUERY_PLAYER {
    HEADER header;
    id_type uid;                   //用户id
    id_type chariot_id;
    id_type gid;
    uint32_t room_index;            //房间id
    char data[0];                   //为 PLAYER1 的序列化二进制数据
};

typedef HEADER_COMMAND_QUERY_PLAYER HEADER_COMMAND_QUERY_PLAYER_RESULT;

//typedef HEADER HEADER_COMMAND_ROOM_READY;














enum ENUM_FORT_BATTLE_STATUS {
    FORT_BATTLE_STATUS_PENDING_ATTACK = -1,
    FORT_BATTLE_STATUS_IDLE,
    FORT_BATTLE_STATUS_UNDER_ATTACK,
};

// commands define
// client    <---->    game server

enum COMMAND_GAME2CLIENT {
    GAME2CLIENT_LOGIN = 0,
    GAME2CLIENT_LOGIN_RESULT,
    GAME2CLIENT_REQUEST_ROOM,
    GAME2CLIENT_REQUEST_ROOM_RESULT,
};

enum {
    SESSION_KEY_LENGTH = 40,
};
struct HEADER_GAME2CLIENT_LOGIN {
    
    HEADER header;
    id_type whoami;
    uint32_t session_key_len;//always equal to SESSION_KEY_LENGTH
    char session_key[0];
    
};

typedef HEADER HEADER_GAME2CLIENT_LOGIN_RESULT;

struct HEADER_GAME2CLIENT_REQUEST_ROOM {
    HEADER header;
    
    id_type whoami;     //攻击者id
    id_type chariot;    //攻击者tank_id
    id_type who;        //防守者id
    id_type where;      //要塞id
};


struct HEADER_GAME2CLIENT_REQUEST_ROOM_RESULT {
    HEADER header;
    uint32_t gid;
    ROOM_CONTEXT room[0];//if success
};


enum ENUM_SLOT_TYPE {
//    SLOT_TYPE_MAIN = 1, //主炮
//    SLOT_TYPE_VICE,     //副炮
    SLOT_TYPE_BIG = 1,      //大型
    SLOT_TYPE_MEDIUM,   //中型
    SLOT_TYPE_SMALL,    //小型
    SLOT_TYPE_NB,
};


enum ENUM_FORT_BUILDING_TYPE {
    FORT_BUILDING_TYPE_FORT_CENTER 						= 1,//		# 要塞中心
    FORT_BUILDING_TYPE_COLLECTING_FACTORY,// 			= 2		# 综合采集厂
    FORT_BUILDING_TYPE_MISSILE_TURRENT,// 				= 3 	# 导弹炮塔
    FORT_BUILDING_TYPE_CLUSTER_LASER_TURRENT,// 	= 4 	# 集束激光炮塔
    FORT_BUILDING_TYPE_IMPULSE_TURRENT,// 				= 5 	# 脉冲炮塔
    FORT_BUILDING_TYPE_RADIATION_TURRENT,// 			= 6 	# 辐射炮塔
    FORT_BUILDING_TYPE_NB,
};



// commands define
// client    <---->    room server
enum COMMAND_ROOM2CLIENT {
    
    ROOM2CLIENT_LOGIN = 0,         //玩家者登陆
    ROOM2CLIENT_PING,                       //
    ROOM2CLIENT_MOVING,                     //攻击者对象移动
    ROOM2CLIENT_FIRE,                       //开火
    
    ROOM2CLIENT_ATTACKED,                   //报告伤害对象情况
    ROOM2CLIENT_FIX,                        //防守者调整对象恢复速度
    ROOM2CLIENT_AIRFORCE_HELP,              //防守者呼叫空中支援
    ROOM2CLIENT_SURRENDER,                  //攻击者投降、撤离
    
    ROOM2CLIENT_REQUEST_CONTROL,            //攻击者请求控制防守方攻击对象
    ROOM2CLIENT_RELEASE_CONTROL,            //攻击者主动释放已控制的对象
    ROOM2CLIENT_VOTE,                       //
    ROOM2CLIENT_BOARDCAST_MESSAGE,          //
    
    ROOM2CLIENT_OBJECT_REQUEST_RELIVE,      //请求复活对象，当前仅对战车有效
    ROOM2CLIENT_REQUEST_BUFFER,             //请求获得增益效果
    
    
    
    
    
    
    //以下是room服务器发送给客户端的命令
    ROOM2CLIENT_LOGIN_RESULT = 1000,               //
    ROOM2CLIENT_BOARDCAST_STATUS,           //广播受到伤害对象当前
    ROOM2CLIENT_FINISH,                     //游戏结束
    ROOM2CLIENT_FINISH_TIMEOUT,             //游戏超时结束
    
    ROOM2CLIENT_MOVING_HISTORY,             //可移动对象移动历史
    ROOM2CLIENT_REQUEST_CONTROL_RESULT,     //请求控制结果
    ROOM2CLIENT_TIMEOUT_RELEASE_CONTROL,    //被控制对象超时被释放
    ROOM2CLIENT_PLAYER_ENTER,               //新玩家进入房间
    
    ROOM2CLIENT_VOTE_STARTUP,               //开始投票
    ROOM2CLIENT_VOTE_RESULT,                //投票结果
    ROOM2CLIENT_SHUTDOWN,
    
    
    ROOM2CLIENT_OBJECT_DYING,
    ROOM2CLIENT_OBJECT_REQUEST_RELIVE_RESULT,             //请求复活结果
    ROOM2CLIENT_FORTBUILIDNG_CHANGING_GID,

//    
    ROOM2CLIENT_BUFFER_GENERATED,           //增益产生
    ROOM2CLIENT_REQUEST_BUFFER_RESULT,
    
    ROOM2CLIENT_BUFFER_EATING,
    ROOM2CLIENT_NPC_CHARIOT_ENTER,          //NPC战车加入战场
    
    
    
    ROOM2CLIENT_OBTAIN_HONOR,               //击毁建筑（炮台）获得荣誉
    ROOM2CLIENT_UPDATE_OBJECT,              //更新对象属性
//    
//    ROOM2CLIENT_OBJECT_RELIVE,              //对象复活
};


enum ENUM_ATTACK_TYPE {
    ATTACK_TYPE_REAL_ATTACK = 1,    //  # 实弹攻击
    ATTACK_TYPE_LASER,              //  # 激光攻击
    ATTACK_TYPE_MAGNET,             // 	# 电磁攻击
    ATTACK_TYPE_NUCLEAR_ATTACK,     // 	# 核能攻击
    ATTACK_TYPE_AIR,                // 	# 防空挂件攻击
    ATTACK_TYPE_SELF_DESTRUCTION,   //  # 自爆攻击
    ATTACK_TYPE_NB,
};

enum ENUM_TANKPART_TYPE_NEW {
    WARSHIP_CANNON_TANK_PART                    = 1,//		# 战舰炮
    LAUNCHER_TANK_PART 							= 2,//		# 导弹发射器
    VULCAN_CANNON_TANK_PART                     = 3,//		# 火神炮
    BEAM_CANNON_TANK_PART                       = 4,//		# 光束炮
    HIGH_ENERGY_LASER_TANK_PART                 = 5,//		# 高能激光炮
    LATTICE_LASER_TANK_PART                     = 6,//		# 点阵激光炮
    RAILGUN_TANK_PART 							= 7,//		# 轨道炮
    PULSE_CANNON_TANK_PART                      = 8,//		# 脉冲炮
    ELECTROMAGNETIC_SHOCK_TANK_PART             = 9,//		# 电磁冲击器
    ANNIHILATE_CANNON_TANK_PART                 = 10,//	# 湮灭炮
    ANTIMATTER_CANNON_TANK_PART                 = 11,//	# 反物质炮
    SINGULAR_COUPLING_TANK_PART                 = 12,//	# 奇点耦合炮
    COMPOSITE_ARMOR_TANK_PART                   = 13,//	# 复合装甲
    REACTIVE_ARMOR_TANK_PART                    = 14,//	# 反应装甲
    REFLECTIVE_ARMOR_TANK_PART                  = 15,//	# 反射装甲
    DIFFRACTION_ARMOR_TANK_PART                 = 16,//	# 衍射装甲
    SHIELDED_ARMOR_TANK_PART                    = 17,//	# 屏蔽装甲
    INTERFERENCE_ARMOR_TANK_PART                = 18,//	# 干扰装甲
    ANTIMATTER_ARMOR_TANK_PART                  = 19,//	# 反物质装甲
    ANTI_GRAV_ARMOR_TANK_PART                   = 20,//	# 反引力装甲
    EFFICIENT_ENERGY_TANK_PART                  = 21,//	# 高效能量发生器
    SHIELD_TANK_PART                            = 22,//	# 能源护盾
    HIGH_ENERGY_ENGINE_TANK_PART            	= 23,//	# 高能引擎
    SPEEDUP_TANK_PART 							= 24,//	# 转换增速仪
    INTELLIGENT_COMBAT_TANK_PART                = 25,//	# 智能战斗雷达
    SELF_DESTRUCTION_TANK_PART                  = 26,//	# 自爆装置
    TANKPART_TYPE_NEW_NB,
};

enum ENUM_CHARIOT_TYPE {
    CHARIOT_TYPE_1 = 1,//	进化战车
    CHARIOT_TYPE_2,//	起源战车
    CHARIOT_TYPE_3,//	飞跃战车
    CHARIOT_TYPE_4,//	晨曦战车
    CHARIOT_TYPE_5,//	黄昏战车
    CHARIOT_TYPE_6,//	黎明战车
    CHARIOT_TYPE_7,//	璀璨战车
    CHARIOT_TYPE_8,//	辉煌战车
    CHARIOT_TYPE_9,//	闪耀战车
    CHARIOT_TYPE_10,//	热核战车
    CHARIOT_TYPE_11,//	裂变战车
    CHARIOT_TYPE_12,//	辐射战车
    CHARIOT_TYPE_NPC_MOTHERSHIP,//	npc巡逻战车
    CHARIOT_TYPE_NPC_FLYINGBOMB,//	npc自曝
    CHARIOT_TYPE_NPC_WINGMAN,//     npc僚机
    CHARIOT_TYPE_NB,
};

enum ENUM_PLAYER_GROUP_DEF{
    PLAYER_GROUP_INVALID = -1,
    PLAYER_GROUP_ATTACKER,
    PLAYER_GROUP_DEFENDER,
    PLAYER_GROUP_NB,
};

enum ENUM_PLAYER_GROUP_DEF2 {
    PLAYER_GROUP_A = 0,
    PLAYER_GROUP_B,
    PLAYER_GROUP_C,
    PLAYER_GROUP_D,
    PLAYER_GROUP_E,
    PLAYER_GROUP_F,
    PLAYER_GROUP_G,
    PLAYER_GROUP_H,
};

#define FORT_LEVEL_NB 14

struct HEADER_ROOM2CLIENT_LOGIN {
    HEADER header;
    id_type whoami;        //玩家ID
    id_type chariot_id;
    uint32_t gid;           //分组id = ENUM_PLAYER_GROUP
    uint32_t room_index;    //房间号
    uint32_t passport;      //房间临时通信证
    uint32_t version;       //系统版本号
};

//typedef HEADER_ROOM2CLIENT_LOGIN_ATTACKER HEADER_ROOM2CLIENT_LOGIN_DEFENCER;

struct HEADER_ROOM2CLIENT_LOGIN_RESULT {
    HEADER header;
    //    uint32_t friend_fire;   //
    uint32_t room_startup;     //当前时间
    uint32_t room_will_shutdown_at;     //房间预计超时时间
    char data[0];           //如果登陆成功，此处数据为 USER_DATA 的序列化之后的二进制数据
};

struct HEADER_ROOM2CLIENT_PING {
    HEADER header;
    uint32_t sequnce;       //包序列号，客户端顺序填充以计算网络延迟值
};

struct POINT {
    float x;
    float y;
};

struct MOVING {
    id_type whoami;        //对象ID，当前应该为chariot编号
    POINT from;             //出发点坐标
    float angle;            //角度
    float speed;            //速度
    POINT to;               //目标点坐标
    uint32_t duration;     //客户端发送移动可以不填写，服务器返回的结构此处表示距离此次移动已过去的时间ms
};

struct HEADER_ROOM2CLIENT_MOVING {
    HEADER header;
    MOVING moving;          //详细移动信息
    char data[0];           //客户端携带信息扩展保留
};

struct HEADER_ROOM2CLIENT_FIRE {
    HEADER header;
    id_type identifier_firing;  //正在射击的chariot对象id
    char data[0];           //客户端携带信息扩展保留
};

enum ENUM_OBJECT_TYPE {
    OBJECT_TYPE_CHARIOT = 0,
    OBJECT_TYPE_FORTBUILDING,
    OBJECT_TYPE_TANKPART,
    OBJECT_TYPE_NB,
};

struct ATTACKED_OBJECT {
    id_type id_take_attack;    //受到伤害的目标id
    uint32_t type;              //0 chariot     1 building
    uint32_t attack_type;       //攻击类型
    POINT pt;                   //受到伤害的目标当前位置
};

struct HEADER_ROOM2CLIENT_ATTACKED {
    HEADER header;
    POINT explode_pos;                 //爆炸点
    
    id_type attacker_uid;
    uint32_t attacker_gid;              //攻击者gid
//    float basic_min_attack;             //# 最小基础攻击
    float current_min_attack;           //# 当前最小基础攻击
//    float basic_max_attack;             //# 最大基础攻击	
    float current_max_attack;           //# 当前最小基础攻击
//    float basic_attack_area;            //# 基础爆炸范围
    float current_attack_area;          //# 当前爆炸范围
//    uint32_t attack_range;              //# 爆炸范围
    
    uint32_t count;                     //此次爆炸受影响的对象个数
    ATTACKED_OBJECT attack[0];          //详细列举具体对象信息
};

struct HEADER_ROOM2CLIENT_FIX {
    HEADER header;
    id_type fortbuilding_id;               //建筑id
    uint32_t count;                     //维修速率增加倍数，将扣除防守者响应的水晶
    float current_repair_speed;         //当前维修速率
};

struct HEADER_ROOM2CLIENT_AIRFORCE_HELP {
    HEADER header;
    uint32_t health_reduce;             //空中支援对响应对象造成的伤害值
};

struct HEADER_ROOM2CLIENT_SURRENDER {
    HEADER header;
    id_type uid;
};

struct HEADER_ROOM2CLIENT_REQUEST_CONTROL {
    HEADER header;
    id_type target;                    //炮台id
};

typedef HEADER_ROOM2CLIENT_REQUEST_CONTROL HEADER_ROOM2CLIENT_RELEASE_CONTROL;

//struct HEADER_ROOM2CLIENT_RELEASE_CONTROL {
//    HEADER header;
//    id_type target;                    //炮台id
//};

enum ENUM_VOTE_TYPE {
    VOTE_TYPE_GIVEUP=0,
    VOTE_TYPE_NEED,
    VOTE_TYPE_BUY,
    VOTE_TYPE_NB,
};

struct VOTE_CONTEXT {
    id_type uid;
    uint32_t type;                      //VOTE_TYPE_BUY/VOTE_TYPE_NEED/VOTE_TYPE_GIVEUP
    uint32_t value;
};

struct HEADER_ROOM2CLIENT_VOTE {
    HEADER header;
    VOTE_CONTEXT vote;
};

struct HEADER_ROOM2CLIENT_BOARDCAST_MESSAGE {
    HEADER header;
    uint32_t boardcast_message_len;
    char message[0];
};

//#define HBC_TYPE_CHARIOT 0
//#define HBC_TYPE_FORTBUILDING 1
struct HEALTH_BOARDCAST {
    uint32_t type;                      //HBC_TYPE_CHARIOT=0 chariot     HBC_TYPE_FORTBUILDING=1 building
    id_type id;                        //
    float current_endurance;
    float current_shield;
};

struct HEADER_ROOM2CLIENT_BOARDCAST_STATUS {
    HEADER header;
    uint32_t count;                     //
    HEALTH_BOARDCAST health[0];
};

enum {
    FINISH_DEFEAT = 0,
    FINISH_WIN,
};
//#define FINISH_DEFEAT 0
//#define FINISH_WIN 1


struct HEADER_ROOM2CLIENT_FINISH {
    
    HEADER header;
    uint32_t result;                //0 defeat

};

typedef HEADER HEADER_ROOM2CLIENT_FINISH_TIMEOUT;

struct HEADER_ROOM2CLIENT_MOVING_HISTORY {
    HEADER header;
    uint32_t nb_history;
    MOVING moving[0];
};

typedef HEADER_ROOM2CLIENT_REQUEST_CONTROL HEADER_ROOM2CLIENT_REQUEST_CONTROL_RESULT;

typedef HEADER_ROOM2CLIENT_RELEASE_CONTROL HEADER_ROOM2CLIENT_TIMEOUT_RELEASE_CONTROL;

typedef HEADER_ROOM2CLIENT_LOGIN_RESULT HEADER_ROOM2CLIENT_PLAYER_ENTER;

typedef HEADER HEADER_ROOM2CLIENT_VOTE_STARTUP;

struct HEADER_ROOM2CLIENT_VOTE_RESULT {
    HEADER header;
    uint32_t count;
    VOTE_CONTEXT vote[0];
};

//typedef HEADER HEADER_ROOM2CLIENT_SHUTDOWN;

//struct BATTLE_RESOURCE_OBTAIN {
//    
//    uint32_t resource_type;
//    uint32_t delta;
//    int32_t bluemap_recipes_type;
//    int32_t bluemap_recipes_category;
//    int32_t bluemap_level;
//};

enum FORT_OBTAIN_REASON {
    OBTAIN_REASION_BUY=0,
    OBTAIN_REASION_NEED,
    OBTAIN_REASION_SINGLE,
    OBTAIN_REASION_SINGLE_BUY,
    OBTAIN_REASION_NB,
};

struct RESOURCE_OBTAIN_IN_BATTLE {
    
    //resource pickup in battle
    int32_t crystal;
    int32_t tritium;
    int32_t dark;
    int32_t dark_crystal;
    
    //resource obtain for winner
    uint32_t resource_type;
    uint32_t delta;
    
    //bluemap obtain for winner
    int32_t bluemap_recipes_type;
    int32_t bluemap_recipes_category;
    int32_t bluemap_level;
    
    int32_t honour_obtain;
    
    int32_t gain_fort;          //0=no 1=yes
//    int32_t gain_reason;        //0=buy 1=need 2=single 3=single buy, only gain_fort=1
    int32_t dark_delta;         //pay for fort buying or gain for sb buy fort, only gain_fort=1
    
    
    //pay for relive
    int32_t dark_crystal_for_relive;
   
    int32_t reserved[8];
};

struct HEADER_ROOM2CLIENT_SHUTDOWN {
    HEADER header;
    RESOURCE_OBTAIN_IN_BATTLE res[0];
};

struct HEADER_ROOM2CLIENT_OBJECT_DYING {
    HEADER header;
//    id_type uid;
    uint32_t type;                      //HBC_TYPE_CHARIOT=0 chariot     HBC_TYPE_FORTBUILDING=1 building
    id_type identify;
    uint32_t timeout;
};

typedef HEADER_ROOM2CLIENT_OBJECT_DYING HEADER_ROOM2CLIENT_OBJECT_REQUEST_RELIVE;
typedef HEADER_ROOM2CLIENT_OBJECT_DYING HEADER_ROOM2CLIENT_OBJECT_REQUEST_RELIVE_RESULT;
//typedef HEADER_ROOM2CLIENT_OBJECT_DYING HEADER_ROOM2CLIENT_OBJECT_REQUEST_RELIVE_SUCCESS;

struct HEADER_ROOM2CLIENT_FORTBUILIDNG_CHANGING_GID {
    HEADER header;
    id_type identify;
    uint32_t gid_from;
    uint32_t gid_to;
};

enum {
    BUFFER_TYPE_PROPERTY = 0,
    BUFFER_TYPE_RESOURCE,
    BUFFER_TYPE_WINGMAN,
    BUFFER_TYPE_NB,
};

enum {
    RESOURCE_TYPE_CRYSTAL = 0,
    RESOURCE_TYPE_TRITIUM,
    RESOURCE_TYPE_DARK,
    RESOURCE_TYPE_DARK_CRYSTAL,
    RESOURCE_TYPE_NB,
};



//
//required                    uint32                          type         =     10000;    //增益效果类型0=属性1=资源2=僚机
//required                    uint32                      sub_type         =     10100;    //type=00=耐久1=护盾type=10=金晶1=氚氢2=暗物质3=暗能水晶type=2=僚机
//required                    uint32                         index         =     10200;    //增益编号
//required                    uint32                         delta         =     10300;    //type=0&&type=1

struct HEADER_ROOM2CLIENT_BUFFER_GENERATED {
  
    HEADER header;
//    uint32_t type;  //增益效果类型 0 1 2=僚机
//    uint32_t index; //增益编号
//    uint32_t delta;
//    POINT pt;
    
//    id_type eating_by;
    char data[0]; //BUFFER_DEF pb data
};


enum {
    
    BUFFER_TYPE_PVE_ENDURANCE = 0,//endurance
    BUFFER_TYPE_PVE_SHIELD = 1,//shield
};

//struct HEADER_ROOM2CLIENT_BUFFER_GENERATED {
//    HEADER header;
//    id_type generate_by;    //generating by fortbuilding only
//    uint32_t index;         //buffer index
//    uint32_t type;          //buffer type
//};

//typedef HEADER_ROOM2CLIENT_BUFFER_GENERATED HEADER_ROOM2CLIENT_REQUEST_BUFFER;

struct HEADER_ROOM2CLIENT_REQUEST_BUFFER {
    HEADER header;
//    uint32_t type;
    uint32_t index;
    id_type eating_by;
};


//struct HEADER_ROOM2CLIENT_REQUEST_BUFFER_PVE {
//    HEADER header;
//    uint32_t identifier_type;   //OBJECT_TYPE_CHARIOT/OBJECT_TYPE_FORTBUILDING/OBJECT_TYPE_TANKPART
//    id_type identify;
//    float value;
//    uint32_t filed_name_len;
//    char field_name[0]; //max of 32 bytes
//};



typedef HEADER_ROOM2CLIENT_REQUEST_BUFFER HEADER_ROOM2CLIENT_REQUEST_BUFFER_RESULT;
typedef HEADER_ROOM2CLIENT_REQUEST_BUFFER HEADER_ROOM2CLIENT_BUFFER_EATING;


#define NPC_MOTHERSHIP_IDENTIFIER 10000         //巡逻母舰标识起始值
#define NPC_FLYINGBOMB_IDENTIFIER 1000000       //自爆飞行器识起始值
#define NPC_TANKPART_IDENTIFIER 2012            //以上二者攻击挂件识起始值
#define NPC_FORTBUILDING_IDENTIFIER 10000000 
#define NPC_WINGMAN_IDENTIFIER 100000000

#define MAX_PLAYER_FORT_TYPE 10



struct HEADER_ROOM2CLIENT_NPC_CHARIOT_ENTER {
    HEADER header;
    id_type generated_by;   //0基地产生、非0是从该对象当前点产生，仅在目标类型为CHARIOT_TYPE_NPC_FLYING_BOMB有意义；目标类型为CHARIOT_TYPE_NPC_MOTHERSHIP时，始终在基地产生
    char player1_pb[0];     //PLAYER1结构pb数据，仅有chariots/gid有意义，type只能为CHARIOT_TYPE_NPC_MOTHERSHIP/CHARIOT_TYPE_NPC_FLYING_BOMB
};


struct HEADER_ROOM2CLIENT_OBTAIN_HONOR {
    HEADER header;
    id_type who;            //who obtain honor
    id_type generate_by;    //generate by fortbuilding only
    int honor;              //how much of honor
};

//enum ENUM_VALUE_TYPE {
//    ENUM_VALUE_TYPE_INT32 = 0,
//    ENUM_VALUE_TYPE_UINT32,
//    ENUM_VALUE_TYPE_INT64,
//    ENUM_VALUE_TYPE_UINT64,
//    ENUM_VALUE_TYPE_FLOAT,
//    ENUM_VALUE_TYPE_DOUBLE,
//};

enum PARAMETER_TYPE {PT_STRING = 0, PT_FLOAT, PT_INT32, PT_UINT32, PT_INT64, PT_UINT64};

struct OBJECT_UPDATE_CONTEXT {
    uint32_t offset;
    uint32_t value_type; //ENUM_VALUE_TYPE
    uint32_t value;
};
struct HEADER_ROOM2CLIENT_UPDATE_OBJECT {
    HEADER header;
    uint32_t type;           //HBC_TYPE_CHARIOT=0 chariot     HBC_TYPE_FORTBUILDING=1 building
    id_type who;            //which will be updated
    uint32_t count;
    OBJECT_UPDATE_CONTEXT contexts[0];
};







//聊天命令定义


enum ENUM_CHAT2CLIENT {
    CHAT2CLIENT_LOGIN = 0,
    CHAT2CLIENT_GET_HISTORY,
    CHAT2CLIENT_TALKING,
    CHAT2CLIENT_LOGOFF,
    CHAT2CLIENT_GET_ONLINE_PLAYER_NUMBER,
    CHAT2CLIENT_SYSTEM_BOARDCAST,
    CHAT2CLIENT_NB,
    
    CHAT2CLIENT_LOGIN_RESULT = 1000,
    CHAT2CLIENT_NOT_LOGIN,
    CHAT2CLIENT_GET_ONLINE_PLAYER_NUMBER_RESULT,
};

enum {
    CC_ERROR_SUCCESS = 0,
    CC_ERROR_INVALID_CHECKSUM = 1,
    CC_ERROR_INVALID_DIGIEST_LEN = 2,
};

struct HEADER_CHAT2CLIENT_LOGIN {
    HEADER header;
    id_type whoami;
    id_type group;
    id_type timestamp;
    uint32_t seed;
    uint32_t digiest_len;
    char digiest[0];
};

struct HEADER_CHAT2CLIENT_GET_HISTORY {
    HEADER header;
    id_type whoami;
    id_type channel;                //channel or user identifier
    unsigned long long timestamp;
};


enum ENUM_CHAT_CHANNEL {
  
    CHANNEL_WORLD = 0,
    CHANNEL_ARMY_GROUP,
    CHANNEL_PRIVATE,
    CHANNEL_NB,
};

struct HEADER_CHAT2CLIENT_TALKING {
    HEADER header;
    id_type whoami;
    id_type channel;                //channel or user identifier
    id_type timestamp;
    uint32_t length;
    uint32_t camp_id;
    char data[0];
};

struct HEADER_CHAT2CLIENT_LOGOFF {
    HEADER header;
    id_type whoami;
};

struct HEADER_CHAT2CLIENT_GET_ONLINE_PLAYER_NUMBER {
    HEADER header;
    id_type whoami;
};

struct HEADER_CHAT2CLIENT_SYSTEM_BOARDCAST {
    HEADER header;
//    uint32_t type;
    uint32_t length;
    char data[0];
};

struct HEADER_CHAT2CLIENT_LOGIN_RESULT {
    HEADER header;
    uint32_t cache_number[10];   //world/group/private cache number of talking, when success
};

typedef HEADER HEADER_CHAT2CLIENT_NOT_LOGIN;

struct HEADER_CHAT2CLIENT_GET_ONLINE_PLAYER_NUMBER_RESULT {
    HEADER header;
    int32_t world;
    int32_t group;
};
#pragma pack(pop)

