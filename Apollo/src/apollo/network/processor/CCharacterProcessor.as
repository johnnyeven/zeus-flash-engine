package apollo.network.processor 
{
	import apollo.events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import apollo.CWoohaGame;
	import apollo.objects.*;
	import apollo.scene.CApolloScene;
	import apollo.configuration.*;
	import apollo.network.command.CCommandList;
	import apollo.network.command.receiving.*;
	
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
							var scene: CApolloScene = CApolloScene.getInstance();
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