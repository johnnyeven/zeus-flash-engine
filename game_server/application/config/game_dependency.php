<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$config['dependency_building'] = array(
	0xAA01		=>	array(
		'1'		=>	array(
			'building'	=>	array(
				0xAA02	=>	array(
					'building_level'	=>	1
				)
			),
			'resource'	=>	array(
				0x0001	=>	array(
					'resource_amount'	=>	100,
				)
			),
			'duration'	=>	array(
				'duration_amount'		=>	10
			)
		),
		'2'		=>	array(
			'building'	=>	array(
				0xAA02	=>	array(
					'building_level'	=>	2
				)
			),
			'resource'	=>	array(
				0x0001	=>	array(
					'resource_amount'	=>	130,
				)
			),
			'duration'	=>	array(
				'duration_amount'		=>	30
			)
		),
		'3'		=>	array(
			'building'	=>	array(
				0xAA02	=>	array(
					'building_level'	=>	3
				)
			),
			'resource'	=>	array(
				0x0001	=>	array(
					'resource_amount'	=>	176,
				)
			),
			'duration'	=>	array(
				'duration_amount'		=>	80
			)
		)
	),
	0xAA03		=>	array(
		'1'		=>	array(
			'building'	=>	array(
				0xAA01	=>	array(
					'building_level'	=>	1
				),
				0xAA02	=>	array(
					'building_level'	=>	1
				)
			),
			'resource'	=>	array(
				0x0001	=>	array(
					'resource_amount'	=>	100
				)
			),
			'duration'	=>	array(
				'duration_amount'		=>	10
			)
		),
		'2'		=>	array(
			'building'	=>	array(
				0xAA01	=>	array(
					'building_level'	=>	2
				),
				0xAA02	=>	array(
					'building_level'	=>	1
				)
			),
			'resource'	=>	array(
				0x0001	=>	array(
					'resource_amount'	=>	500
				)
			),
			'duration'	=>	array(
				'duration_amount'		=>	50
			)
		)
	)
);
?>