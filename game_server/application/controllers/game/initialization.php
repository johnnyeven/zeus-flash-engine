<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Initialization extends CI_Controller {
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
	
	public function login($format = 'json') {
		$accountName  = $this->input->get_post('user_name', TRUE);
		$accountPass  = $this->input->get_post('user_pass', TRUE);
		$gameId		=	$this->input->get_post('game_id', TRUE);
		$section_id	=	$this->input->get_post('server_section', TRUE);
		
		if(!empty($accountName) && !empty($accountPass) &&
				$gameId!==FALSE && $section_id!==FALSE) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($accountName, $accountPass, $gameId, $section_id);
			//$this->load->helper('security');
			//exit(do_hash(implode('|||', $check) . '|||' . $authToken));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0x0100,
						'message'	=>	4
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'	=>	'PARAM_INVALID',
						'account_guid'	=>	'',
						'account_name'	=>	$accountName
				);
				$this->logs->write($logParameter);
				exit();
			}
			/*
			 * 检查完毕
			*/
				
			$user = $this->web_account->validate($accountName, $accountPass, $gameId, $section_id);
			if($user != FALSE) {
				$cookieString = json_encode($user);
				$this->load->helper('cookie');
				$cookie = array(
						'name'		=> 'user',
						'value'		=> $cookieString,
						'expire'	=> $this->config->item('cookie_expire'),
						'domain'	=> $this->config->item('cookie_domain'),
						'path'		=> $this->config->item('cookie_path'),
						'prefix'	=> $this->config->item('cookie_prefix')
				);
				$this->input->set_cookie($cookie);
				 
				unset($user->account_pass);
				unset($user->account_secret_key);
				$jsonData = Array(
					'flag'			=>	0x0100,
					'message'	=>	1,
					'guid'		=>	$user->GUID
				);
				echo $this->return_format->format($jsonData, $format);
					
				$logParameter = array(
						'log_action'	=>	'ACCOUNT_LOGIN_SUCCESS',
						'account_guid'	=>	$user->GUID,
						'account_name'	=>	$user->account_name
				);
				$this->logs->write($logParameter);
			} else {
				$jsonData = Array(
						'flag'			=>	0x0100,
						'message'	=>	3
				);
				echo $this->return_format->format($jsonData, $format);
					
				$logParameter = array(
						'log_action'	=>	'ACCOUNT_LOGIN_FAIL',
						'account_guid'	=>	'',
						'account_name'	=>	$accountName
				);
				$this->logs->write($logParameter);
			}
		} else {
			$jsonData = Array(
					'flag'			=>	0x0100,
					'message'	=>	0
			);
			echo $this->return_format->format($jsonData, $format);
		
			$logParameter = array(
					'log_action'	=>	'ACCOUNT_LOGIN_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	''
			);
			$this->logs->write($logParameter);
		}
	}
	
	public function requestCharacterList($format = 'json') {
		$guid  			=	$this->input->get_post('guid', TRUE);
		$gameId		=	$this->input->get_post('game_id', TRUE);
		$section_id	=	$this->input->get_post('server_section', TRUE);
		$server_id  	=	$this->input->get_post('server_id', TRUE);
		
		if(!empty($guid) && $gameId!==FALSE && $section_id!==FALSE && $server_id!==FALSE) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($guid, $gameId, $section_id, $server_id);
			//$this->load->helper('security');
			//exit(do_hash(implode('|||', $check) . '|||' . $authToken));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0x0400,
						'message'	=>	-4
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'		=>	'PARAM_INVALID',
						'account_guid'	=>	$guid
				);
				$this->logs->write($logParameter);
				exit();
			}
			/*
			 * 检查完毕
			*/
			$this->load->model('game_account');
			$parameter = array(
				'account_guid'				=>	$guid,
				'game_id'						=>	$gameId,
				'account_server_section'	=>	$section_id,
				'account_server_id'			=>	$server_id
			);
			$result = $this->game_account->getAllResult($parameter);
			$jsonData = Array(
				'flag'			=>	0x0400,
				'message'	=>	1,
				'result'		=>	$result
			);
			echo $this->return_format->format($jsonData, $format);
		} else {
			$jsonData = Array(
					'flag'			=>	0x0400,
					'message'	=>	0
			);
			echo $this->return_format->format($jsonData, $format);
			
			$logParameter = array(
					'log_action'	=>	'ACCOUNT_LOGIN_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	''
			);
			$this->logs->write($logParameter);
		}
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */