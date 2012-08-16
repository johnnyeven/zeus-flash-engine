<?php
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

$config['sql_update_resource_amount'] = "update `data_resources` set `resource_current` = `resource_current` + `resource_incremental` * ((UNIX_TIMESTAMP() - `resource_last_increase`) / {%update_time%}), `resource_last_increase`=UNIX_TIMESTAMP() where `account_id`='{%account_id%}'";
?>