package view.login
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import ui.components.TextInput;
	import ui.core.Component;
	
	import vo.ServerItemVO;
	
	/**
	 *服务器选择显示条 
	 * @author lw
	 * 
	 */	
	public class BarComponent extends Component
	{
		private var _severNameTxt:TextField;
		private var _otherInforTxt:TextField;
		private var _data:ServerItemVO;
		public function BarComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			_severNameTxt = getSkin("severName");
			_otherInforTxt = getSkin("otherInfor");
			sortChildIndex();
		}
		
		public function set data(serverItemVO:ServerItemVO):void
		{
			_data = serverItemVO;
			_severNameTxt.text = serverItemVO.server_name + "(Language:"+serverItemVO.server_language +",ID:"+ serverItemVO.account_server_id+")";
			_otherInforTxt.text = "Load:"+serverItemVO.account_count +"";
		}
		
		public function get data():ServerItemVO
		{
			return _data;
		}
	}
}