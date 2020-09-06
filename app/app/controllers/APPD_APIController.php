<?php

class APPD_APIController extends BaseAdminController{

    public function CollectData()
    {
        //***********************************
        //Call the Target Api to collect data
        //***********************************
        try{
            $rest = new TargetRestAPI($this->db);
            $result = $rest->RunAll();
            //update the config
            $config = new Config($this->db);
            $config->getByKey("last_data_collect");
            $config->config=date('m/d/Y h:i:s a', time());
            $config->update();
            $this->notemplate = true;
            echo "OK";
        }catch (Exception $e) {
            $error_log=DataManager($this->db,"log");
            $error_log->LogError($e->getMessage());
            $this->notemplate = true;
            echo "FAIL";
        }
    }
    
    public function ExtractItems($data){
        //********************************
        //Helper Functiion to extract data
        //********************************
        $new_value=str_replace("NodeTemplateVariables","", $data);
        $new_value=str_replace("{","", $new_value);
        $new_value=str_replace("}","", $new_value);
        $new_value=explode(",",$new_value);
        $keys_array=array();
        //print_r($new_value);die();
        foreach ($new_value as $value){
            $item=explode("=",$value);
            $keys_array[trim($item[0])]=trim($item[1]);
        }
        return (object)$keys_array;
    }



    public function LastUpdate(){
        //*************************
        //Get the last updated data
        //*************************
        $config = new Config($this->db);
        $result=array(
            "last_data_collect"=> $config->getConfig("last_data_collect"),
            "last_event"=> $config->getConfig("last_event"),
        );
        $this->notemplate=true;
        $json_data = json_encode((object)$result);
        header('Content-Type: application/json');
        http_response_code(200);
        echo $json_data;
    }

