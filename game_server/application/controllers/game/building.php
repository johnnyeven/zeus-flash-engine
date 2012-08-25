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
						'flag'			=>	0xA001,
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
			$this->load->model('game_account');
			$accountResult = $this->game_account->get($accountId);
			if($accountResult==FALSE) {
				$jsonData = Array(
						'flag'			=>	0xA001,
						'message'	=>	-1
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'	=>	'BUILDING_UPGRADE_ERROR_NO_ACCOUNTID',
						'account_guid'	=>	'',
						'account_name'	=>	$accountId
				);
				$this->logs->write($logParameter);
				exit();
			}
			if(intval($accountResult->account_max_building_queue) > 0) {
				$this->load->model('data/building_queue');
				$parameter = array(
					'account_id'		=>	$accountId
				);
				$currentQueueCount = $this->building_queue->getCount($parameter);
				
				if($currentQueueCount >= intval($accountResult->account_max_building_queue)) {
					$jsonData = Array(
							'flag'			=>	0xA001,
							'message'	=>	-2
					);
					echo $this->return_format->format($jsonData, $format);
					$logParameter = array(
							'log_action'	=>	'BUILDING_UPGRADE_ERROR_MAX_QUEUE',
							'account_guid'	=>	'',
							'account_name'	=>	$accountId
					);
					$this->logs->write($logParameter);
					exit();
				}
			}
			
			$this->load->model('data/buildings');
			$result = $this->buildings->get($objectId);
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