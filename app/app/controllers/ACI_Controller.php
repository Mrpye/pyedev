<?php

class ACI_Controller extends BaseAdminController
{

    public function beforeroute()
    {
        $this->session_readonly();
        if ($_SESSION['user'] === null||$this->f3->get('SESSION.level')<>2) {
            $this->f3->reroute('/login/aci');
            exit;
        }
    }

    public function aci()
    {
        $this->notemplate = true;
        echo Template::instance()->render('site/aci/index.html');
        //$this->f3->set('content', 'site/chat/test.html');
    }

}
