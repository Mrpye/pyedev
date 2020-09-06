<?php


date_default_timezone_set("America/New_York");



//phpinfo();
//die();
//*********************************
//Setup the route and config folder
//*********************************
require __DIR__ . '/vendor/autoload.php';

//$f3=require('vendor/bcosca/fatfree/lib/base.php');
$f3 = \Base::instance();

$f3->config('config/config.ini');
$f3->config('config/routes.ini');

$db_dns=getenv('DASH_DNS');
if($db_dns!=""){$f3->set("db_dns",$db_dns);}

$db_db=getenv('DASH_DB');
if($db_db!=""){$f3->set("db_name",$db_db);}

$db_user=getenv('DASH_USER');
if($db_user!=""){$f3->set("db_user",$db_user);}

$db_password=getenv('DASH_PASSWORD');
if($db_password!=""){$f3->set("db_pass",$db_password);}


/*$f3->set('ONERROR',function($f3){
    echo Template::instance()->render('errors/fullpage_error.htm');
});*/

$f3->set('CORS.origin', '*');
$f3->set('CORS.headers', '*');

$f3->run();