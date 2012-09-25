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
	
	public function demo($format = 'json') {
		$gameId		=	$this->input->get_post('game_id', TRUE);
		//$section_id	=	$this->input->get_post('server_section', TRUE);
		//$server_id	=	$this->input->get_post('server_id', TRUE);
	
		$this->load->library('guid');
		$this->load->helper('security');
		$guid = do_hash($this->guid->toString(), 'md5');
		$name = 'Guest' . $guid;
		$pass = do_hash($guid, 'md5');
	
		//if($section_id === FALSE) {
		//$section_id = $this->config->item('game_section_id');
		//}
		//if($server_id === FALSE) {
		$this->load->model('websrv/server', 'server');
		$parameter = array(
				'game_id'				=>	$gameId,
				'server_recommend'		=>	'1'
		);
		$result = $this->server->getAllResult($parameter);
		if($result!=FALSE) {
			$section_id = $result[0]->account_server_section;
			$server_id = $result[0]->account_server_id;
		} else {
			$parameter = array(
					'game_id'				=>	$gameId,
					'order_by'				=>	'account_count'
			);
			$result = $this->server->getAllResult($parameter);
			$section_id = $result[0]->account_server_section;
			$server_id = $result[0]->account_server_id;
		}
		//}
	
		if(!empty($name) && !empty($pass) &&
				$gameId!==FALSE &&
				!empty($server_id) &&
				!empty($section_id)) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($gameId);
			//$this->load->helper('security');
			//exit(do_hash(do_hash(implode('|||', $check) . '|||' . $authToken, 'md5')));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'message'	=>	'PARAM_INVALID'
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'	=>	'PARAM_INVALID',
						'account_guid'	=>	'',
						'account_name'	=>	$name
				);
				$this->logs->write($logParameter);
				exit();
			}
			/*
			 * 检查完毕
			*/
			if($this->web_account->validate_duplicate($name, $pass, $gameId, $server_id, $section_id)) {
				$parameter = array(
						'name'		=>	$name,
						'pass'		=>	$pass,
						'email'		=>	'',
						'game_id'	=>	$gameId,
						'server_id'	=>	$server_id,
						'server_section'=>	$section_id
				);
				$guid = $this->web_account->register($parameter);
				if(!empty($guid)) {
					$user = $this->web_account->get($guid);
					unset($user->account_secret_key);
					$user->account_pass = $pass;
					$nickName = substr($user->account_name, 0, 11);
					$accountId = $this->_registerAccountId($guid, $gameId, $server_id, $section_id, $nickName);
	
					$jsonData = Array(
							'message'	=>	'ACCOUNT_DEMO_SUCCESS',
							'user'		=>	$user,
							'account_id'=>	$accountId,
							'nick_name'	=>	$nickName
					);
					echo $this->return_format->format($jsonData, $format);
						
					$logParameter = array(
							'log_action'	=>	'ACCOUNT_DEMO_SUCCESS',
							'account_guid'	=>	$user->GUID,
							'account_name'	=>	$user->account_name,
							'game_id'			=>	$gameId,
							'section_id'			=>	$section_id,
							'server_id'			=>	$server_id
					);
					$this->logs->write($logParameter);
				} else {
					$jsonData = Array(
							'message'	=>	'ACCOUNT_DEMO_FAIL'
					);
					echo $this->return_format->format($jsonData, $format);
						
					$logParameter = array(
							'log_action'	=>	'ACCOUNT_DEMO_FAIL',
							'account_guid'	=>	'',
							'account_name'	=>	$name,
							'game_id'			=>	$gameId,
							'section_id'			=>	$section_id,
							'server_id'			=>	$server_id
					);
					$this->logs->write($logParameter);
				}
			} else {
				$jsonData = Array(
						'message'	=>	'ACCOUNT_ERROR_DUPLICATE'
				);
				echo $this->return_format->format($jsonData, $format);
	
				$logParameter = array(
						'log_action'	=>	'ACCOUNT_DEMO_FAIL_DUPLICATE',
						'account_guid'	=>	'',
						'account_name'	=>	$name,
						'game_id'			=>	$gameId,
						'section_id'			=>	$section_id,
						'server_id'			=>	$server_id
				);
				$this->logs->write($logParameter);
			}
		} else {
			$jsonData = Array(
					'message'	=>	'ACCOUNT_ERROR_NO_PARAM'
			);
			echo $this->return_format->format($jsonData, $format);
				
			$logParameter = array(
					'log_action'	=>	'ACCOUNT_DEMO_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	''
			);
			$this->logs->write($logParameter);
		}
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
						'message'	=>	0
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
						'message'	=>	-1
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
					'message'	=>	-99
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
	
	public function requestAccountId($format = 'json') {
		$accountGuid	=	$this->input->get_post('guid', TRUE);
		$nickName		=	$this->input->get_post('nick_name', TRUE);
		$gameId			=	$this->input->get_post('game_id', TRUE);
		$serverSection	=	$this->input->get_post('server_section', TRUE);
		$serverId		=	$this->input->get_post('server_id', TRUE);
		$autoCreate		=	$this->input->get_post('auto_create', TRUE);
	
		if($autoCreate === FALSE || ($autoCreate !== '0' && $autoCreate !== '1')) {
			$autoCreate = true;
		} else {
			$autoCreate = $autoCreate=='1' ? true : false;
		}
		$nickName = $nickName===FALSE ? '' : $nickName;
	
		$this->load->model('game_account');
		$this->load->model('game_product');
	
		if(!empty($accountGuid) &&
				$gameId!==FALSE &&
				$serverId!==FALSE &&
				$serverSection!==FALSE) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($accountGuid, $gameId, $serverSection, $serverId);
			//$this->load->helper('security');
			//exit(do_hash(implode('|||', $check) . '|||' . $authToken));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0x0400,
						'message'	=>	0
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'	=>	'PARAM_INVALID',
						'account_guid'	=>	$accountGuid,
						'account_name'	=>	''
				);
				$this->logs->write($logParameter);
				exit();
			}
			/*
			 * 检查完毕
			*/
			if($this->game_product->get($gameId) != false) {
				if($this->web_account->get($accountGuid) != false) {
					$parameter = array(
							'account_guid'				=>	$accountGuid,
							'game_id'					=>	$gameId,
							'account_server_id'			=>	$serverId,
							'account_server_section'	=>	$serverSection
					);
					$result = $this->game_account->getAllResult($parameter);
					if($result != FALSE) {
						$accountId = $result[0]->account_id;
						$accountParameter = $result[0];
					} else {
						if($autoCreate) {
							$accountParameter = $this->_registerAccountId($accountGuid, $gameId, $serverId, $serverSection, $nickName);
							$accountId = $accountParameter['account_id'];
							if($accountId === FALSE) {
								$jsonData = Array(
										'flag'			=>	0x0400,
										'message'	=>	-1
								);
								exit($this->return_format->format($jsonData, $format));
							}
						} else {
							$jsonData = Array(
									'flag'			=>	0x0400,
									'message'	=>	-2
							);
							exit($this->return_format->format($jsonData, $format));
								
							$logParameter = array(
									'log_action'	=>	'ACCOUNT_ERROR_NO_ID',
									'account_guid'	=>	$accountGuid,
									'account_name'	=>	''
							);
							$this->logs->write($logParameter);
						}
					}
					$jsonData = Array(
							'flag'				=>	0x0400,
							'message'		=>	1,
							'account_id'	=>	$accountId,
							'nick_name'	=>	$nickName,
							'max_building_queue'	=>	!is_array($accountParameter) ? $accountParameter->account_max_building_queue : $accountParameter['account_max_building_queue'],
							'max_skill_queue'		=>	!is_array($accountParameter) ? $accountParameter->account_max_skill_queue : $accountParameter['account_max_skill_queue']
					);
					echo $this->return_format->format($jsonData, $format);
						
					$logParameter = array(
							'log_action'	=>	'ACCOUNT_REQUEST_ID_SUCCESS',
							'account_guid'	=>	$accountGuid,
							'account_name'	=>	$accountId
					);
					$this->logs->write($logParameter);
				} else {
					$jsonData = Array(
							'flag'			=>	0x0400,
							'message'	=>	-3
					);
					echo $this->return_format->format($jsonData, $format);
						
					$logParameter = array(
							'log_action'	=>	'ACCOUNT_ERROR_NO_GUID',
							'account_guid'	=>	$accountGuid,
							'account_name'	=>	''
					);
					$this->logs->write($logParameter);
				}
			} else {
				$jsonData = Array(
						'flag'			=>	0x0400,
						'message'	=>	-4
				);
				echo $this->return_format->format($jsonData, $format);
	
				$logParameter = array(
						'log_action'	=>	'ACCOUNT_ERROR_NO_GAME',
						'account_guid'	=>	$accountGuid,
						'account_name'	=>	''
				);
				$this->logs->write($logParameter);
			}
		} else {
			$jsonData = Array(
					'flag'			=>	0x0400,
					'message'	=>	-99
			);
			echo $this->return_format->format($jsonData, $format);
				
			$logParameter = array(
					'log_action'	=>	'ACCOUNT_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	''
			);
			$this->logs->write($logParameter);
		}
	}
	
	private function _registerAccountId($accountGuid, $gameId, $serverId, $serverSection, $nickName = '') {
		$this->load->config('game_init_data');
		if(!empty($accountGuid) &&
				$gameId!==FALSE &&
				$serverId!==FALSE &&
				$serverSection!==FALSE) {
			$this->load->model('game_account');
			$accountId = $this->_generateAccountId($gameId, $serverId, $serverSection);
			if($accountId === false) {
				return false;
			}
			$parameter = array(
					'account_id'			=>	$accountId,
					'account_guid'			=>	$accountGuid,
					'game_id'				=>	$gameId,
					'account_server_id'		=>	$serverId,
					'account_server_section'=>	$serverSection,
					'nick_name'				=>	$nickName,
					'account_max_building_queue'			=>	$this->config->item('init_data_max_building_queue'),
					'account_max_skill_queue'				=>	$this->config->item('init_data_max_skill_queue')
			);
			$this->game_account->insert($parameter);
			$this->load->model('data/account_added_game', 'account_game');
			$gameAdded = $this->account_game->get($accountGuid, $gameId);
			if($gameAdded===FALSE) {
				$parameter1 = array(
						'GUID'		=>	$accountGuid,
						'game_id'	=>	$gameId
				);
				$this->account_game->insert($parameter1);
			}
			$this->_initAccountData($accountId);
			return $parameter;
		} else {
			return false;
		}
	}
	
	private function _generateAccountId($gameId, $serverId, $serverSection) {
		$this->load->model('data/account_count');
		$parameter = array(
				'game_id'				=>	$gameId,
				'account_server_id'		=>	$serverId,
				'account_server_section'=>	$serverSection
		);
		$nextAvailableId = $this->account_count->getNextAvailableId($parameter);
		if($nextAvailableId < 0) {
			return false;
		}
		/*
			$code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$accountId = substr($code, $gameId - 1, 1);
		$accountId .= substr($code, $serverSection - 1, 1);
		$accountId .= substr($code, $serverId - 1, 1);
		*/
		$accountId = $gameId . $serverSection . $serverId;
	
		$containCount = $this->config->item('contain_id_count');
		$accountId .= sprintf('%0' . $containCount . 'd', $nextAvailableId);
		return $accountId;
	}
	
	private function _initAccountData($accountId) {
		$this->load->config('game_building_data');
		$this->load->config('game_init_data');
		$this->load->config('game_dependency');
		
		$this->load->model('data/buildings', 'building');
		$this->load->library('Guid');
		
		$dependencyBuilding = $this->config->item('dependency_building');
		$initResourceIncremental = array();
		foreach($this->config->item('init_data_building') as $key => $value) {
			$buildingData = $this->config->item('game_building_data');
			$building = $buildingData[intval($key)];
			$parameter  = array(
				'object_id'							=>	$this->guid->newGuid()->toString(),
				'account_id'						=>	$accountId,
				'building_id'						=>	intval($key),
				'resource_id'						=>	$building[strval($value['building_level'])]['resource_id'],
				'building_type'					=>	$building['building_type'],
				'building_name'					=>	$building['building_name'],
				'building_level'					=>	$value['building_level'],
				'building_dependency'		=>	empty($dependencyBuilding[intval($key)]) ? '' : json_encode($dependencyBuilding[intval($key)]),
				'building_consume'				=>	empty($building[strval($value['building_level'])]['building_consume']) ? '' : json_encode($building[strval($value['building_level'])]['building_consume']),
				'building_produce'				=>	empty($building[strval($value['building_level'])]['building_produce']) ? '' : json_encode($building[strval($value['building_level'])]['building_produce']),
				'building_pos_x'					=>	$value['building_pos_x'],
				'building_pos_y'					=>	$value['building_pos_y']
			);
			$this->building->insert($parameter);
			
			foreach($building[strval($value['building_level'])]['building_consume'] as $key => $row) {
				$initResourceIncremental[$key] += intval($row['resource_incremental']);
			}
			foreach($building[strval($value['building_level'])]['building_produce'] as $key => $row) {
				$initResourceIncremental[$key] += intval($row['resource_incremental']);
			}
		}

		$this->load->model('data/resources', 'resource');
		foreach($this->config->item('init_data_resources') as $key => $value) {
			$parameter = array(
				'account_id'			=>	$accountId,
				'resource_id'			=>	intval($key),
				'resource_name'		=>	$value['resource_name'],
				'resource_current'	=>	$value['resource_current'],
				'resource_max'		=>	$value['resource_max'],
				'resource_incremental'	=>	$value['resource_incremental'] + $initResourceIncremental[$key],
				'resource_last_increase'	=>	time()
			);
			$this->resource->insert($parameter);
		}
	}
	
	public function requestViewObjects($format = 'json') {
		$accountId	=	$this->input->get_post('account_id', TRUE);
		$gameId		=	$this->input->get_post('game_id', TRUE);
		
		if(!empty($accountId) && !empty($gameId)) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($accountId, $gameId);
			//$this->load->helper('security');
			//exit(do_hash(implode('|||', $check) . '|||' . $authToken));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0x0000,
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
			
			$this->load->model('data/buildings', 'building');
			$parameter = array(
				'account_id'		=>	$accountId
			);
			$buildingResult = $this->building->getAllResult($parameter);
			
			$jsonData = array(
				'flag'						=>	0x0000,
				'message'				=>	1,
				'building_list'			=>	$buildingResult
			);
			echo $this->return_format->format($jsonData, $format);
		} else {
			$jsonData = Array(
					'flag'			=>	0x0000,
					'message'	=>	-99
			);
			echo $this->return_format->format($jsonData, $format);
				
			$logParameter = array(
					'log_action'	=>	'ACCOUNT_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	$accountId
			);
			$this->logs->write($logParameter);
		}
	}
	
	public function requestResources($format = 'json') {
		$accountId = $this->input->get_post('account_id', TRUE);
		$gameId = $this->input->get_post('game_id', TRUE);
		
		if(!empty($accountId)) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($accountId, $gameId);
			//$this->load->helper('security');
			//exit(do_hash(do_hash(implode('|||', $check) . '|||' . $authToken, 'md5')));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0x0001,
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
			
			$this->load->model('data/resources', 'resource');
			$this->load->helper('template');
			$this->load->config('game_init_data');
			$sql = $this->config->item('sql_update_resource_amount');
			$parser = array(
				'update_time'		=>	$this->config->item('resource_update_time'),
				'account_id'		=>	$accountId
			);
			$this->resource->query(parseTemplate($sql, $parser));
			$result = $this->resource->get($accountId);
			if($result != FALSE) {
				$jsonData = Array(
					'flag'			=>	0x0001,
					'message'	=>	1,
					'resource_list'	=>	$result
				);
				echo $this->return_format->format($jsonData, $format);
					
				$logParameter = array(
						'log_action'	=>	'ACCOUNT_REQUEST_RESOURCE_SUCCESS',
						'account_guid'	=>	'',
						'account_name'	=>	$accountId
				);
				$this->logs->write($logParameter);
			} else {
				$jsonData = Array(
						'flag'			=>	0x0001,
						'message'	=>	-1
				);
				echo $this->return_format->format($jsonData, $format);
					
				$logParameter = array(
						'log_action'	=>	'ACCOUNT_ERROR_NO_ACCOUNTID',
						'account_guid'	=>	'',
						'account_name'	=>	$accountId
				);
				$this->logs->write($logParameter);
			}
		} else {
			$jsonData = Array(
					'flag'			=>	0x0001,
					'message'	=>	-99
			);
			echo $this->return_format->format($jsonData, $format);
				
			$logParameter = array(
					'log_action'	=>	'ACCOUNT_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	''
			);
			$this->logs->write($logParameter);
		}
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */