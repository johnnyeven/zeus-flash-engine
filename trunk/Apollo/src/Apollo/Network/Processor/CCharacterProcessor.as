package Apollo.Network.Processor 
{
	import Apollo.Events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import Apollo.CWoohaGame;
	import Apollo.Objects.*;
	import Apollo.Scene.CWoohaScene;
	import Apollo.Configuration.*;
	import Apollo.Network.Command.CCommandList;
	import Apollo.Network.Command.receiving.*;
	
	/**
	 * ...
	 * @author john
	 */
	public class CCharacterProcessor extends CBaseProcessor 
	{
		
		public function CCharacterProcessor() 
		{
			super("Processor.CharacterProcessor");
			var commandList: CCommandList = CCommandList.getInstance();
			commandList.bind(0x0003, Receive_Battle_Attack);
		}
		
		override public function hook():void 
		{
			commandCenter.add(0x0003, onAttackConfirm);
		}
		
		override public function unhook():void 
		{
			commandCenter.remove(0x0003, onAttackConfirm);
		}
		
		private function onAttackConfirm(protocol: Receive_Battle_Attack): void
		{
			if (protocol.AttackInfo.length > 0)
			{
				for each(var o: Object in protocol.AttackInfo)
				{
					if (o.TargetId != null)
					{
						if (o.TargetId != '')
						{
							var scene: CWoohaScene = CWoohaScene.getInstance();
							var target: CCharacterObject = scene.getCharacterById(o.TargetId);
							target.underAttack(o.AttackPower);
						}
					}
				}
			}
			else
			{
				trace("范围攻击没有击中目标");
			}
		}
	}

}