<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Building extends CI_Controller {
	private $root_path = null;
	private $authKey = null;
	
	public function __construct() {
		parent::__construct();
		$this->root_path = $this->config->item('root_path');
		$this->load->model('web_account');
		$this->load->model('logs');
		$this->load->model('return_format');
		$this->load->model('param_check');
		$this->authKey = $this->config->item('game_auth_key');
	}
	
	public function upgrade($format = 'json') {
		$objectId  		=	$this->input->get_post('object_id', TRUE);
		$accountId	=	$this->input->get_post('account_id', TRUE);
		$gameId		=	$this->input->get_post('game_id', TRUE);
		
		if(!empty($objectId) && !empty($gameId)) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($objectId, $accountId, $gameId);
			//$this->load->helper('security');
			//exit(do_hash(implode('|||', $check) . '|||' . $authToken));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0x0100,
						'message'	=>	0
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'	=>	'PARAM_INVALID',
						'account_guid'	=>	'',
						'account_name'	=>	$accountId
				);
				$this->logs->write($logParameter);
				exit();
			}
			/*
			 * 检查完毕
			*/
		} else {
			$jsonData = Array(
					'flag'			=>	0x0100,
					'message'	=>	-99
			);
			echo $this->return_format->format($jsonData, $format);
		
			$logParameter = array(
					'log_action'	=>	'BUILDING_UPGRADE_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	$accountId
			);
			$this->logs->write($logParameter);
		}
	}
}
?>