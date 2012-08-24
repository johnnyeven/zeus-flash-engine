///////////////////////////////////////////////////////////
//  CBuildingController.as
//  Macromedia ActionScript Implementation of the Class CBuildingController
//  Generated by Enterprise Architect
//  Created on:      15-二月-2012 10:17:53
//  Original author: Administrator
///////////////////////////////////////////////////////////

package apollo.controller
{
	import apollo.center.CCommandCenter;
	import apollo.center.CUICenter;
	import apollo.CGame;
	import apollo.network.command.sending.Send_Building_Upgrade;
	import apollo.objects.CBuildingObject;
	import apollo.objects.CGameObject;
	import apollo.scene.CApolloScene;
	import apollo.ui.UIBuildingUpdateForm;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.aswing.event.AWEvent;
	
	import ui.components.*;
	import apollo.graphics.CGraphicPool;

	/**
	 * @author Administrator
	 * @version 1.0
	 * @created 15-二月-2012 10:17:53
	 */

	public class CBuildingController extends CBaseController
	{
		public function CBuildingController(per: CPerception)
		{
			super(per);
		}
		
		override public function calcAction(): void
		{
			
		}

		override public function setupListener(): void
		{
			_controlObject.addEventListener(MouseEvent.CLICK, onObjectClick, false, 0, true);
		}

		override public function removeListener(): void
		{
			_controlObject.removeEventListener(MouseEvent.CLICK, onObjectClick);
		}
		
		private function onObjectClick(evt: MouseEvent): void
		{
			evt.stopImmediatePropagation();
			var o: CBuildingObject = _controlObject as CBuildingObject;
			o.menu = new UIMenu();
			switch (o.buildingId)
			{
				case 0xAA01:
					o.menu.addMenuItem("升级", onMenuUpdate);
					o.menu.addMenuItem("信息", onMenuInfo);
					break;
				case 0xAA02:
					o.menu.addMenuItem("精炼", onMenuUpdate);
					o.menu.addMenuItem("信息", onMenuInfo);
					break;
				case 0xAA03:
					o.menu.addMenuItem("扫描", onMenuUpdate);
					o.menu.addMenuItem("信息", onMenuInfo);
					break;
			}
			o.addAdditionalDisplay(o.menu);
			o.menu.slideDown();
			CGame.getInstance().addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		private function onStageClick(evt: MouseEvent): void
		{
			_perception.scene.stage.removeEventListener(MouseEvent.CLICK, onStageClick);
			var o: CBuildingObject = _controlObject as CBuildingObject;
			o.menu.slideUp();
		}
		
		private function onMenuUpdate(evt: MouseEvent): void
		{
			evt.stopImmediatePropagation();
			var o: CBuildingObject = _controlObject as CBuildingObject;
			var form: UIBuildingUpdateForm = CGraphicPool.getInstance().getUI("UIBuildingUpdateForm") as UIBuildingUpdateForm;
			form.setTitle(o.buildingName);
			form.setBtnSubmitListener(onBtnUpdateClick);
			CGame.getInstance().addChild(form);
		}
		
		private function onBtnUpdateClick(evt: AWEvent): void
		{
			var protocol: Send_Building_Upgrade = new Send_Building_Upgrade();
			protocol.ObjectId = _controlObject.objectId;
			CCommandCenter.getInstance().send(protocol);
		}
		
		private function onMenuInfo(evt: MouseEvent): void
		{
			evt.stopImmediatePropagation();
			trace('2 click');
		}

	} //end CBuildingController

}