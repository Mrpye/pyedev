<?php
class BaseSiteController extends BaseController {
	public function __construct(){
		$this->default_reroute="/";
        parent::__construct();
    }
	function afterroute() {
		if($this->notemplate==false){echo Template::instance()->render('site/dashboard/dashboard_layout.htm');}
	}	
}
