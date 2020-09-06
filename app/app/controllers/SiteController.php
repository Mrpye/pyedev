<?php

class SiteController extends BaseSiteController{
    public function __construct(){
        parent::__construct();
    }

    function afterroute() {
		if($this->notemplate==false){echo Template::instance()->render('login_layout.htm');}
	}


    public function index(){
        $this->f3->set('forward',$this->f3->get('PARAMS.forward'));
        $this->f3->set('message', $this->f3->get('PARAMS.message'));
        $this->f3->set('content','site/menu/menu.htm');
        //$this->f3->reroute('/widget/ship');
    } 


    public function chat()
    {
        $this->notemplate = true;
        echo Template::instance()->render('site/chat/test.html');
        //$this->f3->set('content', 'site/chat/test.html');
    }

   
}
