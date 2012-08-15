package ui.form
{
	import wooha.Events.LoginEvent;
	import wooha.Network.Command.receiving.Receive_Info_RequestCharacter;
	import flash.utils.Dictionary;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.*;
	import org.aswing.colorchooser.*;
	import org.aswing.ext.*;

	/**
	 * MyPane
	 */
	public class UICharacterSelector extends JFrame
	{
		private var list: Dictionary;
		//members define
		private var panel:JPanel;
		private var btnStart:JButton;
		
		private var currentGuid: String;
		private var currentAuthKey: String
		
		/**
		 * MyPane Constructor
		 */
		public function UICharacterSelector(owner: * = null, title: String = null)
		{
			super(owner, title);
			list = new Dictionary();
			//component creation
			setSize(new IntDimension(542, 362));
			
			panel = new JPanel();
			panel.setLayout(new EmptyLayout());
			
			btnStart = new JButton();
			btnStart.setLocation(new IntPoint(400, 270));
			btnStart.setSize(new IntDimension(119, 37));
			btnStart.setText("开始游戏");
			btnStart.setEnabled(false);
			btnStart.addActionListener(onGameStart);
			
			//component layoution
			panel.setBorder(new EmptyBorder(null, new Insets(10,5,10,5)));
			getContentPane().append(panel);
			
			panel.append(btnStart);
		}
		
		public function showCharacterList(protocol: Receive_Info_RequestCharacter): void
		{
			if (protocol != null && protocol.guid != null)
			{
				var button: JRadioButton = new JRadioButton();
				button.setLocation(new IntPoint(50, 50));
				button.setSize(new IntDimension(141, 49));
				button.setText(protocol.characterName + "\n" + protocol.resourceId);
				button.addActionListener(onCharacterSelected);
				
				panel.append(button);
				list[button] = new Array(protocol.guid, protocol.authKey);
			}
		}
		
		private function onCharacterSelected(event: AWEvent): void
		{
			var button: JRadioButton = event.target as JRadioButton;
			var character: Array = list[button] as Array;
			currentGuid = character[0];
			currentAuthKey = character[1];
			
			btnStart.setEnabled(true);
		}
		
		private function onGameStart(evt: AWEvent): void
		{
			if (currentGuid != null && currentAuthKey != null)
			{
				var event: LoginEvent = new LoginEvent(LoginEvent.GAME_START);
				event.data = new Array(currentGuid, currentAuthKey);
				dispatchEvent(event);
			}
		}
		
		//_________getters_________
		
		public function getBtnStart():JButton{
			return btnStart;
		}
	}
}
