<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Web_account extends CI_Model {
	private $accountTable = 'web_account';
	private $accountdb = null;
	
	public function __construct() {
		parent::__construct();
		$this->accountdb = $this->load->database('accountdb', true);
		$this->load->library('Guid');
	}
	
	public function validate($userName, $userPass, $gameId, $sectionId) {
		if(!empty($userName) && !empty($userPass) &&
		$gameId!==FALSE &&
		//$serverId!==FALSE &&
		$sectionId!==FALSE) {
			$this->load->helper('security');
			$userPass = $this->encrypt_pass($userPass);
			$this->accountdb->where('account_name', trim($userName));
			$this->accountdb->where('account_pass', $userPass);
			//$this->accountdb->where('game_id', $gameId);
			//$this->accountdb->where('server_id', $serverId);
			$this->accountdb->where('server_section', $sectionId);
			$query = $this->accountdb->get($this->accountTable);
			if($query->num_rows() > 0) {
				return $query->row();
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public function validate_duplicate($userName, $userPass, $gameId, $serverId, $sectionId, $useEncrypt = true) {
		$this->load->helper('security');
		$this->accountdb->where('account_name', trim($userName));
		if($useEncrypt) {
			$userPass = $this->encrypt_pass($userPass);
		}
		$this->accountdb->where('account_pass', $userPass);
		//$this->accountdb->where('game_id', $gameId);
		//$this->accountdb->where('server_id', $serverId);
		$this->accountdb->where('server_section', $sectionId);
		$query = $this->accountdb->get($this->accountTable);
		if($query->num_rows() > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public function encrypt_pass($pass) {
		$this->load->helper('security');
		return strtoupper(do_hash(do_hash($pass, 'md5') . do_hash($pass), 'md5'));
	}
	
	public function register($parameter) {
		if(!empty($parameter['name']) &&
		!empty($parameter['pass'])) {
			$this->load->helper('security');
			
			$parameter['pass'] = $this->encrypt_pass($parameter['pass']);
			$guid = $this->guid->toString();
			$insertArray = array(
				'GUID'					=>	$guid,
				'account_name'			=>	$parameter['name'],
				'account_pass'			=>	$parameter['pass'],
				'account_email'			=>	$parameter['email'],
				'account_country'		=>	$parameter['country'],
				'account_firstname'		=>	$parameter['firstname'],
				'account_lastname'		=>	$parameter['lastname'],
				'account_pass_question'	=>	$parameter['question'],
				'account_pass_answer'	=>	$parameter['answer'],
				'game_id'				=>	$parameter['game_id'],
				'server_id'				=>	$parameter['server_id'],
				'server_section'		=>	$parameter['server_section'],
				'account_regtime'		=>	time()
			);
			if($this->accountdb->insert($this->accountTable, $insertArray)) {
				return $guid;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public function get($id) {
		if(!empty($id)) {
			$this->accountdb->where('GUID', $id);
			$query = $this->accountdb->get($this->accountTable);
			if($query->num_rows() > 0) {
				return $query->row();
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public function update($row, $guid) {
		if(!empty($row)) {
			$this->accountdb->where('GUID', $guid);
			return $this->accountdb->update($this->accountTable, $row);
		} else {
			return false;
		}
	}
}
?>