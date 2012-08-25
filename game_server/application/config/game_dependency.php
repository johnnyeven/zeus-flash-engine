<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$config['dependency_building'] = array(
	0xAA01		=>	array(
		'building_auto_increase'		=>	1,
		'1'		=>	array(
			
		)
	),
	0xAA03		=>	array(
		'building_auto_increase'		=>	0,
		'1'		=>	array(
			'building'	=>	array(
				array(
					'building_id'		=>	0xAA01,
					'building_level'	=>	1
				),
				array(
					'building_id'		=>	0xAA02,
					'building_level'	=>	1
				)
			),
			'resource'	=>	array(
				array(
					'resource_id'			=>	0x0001,
					'resource_amount'	=>	100
				)
			),
			'duration'	=>	10
		),
		'2'		=>	array(
			'building'	=>	array(
				array(
					'building_id'		=>	0xAA01,
					'building_level'	=>	1
				),
				array(
					'building_id'		=>	0xAA02,
					'building_level'	=>	1
				)
			),
			'resource'	=>	array(
				array(
					'resource_id'			=>	0x0001,
					'resource_amount'	=>	500
				)
			),
			'duration'	=>	50
		)
	)
);
?>