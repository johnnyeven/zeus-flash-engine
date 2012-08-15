<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Param_check extends CI_Model {
	
	public function __construct() {
		parent::__construct();
	}
	
	public function check($parameter, $authkey) {
		$this->load->helper('security');
		$checkCode = $this->input->get_post('check_code', TRUE);
		$paramString = implode('|||', $parameter) . '|||' . $authkey;
		$paramString = do_hash(do_hash($paramString, 'md5'));
		return $checkCode == $paramString;
	}
}
?>