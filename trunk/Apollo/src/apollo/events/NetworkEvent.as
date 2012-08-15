package apollo.events 
{
	/**
	 * ...
	 * @author john
	 */
	public class NetworkEvent extends TransferEvent 
	{
		public static const LOGIN_SUCCESS: String = 'login_success';
		public static const LOGIN_FAIL: String = 'login_fail';
		
		public static const REQUEST_CHARACTER: String = 'request_character';
		
		public static const ATTACK_CONFIRM: String = 'attack_confirm';
		public static const UNDERATTACK_CONFIRM: String = 'underattack_confirm';
		
		public static const NPC_ATTACK_REQUEST: String = 'npc_attack_request';
		public static const NPC_ATTACK_CONFIRM: String = 'npc_attack_confirm';
		
		public static const OBJECT_LIST_CONFIRM: String = 'object_list_confirm';
		
		public function NetworkEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}