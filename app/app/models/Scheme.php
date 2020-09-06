<?php
class Scheme extends DB\SQL\Mapper{

    public function __construct(DB\SQL $db) {
        parent::__construct($db,'scheme');
    }

    public function BuildScheme(){
        $config=new Config($this->db);

        $result=$this->all();
        foreach ($result as $value){
            if($value->scheme==""){
                //lets build the data
                $s=$this->GetScheme($value->name);
                $value->scheme=$s;
                $value->save();
            }

            $this->data_scheme_exists($value->name,true);
            
            if($value->is_metric==false){
                $obj=new TargetRestAPI($this->db);
                $r=$obj->getByName($value->name);
                if(count($r)==0||empty($r)){
                    $data=array(
                        "name"=>$value->name,
                        "url"=>"",
                        "method"=>"POST",
                        "scheme"=>$value->name,
                        "clear"=>"1",
                        "limit"=>"20",
                        "body"=>"SELECT  * FROM ".$value->name." ORDER BY pickupTimestamp desc",
                        "transform"=>$this->BuildTransformCode($value->scheme),
                    );
                    $obj->addInsert($data);
                }
            }
        }

    }

    
    private function BuildTransformCode($s){
        $json=json_decode($s);
        $code=array();
        $code[]="{";
            $count=-1;
            foreach ($json->schema as $key => $value)  {
                $count++;
                $code[]='"'.$key.'":'.$count .',';
            }
        $code[count($code)-1]=substr($code[count($code)-1], 0, -1);
        $code[]="}";
        return implode("\r\n", $code);
    }

    private function GetScheme($name){
        $config=new Config();
        
        $web = \Web::instance();
        
        $url=$config->getConfig("analytic_url","ANALYTIC_URL")."/events/schema/".$name;

        $options = array(
			'method'  => "GET",
			'header' => [
                "Accept:application/vnd.appd.events+json;v=2",
                "Content-Type:application/vnd.appd.events+json;v=2",
                "X-Events-API-AccountName:".$config->getConfig("X-Events-API-AccountName","X_EVENTS_API_ACCOUNT_NAME"),
                "X-Events-API-Key:".$config->getConfig("X-Events-API-Key","X_EVENTS_API_KEY")
              ]
        );
        
        $result = $web->request($url, $options);
        return $result['body'];
    }

    public function create_data_scheme($s){
        if(!empty($s)){
            $scheme=json_decode($s->scheme);
            //*******************
            //Build the db scheme
            //*******************
            $schema = new \DB\SQL\Schema( $this->db );
            $table = $schema->createTable('data_'.$scheme->eventType);
            $table->primary('uid');

            foreach ($scheme->schema as $key => $value) {
                switch ($value) {
                    case "string":
                        $table->addColumn($key)->type($schema::DT_VARCHAR128);
                        break;
                    case "float":
                        $table->addColumn($key)->type($schema::DT_DECIMAL);
                        break;
                    case "int":
                        $table->addColumn($key)->type($schema::DT_INT8);
                        break;
                    case "date":
                        $table->addColumn($key)->type($schema::DT_DATETIME);
                        break;
                    default:
                        $table->addColumn($key)->type($value);
                        break;
                }
           
            }
            $table->build();
        }
    }



    public function Build_Config(){
        $res=$this->db->exec("SHOW TABLES LIKE 'config';");
        if(count($res)<=0 || empty($res)){
            //*******************
            //Build the db scheme
            //*******************
            $schema = new \DB\SQL\Schema( $this->db );
            $table = $schema->createTable('config');
            $table->primary('uid');
            $table->addColumn("key")->type($schema::DT_VARCHAR128);
            $table->addColumn("config")->type($schema::DT_VARCHAR512);
            $table->addColumn("enc")->type($schema::DT_BOOL);
            $table->build();
        }
    }

    public function Build_HardwareData(){
        $res=$this->db->exec("SHOW TABLES LIKE 'data_hardware';");
        if(count($res)<=0 || empty($res)){
            //*******************
            //Build the db scheme
            //*******************
            $schema = new \DB\SQL\Schema( $this->db );
            $table = $schema->createTable('data_hardware');
            $table->primary('uid');
            $table->addColumn("Address")->type($schema::DT_VARCHAR128);
            $table->addColumn("Hostname")->type($schema::DT_VARCHAR128);
            $table->addColumn("New Name")->type($schema::DT_VARCHAR128);
            $table->addColumn("Type")->type($schema::DT_VARCHAR128);
            $table->addColumn("Location")->type($schema::DT_VARCHAR128);
            $table->addColumn("Space")->type($schema::DT_VARCHAR128);
            $table->addColumn("Cabinet")->type($schema::DT_INT8);
            $table->addColumn("Keg")->type($schema::DT_INT8);
            $table->addColumn("Row")->type($schema::DT_INT8);
            $table->addColumn("U")->type($schema::DT_INT8);
            $table->addColumn("Function")->type($schema::DT_VARCHAR128);
            $table->addColumn("Description")->type($schema::DT_TEXT);
            $table->build();
        }
    }

    public function data_scheme_exists($name,$create=false){
        $res=$this->db->exec("SHOW TABLES LIKE 'data_".$name."';");

        if(count($res)<=0 || empty($res)){
            if($create==true){
                $res=$this->getByName($name);
                $this->create_data_scheme($res[0]);
            }
           return false;
        }else{
            
            return true;
        }
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
