<?php
class Config extends DB\SQL\Mapper{

    public function __construct(DB\SQL $db) {
        parent::__construct($db,'config');
    }
    
    public function all() {
        $this->load();
        return $this->query;
    }

    public function getById($id) {
        $this->load(array('id=?',$id));
        return $this->query;
    }

    public function getByKey($name) {
        $this->load(array('name=?', $name));
        return $this->query[0];
    }

    public function getConfig($name,$env=""){
        if($env!=""){
            $env_value=getenv($env);
            if($env_value!=null && $env_value!=""){
                return $env_value;
            }
        }
        
        return $this->getByKey($name)->config;
    }

    public function add() {
        $this->copyFrom('POST');
        $this->save();
    }

    public function edit($id) {
        $this->load(array('id=?',$id));
        $this->copyFrom('POST');
        $this->update();
    }

    public function delete($id) {
        $this->load(array('id=?',$id));
        $this->erase();
    }
}
