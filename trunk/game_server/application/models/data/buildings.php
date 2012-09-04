<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Buildings extends CI_Model {
	private $accountTable = 'data_building';
	private $datadb = null;
	
	public function __construct() {
		parent::__construct();
		$this->datadb = $this->load->database('datadb', true);
	}
	
	public function getAllResult($parameter = null, $limit = 0, $offset = 0, $type = 'data') {
		if($parameter != null)
		{
			if(!empty($parameter['object_id'])) {
				$this->datadb->where('object_id', $parameter['object_id']);
			}
			if(!empty($parameter['account_id'])) {
				$this->datadb->where('account_id', $parameter['account_id']);
			}
			if(!empty($parameter['building_id'])) {
				$this->datadb->where('building_id', $parameter['building_id']);
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
			$this->datadb->where('object_id', $id);
			$query = $this->datadb->get($this->accountTable);
			if($query->num_rows() > 0) {
				return $query->row();
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

	public function update($row, $id) {
		if(!empty($row)) {
			$this->datadb->where('object_id', $id);
			return $this->datadb->update($this->accountTable, $row);
		} else {
			return false;
		}
	}
	
	public function delete($id) {
		if(!empty($id)) {
			$this->datadb->where('object_id', $id);
			return $this->datadb->delete($this->accountTable);
		} else {
			return false;
		}
	}
}
?>