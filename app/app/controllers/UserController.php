<?php
class UserController {
	protected $f3;
	protected $db;
	protected $notemplate=false;
	protected $mc;
	
	function beforeroute() {
		$this->f3->set('message','');
	}

	function afterroute() {
		if($this->notemplate==false){echo Template::instance()->render('login_layout.htm');}
	}

	function __construct() {

        $f3=Base::instance();

        $db=new DB\SQL(
            $f3->get('db_dns') . $f3->get('db_name'),
            $f3->get('db_user'),
            $f3->get('db_pass')
        );	

		$this->f3=$f3;
		$this->db=$db;
	}
	
    function render(){
        //echo $this->f3->get('CACHE');
        //$this->f3->set('page_head','Connection List');
        $this->f3->set('forward',$this->f3->get('PARAMS.forward'));
        $this->f3->set('message', $this->f3->get('PARAMS.message'));
        $this->f3->set('content','user/login.htm');
    }


    
    function logout(){
        $this->f3->clear('SESSION');
        $this->f3->reroute('/login');
    }
    
  
    function authenticate() {
        
        $this->f3->set('SESSION.user', "User");
        
        $forward = $this->f3->get('PARAMS.forward');
        $username = $this->f3->get('POST.username');
        $password = $this->f3->get('POST.password');
        
        if($username=="api"){
            $this->f3->reroute('/login');
        }
        
        $user = new User($this->db);
        $user->getByName($username);
        

        if($user->dry()) {
            $this->f3->reroute('/login');
        }
        
        if(md5($password)==$user->password) {
            $this->f3->set('SESSION.user', $user->username);
            $this->f3->set('SESSION.level', $user->level);
            
            if(!empty($forward)){
                $this->f3->reroute('/'.$forward);
            }else{
                $this->f3->reroute('/admin');
            }
           
        } else {
            $this->f3->reroute('/login');
        }
    }
    
}
