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
			
			$this->load->config('game_building_data');
			$this->load->model('data/buildings');
			$result = $this->buildings->get($objectId);
			$buildingId = intval($result->building_id);
			$buildingNextLevel = intval($result->building_level) + 1;
			$buildingData = $this->config->item('game_building_data');
			$buildingData = $buildingData[$buildingId];
			
			if($buildingNextLevel > intval($buildingData['building_max_level'])) {
				$jsonData = Array(
						'flag'			=>	0xA001,
						'message'	=>	-3
				);
				echo $this->return_format->format($jsonData, $format);
				$logParameter = array(
						'log_action'	=>	'BUILDING_UPGRADE_ERROR_MAX_LEVEL',
						'account_guid'	=>	'',
						'account_name'	=>	$accountId
				);
				$this->logs->write($logParameter);
				exit();
			}
			
			$this->load->config('game_dependency');
			$buildingDependencyData = $this->config->item('dependency_building');
			$buildingDependencyData = $buildingDependencyData[$buildingId][strval($buildingNextLevel)];
			
			//检查建筑是否满足要求
			$parameter = array(
				'account_id'	=>	$accountId
			);
			$buildingList = $this->buildings->getAllResult($parameter);
			foreach($buildingList as $value) {
				$need = $buildingDependencyData['building'][intval($value->building_id)]['building_level'];
				if(intval($value->building_level) < $need) {
					$jsonData = Array(
							'flag'			=>	0xA001,
							'message'	=>	-4
					);
					echo $this->return_format->format($jsonData, $format);
					$logParameter = array(
							'log_action'	=>	'BUILDING_UPGRADE_ERROR_NO_BUILDING',
							'account_guid'	=>	'',
							'account_name'	=>	$accountId
					);
					$this->logs->write($logParameter);
					exit();
				}
			}
			
			//检查资源是否足够
			$this->load->model('data/resources');
			$parameter = array(
				'account_id'	=>	$accountId
			);
			$resourceList = $this->resources->getAllResult($parameter);
			foreach($resourceList as $value) {
				$need = $buildingDependencyData['resource'][intval($value->resource_id)]['resource_amount'];
				if(intval($value->resource_current) < $need) {
					$jsonData = Array(
							'flag'			=>	0xA001,
							'message'	=>	-5
					);
					echo $this->return_format->format($jsonData, $format);
					$logParameter = array(
							'log_action'	=>	'BUILDING_UPGRADE_ERROR_NO_RESOURCE',
							'account_guid'	=>	'',
							'account_name'	=>	$accountId
					);
					$this->logs->write($logParameter);
					exit();
				}
			}
			
			//检查通过
			//扣除资源
			foreach($buildingDependencyData['resource'] as $key => $resource) {
				$parameter = array(
					'resource_current'	=>	'resource_current - ' . $resource['resource_amount']
				);
				$this->resources->update($parameter, $accountId, $key, FALSE);
			}
			
			//开始加入队列
			$parameter = array(
				'object_id'				=>	$objectId,
				'account_id'			=>	$accountId,
				'building_id'			=>	$result->building_id,
				'resource_id'			=>	$buildingData[strval($buildingNextLevel)]['resource_id'],
				'building_type'		=>	$result->building_type,
				'building_name'		=>	$result->building_name,
				'building_level'		=>	$buildingNextLevel,
				'building_consume'	=>	json_encode($buildingDependencyData['resource']),
				'building_pos_x'		=>	$result->building_pos_x,
				'building_pos_y'		=>	$result->building_pos_y,
				'building_finished_timestamp'=>	time() + $buildingDependencyData['duration']['duration_amount'],
				'queue_status'		=>	'PROCESS'
			);
			$queueId = $this->building_queue->insert($parameter);
			
			if($queueId !== FALSE) {
				$parameter = array(
					'queue_id'		=>	$queueId
				);
				$this->buildings->update($parameter, $objectId);
				$jsonData = Array(
						'flag'			=>	0xA001,
						'message'	=>	1,
						'object_id'	=>	$objectId,
						'queue_id'	=>	$queueId,
						'building_finished_timestamp'	=>	$parameter['building_finished_timestamp']
				);
				echo $this->return_format->format($jsonData, $format);
			
				$logParameter = array(
						'log_action'	=>	'BUILDING_UPGRADE_SUCCESS',
						'account_guid'	=>	'',
						'account_name'	=>	$accountId
				);
				$this->logs->write($logParameter);
			}
		} else {
			$jsonData = Array(
					'flag'			=>	0xA001,
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
	
	public function check_upgrade($format = 'json') {
		$queueId		=	$this->input->get_post('queue_id', TRUE);
		$objectId  		=	$this->input->get_post('object_id', TRUE);
		$accountId	=	$this->input->get_post('account_id', TRUE);
		$gameId		=	$this->input->get_post('game_id', TRUE);
		
		if(!empty($queueId) && !empty($objectId) && !empty($gameId)) {
			/*
			 * 检测参数合法性
			*/
			$authToken	=	$this->authKey[$gameId]['auth_key'];
			$check = array($queueId, $objectId, $accountId, $gameId);
			//$this->load->helper('security');
			//exit(do_hash(implode('|||', $check) . '|||' . $authToken));
			if(!$this->param_check->check($check, $authToken)) {
				$jsonData = Array(
						'flag'			=>	0xA002,
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
			
			$this->load->model('data/building_queue');
			$result = $this->building_queue->get($queueId);
			if($result->object_id != $objectId || $result->account_id != $accountId) {
				
			}
			$buildingId = intval($result->building_id);
			$buildingLevel = $result->building_level;
			$this->load->config('game_building_data');
			$this->load->config('game_dependency');
		} else {
			$jsonData = Array(
					'flag'			=>	0xA002,
					'message'	=>	-99
			);
			echo $this->return_format->format($jsonData, $format);
		
			$logParameter = array(
					'log_action'	=>	'BUILDING_CHECK_UPGRADE_ERROR_NO_PARAM',
					'account_guid'	=>	'',
					'account_name'	=>	$accountId
			);
			$this->logs->write($logParameter);
		}
	}
}
?>