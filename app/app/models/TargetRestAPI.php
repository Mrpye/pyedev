<?php
class TargetRestAPI extends DB\SQL\Mapper
{

    public function __construct(DB\SQL $db)
    {
        parent::__construct($db, 'target_rest_api');
    }

    public function RunAll()
    {
        $r = $this->all();
        
        foreach ($r as $value) {
            $this->run($value->id);
        }
    }
    public function Run($id)
    {
        
        $config = new Config($this->db);
        $hwdb = new DataManager($this->db, "data_hardware");
        
        //*******************
        //Load the api config
        //*******************
        $api_config = $this->getById($id);
        
        //*************************
        //Step 2 json path the data
        //*************************
        $scheme = new Scheme($this->db);
        $scheme->data_scheme_exists($api_config[0]->scheme, true);
        
        //**********************
        //Step 1 gather the data
        //**********************
        $web = \Web::instance();
        if ($api_config[0]->is_metric == false && $api_config[0]->enabled == true) {
            //**********************************
            //This pulls data from the analytics
            //**********************************
            
            $url = $config->getConfig("analytic_url","ANALYTIC_URL") . "/events/query?limit=" . $api_config[0]->limit;
        
            $options = array(
                'method' => $api_config[0]->method,
                "header" => [
                    "Accept:application/vnd.appd.events+json;v=2",
                    "Content-Type:application/vnd.appd.events+text;v=2",
                    "X-Events-API-AccountName:" . $config->getConfig("X-Events-API-AccountName","X_EVENTS_API_ACCOUNT_NAME"),
                    "X-Events-API-Key:" . $config->getConfig("X-Events-API-Key","X_EVENTS_API_KEY"),
                ],
                "content" => $api_config[0]->body,
            );
            $result = $web->request($url, $options);
          
            //**************
            //Build the data
            //**************
            if (!empty($result)) {
                //***************
                //Empty the table
                //***************
                $db = new Data($this->db, $api_config[0]->scheme);
                if ($api_config[0]->clear == true) {
                    $db->empty_table();
                }

                //******************
                //New transform data
                //******************
                $data = json_decode($result['body'])[0]->results;

                foreach ($data as $value) {
                    $new_template = json_decode($api_config[0]->transform);
                    foreach ($new_template as $key => $v) {
                        $new_template->$key = $value[$v];
                    }
                    $db->insertArray($new_template);
                }
            }
        } elseif ($api_config[0]->is_metric == true && $api_config[0]->enabled == true) {
            //********************************
            //This pulls data from the metrics
            //********************************
            
            $path = $api_config[0]->url;
            $url_data = $this->MyUrlEncode($api_config[0]->body . $path);
            $url = $config->getConfig("metric_url","METRIC_URL") . "/controller/rest/applications/" . $url_data . $config->getConfig("metric_duration","METRIC_DURATION");
        
            $options = array(
                'method' => $api_config[0]->method,
                'header' => array(
                    "Accept: application/json",
                    "Content-Type: application/json",
                    "Authorization:" . $config->getConfig("Authorization","AUTHORIZATION"),
                ),
                "content" => $config[0]->body,
            );

            $result = $web->request($url, $options);
            
            //print_r($result);die();
            //**************
            //Build the data
            //**************
            if (!empty($result)) {
                //***************
                //Empty the table
                //***************
                $db = new Data($this->db, $api_config[0]->scheme);
                if ($api_config[0]->clear == true) {
                    $db->empty_table();
                }
                //******************
                //New transform data
                //******************
                $data = "";
                try {
                    $data = json_decode($result['body']);

                    //print_r($result);die();
                    foreach ($data as $value) {
                        $new_template = json_decode($api_config[0]->transform);
                        foreach ($new_template as $key => $v) {
                            if (is_array($value->$v)) {
                                $new_template->$key = json_encode($value->$v);
                            } else {
                                $new_template->$key = $value->$v;
                            }

                        }

                        //*****************************
                        //Convert ip for child objects
                        //*****************************
                        $items = explode("|", $new_template->metricName);
                        $tmp_address = $items[2];
                        $hwdb->getByAddress2($tmp_address);
                        if ($hwdb->countResults() > 0) {
                            //This is a parent
                            //We need to look up the child
                            if($hwdb->parent==1){
                                $hwdb->getByHostname($items[3]);
                                if ($hwdb->countResults() > 0) {
                                    $new_template->metricName = str_replace($tmp_address, $hwdb->Address, $new_template->metricName);
                                    $new_template->metricPath = str_replace($tmp_address, $hwdb->Address, $new_template->metricPath);
                                }
                            }
                        }
                        $db->insertArray($new_template);
                    }

                } catch (Exception $e) {
                    $error_log = DataManager($this->db, "log");
                    $error_log->LogError($e->getMessage());

                }
            }
        }
    }
    private function MyUrlEncode($url)
    {
        $url = str_replace(" ", "%20", $url);
        $url = str_replace("\\", "%5C", $url);
        $url = str_replace("|", "%7C", $url);
        //$url=str_replace("|","%7C",$url);
        return $url;
    }
    public function a()
    {
        return "ddfsdf";
    }

    public function all()
    {
        $this->load();
        return $this->query;
    }

    public function getById($id)
    {
        $this->load(array('id=?', $id));
        return $this->query;
    }

    public function getByName($name)
    {
        $this->load(array('name=?', $name));
        return $this->query;
    }

    public function addInsert($data)
    {
        $this->copyFrom($data);
        $this->save();
    }

    public function add()
    {
        $this->copyFrom('POST');
        $this->save();
    }

    public function edit($id)
    {
        $this->load(array('id=?', $id));

        $this->copyFrom('POST');
        $this->update();
    }

    public function delete($id)
    {
        $this->load(array('id=?', $id));
        $this->erase();
    }

}
