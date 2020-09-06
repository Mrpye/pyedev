<?php

class BaseAdminController extends BaseController{
	public function __construct(){
		$this->default_reroute="/admin";
		parent::__construct();
		
    }
	function afterroute() {
		if($this->notemplate==false){echo Template::instance()->render('admin/admin_layout.htm');}
	}
}
