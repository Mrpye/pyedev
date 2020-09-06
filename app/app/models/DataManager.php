<?php
class DataManager extends DB\SQL\Mapper{

    public function __construct(DB\SQL $db,$table) {
        parent::__construct($db,$table);
    }
    public function empty_table() {
        $res=$this->db->exec("delete from ". $this->table .";");
        $res=$this->db->exec("ALTER TABLE ". $this->table ." AUTO_INCREMENT = 1;");  
    }

    public function clean_table($script) {
        $res=$this->db->exec("delete from ". $this->table ." where script='".$script."';");
        $res=$this->db->exec("ALTER TABLE ". $this->table ." AUTO_INCREMENT = 1;");  
    }

    function countResults() {
        return count($this->query);
      }

    public function insertArray($data) {
        
        $this->copyFrom($data);
        $this->insert();
    }
    public function updateArray($data) {   
        $this->load(array('id=?',$data['id']));
        $this->copyFrom($data);
        $this->update();
    }
    public function LogError($message,$type="info"){
        $data=array(
            "message"=>$message,
            "type"=>$type  
        );
        $this->insertArray($data);
    }

    public function all() {
        $this->load();
        return $this->query;
    }

    public function getById($id) {
        $this->load(array('id=?',$id));
        return $this->query;
    }

    public function getByState($id) {
        $this->load(array('state=?',$id));
        return $this->query;
    }
    public function getByName($name) {
        $this->load(array('name=?', $name));
        return $this->query;
    }

    public function getByAddress($address) {
        $this->load(array('address=?', $address));
        return $this->query;
    }

    public function getByAddress2($address) {
        $this->load(array('address2=?', $address));
        return $this->query;
    }

    public function getByHostname($hostname) {
        $this->load(array('hostname=?', $hostname));
        return $this->query;
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
