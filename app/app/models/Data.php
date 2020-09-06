<?php
class Data extends DB\SQL\Mapper{

    public function __construct(DB\SQL $db,$table) {
        parent::__construct($db,"data_".$table);
    }
    public function empty_table() {
        $res=$this->db->exec("delete from ". $this->table .";");
        $res=$this->db->exec("ALTER TABLE ". $this->table ." AUTO_INCREMENT = 1;");
        
    }

    public function insertArray($data) {
        
        $this->copyFrom($data);
        $this->insert();
    }


    public function all() {
        $this->load();
        return $this->query;
    }

    public function getById($id) {
        $this->load(array('id=?',$id));
        return $this->query;
    }

    public function getByName($name) {
        $this->load(array('name=?', $name));
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
