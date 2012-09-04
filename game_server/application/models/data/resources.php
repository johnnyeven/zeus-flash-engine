<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Resources extends CI_Model {
	private $accountTable = 'data_resources';
	private $datadb = null;
	
	public function __construct() {
		parent::__construct();
		$this->datadb = $this->load->database('datadb', true);
	}
	
	public function getAllResult($parameter = null, $limit = 0, $offset = 0, $type = 'data') {
		if($parameter != null)
		{
			if(!empty($parameter['account_id'])) {
				$this->datadb->where('account_id', $parameter['account_id']);
			}
			if(!empty($parameter['resource_id'])) {
				$this->datadb->where('resource_id', $parameter['resource_id']);
			}
		}
		if($limit==0 && $offset==0) {
			$query = $this->datadb->get($this->accountTable);
		} else {
			$query = $this->datadb->get($this->accountTable, $limit, $offset);
		}
		if($query->num_rows() > 0) {
			if($type=='data') {
				return $query->result();
			} elseif($type=='json') {
				
			}
		} else {
			return false;
		}
	}
	
	public function query($sql) {
		if(!empty($sql)) {
			return $this->datadb->query($sql);
		} else {
			return false;
		}
	}
	
	public function get($id) {
		if(!empty($id)) {
			$this->datadb->where('account_id', $id);
			$query = $this->datadb->get($this->accountTable);
			if($query->num_rows() > 0) {
				return $query->result();
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public function insert($row) {
		if(!empty($row)) {
			return $this->datadb->insert($this->accountTable, $row);
		} else {
			return false;
		}
	}

	public function update($row, $accountId, $resourceId, $autoConvert = TRUE) {
		if(!empty($row)) {
			$this->datadb->where('account_id', $accountId);
			$this->datadb->where('resource_id', $resourceId);
			if($autoConvert) {
				return $this->datadb->update($this->accountTable, $row);
			} else {
				foreach($row as $key => $value) {
					$this->datadb->set($key, $value);
				}
				return $this->datadb->update($this->accountTable);
			}
		} else {
			return false;
		}
	}
	
	public function delete($accountId, $resourceId) {
		if(!empty($accountId) && !empty($resourceId)) {
			$this->datadb->where('account_id', $accountId);
			$this->datadb->where('resource_id', $resourceId);
			return $this->datadb->delete($this->accountTable);
		} else {
			return false;
		}
	}
}
?>