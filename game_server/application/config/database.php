<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------
| DATABASE CONNECTIVITY SETTINGS
| -------------------------------------------------------------------
| This file will contain the settings needed to access your database.
|
| For complete instructions please consult the 'Database Connection'
| page of the User Guide.
|
| -------------------------------------------------------------------
| EXPLANATION OF VARIABLES
| -------------------------------------------------------------------
|
|	['hostname'] The hostname of your database server.
|	['username'] The username used to connect to the database
|	['password'] The password used to connect to the database
|	['database'] The name of the database you want to connect to
|	['dbdriver'] The database type. ie: mysql.  Currently supported:
				 mysql, mysqli, postgre, odbc, mssql, sqlite, oci8
|	['dbprefix'] You can add an optional prefix, which will be added
|				 to the table name when using the  Active Record class
|	['pconnect'] TRUE/FALSE - Whether to use a persistent connection
|	['db_debug'] TRUE/FALSE - Whether database errors should be displayed.
|	['cache_on'] TRUE/FALSE - Enables/disables query caching
|	['cachedir'] The path to the folder where cache files should be stored
|	['char_set'] The character set used in communicating with the database
|	['dbcollat'] The character collation used in communicating with the database
|				 NOTE: For MySQL and MySQLi databases, this setting is only used
| 				 as a backup if your server is running PHP < 5.2.3 or MySQL < 5.0.7.
| 				 There is an incompatibility in PHP with mysql_real_escape_string() which
| 				 can make your site vulnerable to SQL injection if you are using a
| 				 multi-byte character set and are running versions lower than these.
| 				 Sites using Latin-1 or UTF-8 database character set and collation are unaffected.
|	['swap_pre'] A default table prefix that should be swapped with the dbprefix
|	['autoinit'] Whether or not to automatically initialize the database.
|	['stricton'] TRUE/FALSE - forces 'Strict Mode' connections
|							- good for ensuring strict SQL while developing
|
| The $active_group variable lets you choose which connection group to
| make active.  By default there is only one group (the 'default' group).
|
| The $active_record variables lets you determine whether or not to load
| the active record class
*/

$active_group = 'accountdb';
$active_record = TRUE;

$db['accountdb']['hostname'] = 'localhost';
$db['accountdb']['username'] = 'root';
$db['accountdb']['password'] = '100200';
$db['accountdb']['database'] = 'game_account_db';
$db['accountdb']['dbdriver'] = 'mysqli';
$db['accountdb']['dbprefix'] = '';
$db['accountdb']['pconnect'] = FALSE;
$db['accountdb']['db_debug'] = TRUE;
$db['accountdb']['cache_on'] = FALSE;
$db['accountdb']['cachedir'] = '';
$db['accountdb']['char_set'] = 'utf8';
$db['accountdb']['dbcollat'] = 'utf8_general_ci';
$db['accountdb']['swap_pre'] = '';
$db['accountdb']['autoinit'] = TRUE;
$db['accountdb']['stricton'] = FALSE;

$db['productdb']['hostname'] = 'localhost';
$db['productdb']['username'] = 'root';
$db['productdb']['password'] = '100200';
$db['productdb']['database'] = 'game_product_db';
$db['productdb']['dbdriver'] = 'mysqli';
$db['productdb']['dbprefix'] = '';
$db['productdb']['pconnect'] = FALSE;
$db['productdb']['db_debug'] = TRUE;
$db['productdb']['cache_on'] = FALSE;
$db['productdb']['cachedir'] = '';
$db['productdb']['char_set'] = 'utf8';
$db['productdb']['dbcollat'] = 'utf8_general_ci';
$db['productdb']['swap_pre'] = '';
$db['productdb']['autoinit'] = TRUE;
$db['productdb']['stricton'] = FALSE;

$db['datadb']['hostname'] = 'localhost';
$db['datadb']['username'] = 'root';
$db['datadb']['password'] = '100200';
$db['datadb']['database'] = 'game_data_db';
$db['datadb']['dbdriver'] = 'mysqli';
$db['datadb']['dbprefix'] = '';
$db['datadb']['pconnect'] = FALSE;
$db['datadb']['db_debug'] = TRUE;
$db['datadb']['cache_on'] = FALSE;
$db['datadb']['cachedir'] = '';
$db['datadb']['char_set'] = 'utf8';
$db['datadb']['dbcollat'] = 'utf8_general_ci';
$db['datadb']['swap_pre'] = '';
$db['datadb']['autoinit'] = TRUE;
$db['datadb']['stricton'] = FALSE;

$db['fundsdb']['hostname'] = 'localhost';
$db['fundsdb']['username'] = 'root';
$db['fundsdb']['password'] = '100200';
$db['fundsdb']['database'] = 'game_funds_flow_db';
$db['fundsdb']['dbdriver'] = 'mysqli';
$db['fundsdb']['dbprefix'] = '';
$db['fundsdb']['pconnect'] = FALSE;
$db['fundsdb']['db_debug'] = TRUE;
$db['fundsdb']['cache_on'] = FALSE;
$db['fundsdb']['cachedir'] = '';
$db['fundsdb']['char_set'] = 'utf8';
$db['fundsdb']['dbcollat'] = 'utf8_general_ci';
$db['fundsdb']['swap_pre'] = '';
$db['fundsdb']['autoinit'] = TRUE;
$db['fundsdb']['stricton'] = FALSE;

$db['logdb']['hostname'] = 'localhost';
$db['logdb']['username'] = 'root';
$db['logdb']['password'] = '100200';
$db['logdb']['database'] = 'game_log_db_201201';
$db['logdb']['dbdriver'] = 'mysqli';
$db['logdb']['dbprefix'] = '';
$db['logdb']['pconnect'] = FALSE;
$db['logdb']['db_debug'] = TRUE;
$db['logdb']['cache_on'] = FALSE;
$db['logdb']['cachedir'] = '';
$db['logdb']['char_set'] = 'utf8';
$db['logdb']['dbcollat'] = 'utf8_general_ci';
$db['logdb']['swap_pre'] = '';
$db['logdb']['autoinit'] = TRUE;
$db['logdb']['stricton'] = FALSE;


/* End of file database.php */
/* Location: ./application/config/database.php */