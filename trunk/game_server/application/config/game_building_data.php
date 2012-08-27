<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$config['game_building_data']	=	array(
	0xAA01	=>	array(
		'building_type'					=>	'COLLECTION',
		'building_name'					=>	'管理中心',
		'building_max_level'			=>	20,
		'1'		=>	array(
			'resource_id'					=>	'building_AA01',
			'building_consume'			=>	array(
				0x0003		=>	array(
					'resource_name'					=>	'粮食',
					'resource_incremental'		=>	-5
				),
				0x0004		=>	array(
					'resource_name'					=>	'肉类',
					'resource_incremental'		=>	-7
				)
			),
			'building_produce'			=>	array()
		),
		'2'		=>	array(
			'resource_id'					=>	'building_AA01',
			'building_consume'			=>	array(
				0x0003		=>	array(
					'resource_name'					=>	'粮食',
					'resource_incremental'		=>	-7
				),
				0x0004		=>	array(
					'resource_name'					=>	'肉类',
					'resource_incremental'		=>	-10
				)
			),
			'building_produce'			=>	array()
		),
		'3'		=>	array(
			'resource_id'					=>	'building_AA01',
			'building_consume'			=>	array(
				0x0003		=>	array(
					'resource_name'					=>	'粮食',
					'resource_incremental'		=>	-10
				),
				0x0004		=>	array(
					'resource_name'					=>	'肉类',
					'resource_incremental'		=>	-15
				)
			),
			'building_produce'			=>	array()
		)
	),
	0xAA03	=>	array(
		'building_type'				=>	'COLLECTION',
		'building_name'				=>	'科研中心',
		'building_max_level'		=>	2,
		'1'		=>	array(
			'resource_id'				=>	'building_AA03',
			'building_consume'			=>	array(
				0x0003		=>	array(
					'resource_name'					=>	'粮食',
					'resource_incremental'		=>	-10
				),
				0x0004		=>	array(
					'resource_name'					=>	'肉类',
					'resource_incremental'		=>	-10
				)
			),
			'building_produce'			=>	array(
				0x0002		=>	array(
					'resource_name'					=>	'石材',
					'resource_incremental'		=>	20
				)
			)
		),
		'2'		=>	array(
			'resource_id'				=>	'building_AA03',
			'building_consume'			=>	array(
				0x0003		=>	array(
					'resource_name'					=>	'粮食',
					'resource_incremental'		=>	-20
				),
				0x0004		=>	array(
					'resource_name'					=>	'肉类',
					'resource_incremental'		=>	-13
				)
			),
			'building_produce'			=>	array(
				0x0002		=>	array(
					'resource_name'					=>	'石材',
					'resource_incremental'		=>	50
				)
			)
		)
	)
);
?>