    //*********
    //Main Site
    //*********
    public function index(){
        try{

            $this->notemplate=true;
            $post_data = file_get_contents("php://input");
            $this->Basic_Auth();
            //********************************
            //This will just store the message
            //********************************
            $config = new Config($this->db);
            
            if($config->getConfig("enable_dump","ENABLE_DUMP")=="1"){
                $data_dump=new DataManager($this->db,"data_dump");
                $tmp_data=array(
                    "data"=>$post_data
                );
                $data_dump->insertArray($tmp_data);
            }

            $dm=new DataManager($this->db,"event_system");
            $hwdb=new DataManager($this->db,"data_hardware");

            //Fix and decode the data
            $obj=$this->json_decode_nice($post_data,false);

            //************************
            //Fix the state to integer
            //************************
            $event=$obj->fullEventsByTypeMap[0];
            if(strtoupper($event->severity)=="ERROR"){
                $state=2;
            }else if(strtoupper($event->severity)=="WARN"){
                $state=1;
            }else if(strtoupper($event->severity)=="INFO"){
                $state=0;
            }
            $deep_link=$event->deepLink;
            $display_name=$event->displayName;
        
            //print_r($obj->fullEventsNodeMap[0]);die();
            //Extract node info
            $fullEvents_array=(array) $obj->fullEventsNodeMap[0];
            $keys=array_keys($fullEvents_array);
            $node_details=$fullEvents_array[$keys[0]];
            $node_details=$this->ExtractItems($node_details);
            $rack= $node_details->name;
            $sub_item=explode("|",$node_details->tierName);
            //$new_value=json_decode($new_value);
            //print_r($node_details);die();

            $event_data=explode("<br>",$event->eventMessage);
            $found_condition=false;
            $table_cleaned=false;
            $add_second_record_as_sub_item=false;
            foreach ($event_data as $value){
                if (strpos($value, 'Condition') !== false && $found_condition==false) {
                    $found_condition=true;
                }else if($found_condition==true){
                    $new_value=str_replace("<b>","", $value);
                    $extract_data=explode("</b>",$new_value,2);
                    foreach ($extract_data as $key => $v){
                        $extract_data[$key]=trim(str_replace("</b>","", $v));
                    }
                    //Get the messge
                    $message=$extract_data[1];
                    //Extract Items
                    $items=explode("|",$extract_data[0]);
                    //need to get the name
                    $hwdb->getByAddress($items[2]);
                    //print_r($hwdb);die();

                    if($hwdb->countResults()>0){
                        $name=$hwdb->Hostname;
                    }else{
                        $name="";
                    }
                    
                    //only clean items that are relvent based on the script
                    if($table_cleaned==false){
                        $dm->clean_table($items[1]);
                        $table_cleaned=true;
                    }
                    
                    //Build the data
                    $data=array(
                        "name"=>($name==null ? "" :$name), 
                        "ship"=>($sub_item[1]==null ? "" :$sub_item[1]), 
                        "location"=>($sub_item[2]==null ? "" :$sub_item[2]), 
                        "rack"=>$rack,
                        "script"=>($items[1]==null ? "" :$items[1]),
                        "hardware"=>($items[2]==null ? "" :$items[2]),
                        "item_group"=>str_replace("'s", "", ($items[3]==null ? "" :$items[3])),
                        "item"=>str_replace("'s", "", ($items[4]==null ? "" :$items[4])),
                        "metric"=>str_replace("'s", "",($items[5]==null ? "" :$items[5])),
                        "state"=>$state,
                        "message"=>$message,
                        "deep_link"=>$deep_link,
                        "display_name"=>$display_name
                    );

                   ///echo $items[2];
                    
                    //***************************** 
                    //Convert ip for child objects
                    //*****************************
                    $tmp_address=$data['hardware'];
                    
                    $hwdb->getByAddress2($tmp_address);
                    if($hwdb->countResults()>0){
                        //print_r($data);die();
                        //This is a parent
                        //We need to look up the child
                        if (($data['item']=="" || $data['item_group']=="")&& $data['name']==""){
                            $data['hardware']=$hwdb->Address;
                            $data['name']=$hwdb->Hostname;
                        }else{
                            $hwdb->getByHostname($data['item_group']);
                            if($hwdb->countResults()>0){
                                $data['hardware']=$hwdb->Address;
                                $data['name']=$hwdb->Hostname;
                            }
                        }
                        
                    }
                    //print_r($data);die();
                    


                    $dm->insertArray($data);
                    $found_condition=false;
                    //print_r($data);die();
                }
            }
        
            $return_data = [
                'ok' => ['everything worked.']
            ];

            //update the config
            //$config = new Config($this->db);
            $config->getByKey("last_event");
            $config->config=date('m/d/Y h:i:s a', time());
            $config->update();
        

            $json_data = json_encode($return_data);
            header('Content-Type: application/json');
            http_response_code(200);
            echo $json_data;
            
        }catch (Exception $e) {
            $this->LOG_Error($e->getMessage());
            $this->notemplate = true;
            $return_data = [
                'fail' => ['Error see log']
            ];
            $json_data = json_encode($return_data);
            $this->Error_Page(500,$json_data);
        }
    }


     
       
   
    function json_decode_nice($json, $assoc = FALSE){
        //$json = str_replace(array("\n","\r"),"",$json);
        //$json = preg_replace('/([{,]+)(\s*)([^"]+?)\s*:/','$1"$3":',$json);
        //$json = preg_replace('/(,)\s*}$/','}',$json);
        $json=preg_replace('/,\s*([\]}])/m', '$1', $json);
        return json_decode($json,$assoc);
    }

    public function GetEvent(){
        $this->notemplate=true;
        //$data= new DataManager($this->db,"event_data");
        header('Content-Type: application/json');
        http_response_code(200);

        $location = strtoupper($this->f3->get("PARAMS.location"));
        if($location=="" ){
            $events = $this->db->exec("select * from event_system");
        }else if($location=="ALL"){
            $events = $this->db->exec("SELECT location,MAX(`state`) as status FROM event_system  GROUP BY location");
        }else{
            //$events = $this->db->exec("SELECT location,`name`,MAX(`state`) AS `status`,item_group,item FROM event_system  WHERE location='".$location."' GROUP BY location,`name`,item_group,item ORDER BY state DESC");
            $events = $this->db->exec("SELECT location,`name`,MAX(`state`) AS `status` FROM event_system  WHERE location='".$location."' GROUP BY location,`name`,state ORDER BY state DESC");
        }
        
        $json_data = json_encode($events,JSON_PRETTY_PRINT );
        
        echo $json_data;
    }

    //***************************
    //Function to setup databases
    //***************************
    public function Setup(){
        $this->notemplate=true;
        $scheme=new Scheme($this->db);
        $scheme->Build_Config();
        $scheme->Build_HardwareData();
        header('Content-Type: application/json');
        http_response_code(200);

    }

}
