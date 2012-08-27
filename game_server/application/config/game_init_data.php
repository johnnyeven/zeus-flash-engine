<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$config['init_data_max_building_queue']		=	2;
$config['init_data_max_skill_queue']				=	5;
$config['init_data_resources'] = array(
	0x0001	=>	array(
		'resource_name'				=>	'木材',
		'resource_current'			=>	10000,
		'resource_max'				=>	100000,
		'resource_incremental'	=>	0
	),
	0x0002	=>	array(
		'resource_name'				=>	'石材',
		'resource_current'			=>	10000,
		'resource_max'				=>	100000,
		'resource_incremental'	=>	0
	),
	0x0003	=>	array(
		'resource_name'				=>	'粮食',
		'resource_current'			=>	5000,
		'resource_max'				=>	100000,
		'resource_incremental'	=>	0
	),
	0x0004	=>	array(
		'resource_name'				=>	'肉类',
		'resource_current'			=>	5000,
		'resource_max'				=>	100000,
		'resource_incremental'	=>	0
	),
	0x0005	=>	array(
		'resource_name'				=>	'黄金',
		'resource_current'			=>	1000,
		'resource_max'				=>	100000,
		'resource_incremental'	=>	0
	),
);

$config['init_data_building'] = array(
	0xAA01	=>	array(
		'building_level'				=>	1,
		'building_pos_x'				=>	200,
		'building_pos_y'				=>	200
	),
	0xAA03	=>	array(
		'building_level'				=>	1,
		'building_pos_x'				=>	500,
		'building_pos_y'				=>	600
	)
);

$config['sql_update_resource_amount'] = "update `data_resources` set `resource_current` = `resource_current` + `resource_incremental` * ((UNIX_TIMESTAMP() - `resource_last_increase`) / {%update_time%}), `resource_last_increase`=UNIX_TIMESTAMP() where `account_id`='{%account_id%}'";
?>