<?php

class WidgetController extends BaseWidgetController
{

    public function __construct()
    {
        parent::__construct();
        
        try{
            $config=new Config($this->db);
            $this->f3->set('autoscroll', $config->getConfig("autoscroll","AUTOSCROLL"));
        }catch (Exception $e) {
        }
       
    }

    public function index()
    {
        $this->f3->reroute('/widget/ship');
    }

    public function DashBoard()
    {
        //******************
        //Load the Dashboard
        //******************

        $dashboard = new DashBoard($this->db);

        $name = $this->f3->get("PARAMS.name");
        $host = $this->f3->get("PARAMS.host");

        $dashboard->getByName($name);
        
        if($host!=""){
            $hardware= new DataManager($this->db,"data_hardware");
            $hardware->getByAddress($host);
            $hostname=$hardware->Hostname;
            $this->f3->set('device', $hostname);
        }
       

        //************************
        //Set up array to stor row
        //************************
        $row1 = array();
        $row2 = array();
        $row3 = array();
        $row4 = array();
        $this->f3->set('title', $name);
        $this->Build_Nav();
        //***********************************************
        //Loop through each widget and put in correct row
        //***********************************************
        for ($i = 0; $i < $dashboard->countResults(); $i++) {
            if (empty($dashboard->sql)) {
                ${"row" . $dashboard->row}[] = array("widget" => $this->load_widget($dashboard->widget, null, $dashboard->id, true), "width" => $dashboard->width);
            } else {
                //Need to run the sal
                $ip = $this->f3->get("PARAMS.host");

                //********************************
                //This is a fix for sub components
                //********************************
                $hard_ware= new DataManager($this->db,"data_hardware");
                $hard_ware->getByAddress($ip);
               
                $new_sql=$dashboard->sql;
                if($hard_ware->countResults()>0){
                    if($hard_ware->child==1){
                        if(strpos($new_sql, '{{host}}') !== false && strpos($new_sql, '{{ip}}') !== false){
                            $new_sql = str_replace("{{host}}", $hard_ware->Hostname, $new_sql);
                            $new_sql = str_replace("{{ip}}", "%", $new_sql);
                        }else if(strpos($new_sql, '{{host}}') !== false && strpos($new_sql, '{{ip}}') !== true){
                            $new_sql = str_replace("{{host}}", $hard_ware->Hostname, $new_sql);
                        }else if(strpos($new_sql, '{{host}}') !== true && strpos($new_sql, '{{ip}}') !== false){
                            $new_sql = str_replace("{{ip}}", $ip, $new_sql);
                        }
                        
                       // print_r( $new_sql);die("a");
                    }else{
                        $new_sql = str_replace("{{host}}", "%", $new_sql);
                        $new_sql = str_replace("{{ip}}", $ip, $new_sql);
                    }
                }else{
                    $new_sql = str_replace("{{ip}}", $ip, $new_sql);
                }
                
                $db_res = $this->db->exec($new_sql); //Run the sql and get the data
                foreach ($db_res as $value) {
                    ${"row" . $dashboard->row}[] = array("widget" => $this->load_widget($dashboard->widget, $value, $dashboard->id, true), "width" => $dashboard->width);
                }

            }
            $dashboard->next();
        }

        //*****************************
        //Pass the data to the template
        //*****************************
       
        $this->f3->set('row1', $row1);
        $this->f3->set('row2', $row2);
        $this->f3->set('row3', $row3);
        $this->f3->set('row4', $row4);

        $this->f3->set('BACK_URL', "widget/ship");
        $this->f3->set('BACK_TITLE', "SHIP");
        //populate all the js
        $this->notemplate = true;
        $this->f3->set('jsscripts', implode("\r\n", $this->jsscipts));
        $this->notemplate = false;
        $this->f3->set('content', 'site/widget/dashboard/dashboard.htm');
    }

    private function Build_Nav(){
        $config=new Config($this->db);
        //**********************************
        //Load the basic config for the ship
        //**********************************
        $ship_details=json_decode($config->getByKey("ship_config")->config);
        $this->f3->set('ship_details', $ship_details);
        $this->f3->set('last_update', $config->getByKey("last_data_collect")->config);
        $this->f3->set('last_event', $config->getByKey("last_event")->config);
        //*****************
        //Summary of errors
        //*****************
        $errors_db= new DataManager($this->db,"event_system");
        $errors_db->all();
        $this->f3->set('error_count',$errors_db->countResults());
        $racks_db = $this->db->exec("SELECT * FROM event_system where state>0 ORDER BY state DESC LIMIT 7"); //Run the sql and get the data
        //print_r($racks_db );die();
        $this->f3->set('ship_errors',$racks_db);
        
        $this->f3->set('dashboard_nav', 'site/widget/dashboard/dashboard_nav.htm');

    }

    private function load_widget($name, $data, $id)
    {
        //**************************************************
        //Just return the widget as an varible do not render
        //**************************************************
        $obj = new WidgetConfig($this->db);
        return $this->widget_lookup($name, $data, $id, true);
    }

    public function widget()
    {
        //*************************************
        //This is called for standalone widgets
        //*************************************
        $obj = new WidgetConfig($this->db);

        //Get the params
        $name = $this->f3->get("PARAMS.name");
        $refresh = $this->f3->get("PARAMS.refresh");
        $metric_name = $this->f3->get("PARAMS.metricname");

        //*********************************************************************
        //We need to decide if to bring back all the widget or just the content
        //*********************************************************************
        if ($refresh != 1) {
            $this->widget_lookup($name, null);
        } else {
            echo $this->widget_lookup($name, null, -1, true, "", $metric_name);
        }

    }

    public function widget_lookup($name, $data, $uid = -1, $widget_only = false, $widget_name = "", $metric_name = "")
    {
        //*****************
        //Lookup the widget
        //*****************
        $obj = new WidgetConfig($this->db);
        $obj->getByName($name); //Load the widget
        
        if (!$obj->dry()) {

            switch ($obj->widget) {
                case "traffic":
                    if ($widget_only == false) {
                        $this->Widget_traffic_light($obj, $data, $uid, $widget_only);
                    } else {
                        return $this->Widget_traffic_light($obj, $data, $uid, $widget_only, $metric_name);
                    }
                    break;
                case "rack":
                    if ($widget_only == false) {
                        $this->rack($obj, $uid, $widget_only);
                    } else {
                        return $this->rack($obj, $uid, $widget_only);
                    }
                    break;
                case "rack2":
                    if ($widget_only == false) {
                        $this->rack($obj, $data, $uid, $widget_only);
                    } else {
                        return $this->rack($obj, $data, $uid, $widget_only);
                    }
                    break;
                case "ship":
                    if ($widget_only == false) {
                        $this->Widget_ship($obj, $uid, $widget_only);
                    } else {
                        return $this->Widget_ship($obj, $uid, $widget_only);
                    }
                    break;
            }
        }

    }

    private function Widget_ship($c, $uid = -1, $widget_only = false)
    {
        //*****************************
        //Pass the data to the template
        //*****************************
        $this->f3->set('refresh', $this->f3->get("PARAMS.refresh"));
        $this->f3->set('id', $uid);

        //*******************************
        //render or just return the value
        //*******************************
        if ($widget_only == false) {
            $this->notemplate = true;
            $this->f3->set('jsscripts', Template::instance()->render('site/widget/ship/ship.js'));
            $this->f3->set('shipsvg', Template::instance()->render('site/widget/ship/ship.svg'));
            $this->notemplate = false;
            $this->Build_Nav();
            $this->f3->set('content', 'site/widget/ship/ship.htm');
        } else {
            $this->notemplate = true;
            $this->jsscipts[] = Template::instance()->render('site/widget/ship/ship.js');
            return Template::instance()->render('site/widget/ship/ship.htm');
        }
    }

    public function Get_Rack_Data()
    {
        $this->notemplate = true;
        header('Content-Type: application/json');
        http_response_code(200);
        $db_res = $this->db->exec("SELECT * FROM data_hardware WHERE SPACE='CSR1' AND cabinet=1 ORDER BY ROW DESC;"); //Run the sql and get the data
        $json_data = json_encode($db_res, JSON_PRETTY_PRINT);
        echo $json_data;

    }

   


    public function Dashboard_Racks()
    {
        $dashboard = new DashBoard($this->db);
        $name = $this->f3->get("PARAMS.name");
        $dashboard->getByName($name);
        if($dashboard->countResults()>0){
            $sqls = explode(";", $dashboard->sql);

            $racks_db = $this->db->exec($sqls[0]); //Run the sql and get the data

            $row = array();
            foreach ($racks_db as $value) {
                $rack_sql = str_replace("?", $value['Cabinet'], $sqls[1]);
                $row[] = array("widget" => $this->Dashboard_Rack($rack_sql), "width" => $dashboard->width);

            }
            
        }

        $this->f3->set('ACTIVE', "RACK");
        $this->f3->set('location', $dashboard->name);
        $this->f3->set('current_panel', $dashboard->name);
        $this->f3->set('ACTIVE', "RACK");
        $this->f3->set('BACK_URL', "/widget/ship");
        $this->f3->set('BACK_TITLE', "SHIP");
        $this->f3->set('title', "Racks");
        $this->f3->set('row1', $row);


        $this->Build_Nav();
        //populate all the js
        $this->notemplate = true;
        $this->jsscipts[] = Template::instance()->render('site/widget/dynamic_rack/rack.js');
        $this->f3->set('jsscripts', implode("\r\n", $this->jsscipts));
        $this->notemplate = false;
        $this->f3->set('content', 'site/widget/dashboard/dashboard.htm');

    }

    public function Dashboard_Rack($sql)
    {

        $racks_db = $this->db->exec($sql); //Run the sql and get the data

        //*****************************
        //Pass the data to the template
        //*****************************
        $this->f3->set('refresh', $this->f3->get("PARAMS.refresh"));
        $this->f3->set('data', $db_res);
        $this->f3->set('id', $uid);

        $rows = array();
        $this->f3->set('data', $racks_db);
        $this->notemplate = true;
        //$this->jsscipts[]=Template::instance()->render('site/widget/rack/rackjs.htm') ;
        return Template::instance()->render('site/widget/dynamic_rack/rack.htm');
    }

    public function Widget_traffic_light($c, $data = null, $uid = -1, $widget_only = false, $metric_name = "")
    {

        $config = json_decode($c->config); //get the config
        $style = "bg-gradient-success"; //Set the default style
        
       
        if (empty($data) && $metric_name == "") {

            $result = $this->GetMetrics($config->path);
            $result = json_decode($result)[0];
           
        } else {
            //we need to get the data for single item
            if ($metric_name != "") {
                $metric_name = str_replace("~", "|", $metric_name);
                $db_res = $this->db->exec("SELECT * FROM data_metric_data WHERE metricName ='" . $metric_name . "'"); //Run the sql and get the data
                $data = $db_res[0];
            }

            $result = $data;
            //readd metric values as array
            $result['metricValues'] = json_decode($result['metricValues']);
            $result = (object) $result;

            $metric_name = str_replace("|", "~", $result->metricName);
        }

        $tmp_data = array();

        foreach ($config->values as $key => $value) {
            $tmp_data[$key] = $result->metricValues[0]->$value;
        }
        $values = explode("|", $result->metricPath);

        $ship = $values[2];
        $rack = $values[3];
        $server = $values[8];
        $hardware_group = $values[9];
        $hardware_item = $values[10];
        $metric = str_replace("'s", "",$values[11]);

        
        
        //lets set the status
        $events_data = $this->db->exec("SELECT location,`name`,MAX(`state`) AS `status`,item,deep_link FROM event_system  WHERE item_group='".$hardware_group."' and item='".$hardware_item."' and metric='".$metric."' GROUP BY location,`name`,item,deep_link");
        //print_r("SELECT location,`name`,MAX(`state`) AS `status`,item,deep_link FROM event_system  WHERE item_group='".$hardware_group."' and item='".$hardware_item."' and metric='".$metric."' GROUP BY location,`name`,item,deep_link");die();
        if($events_data[0]['status']==0){
            $style = "bg-gradient-success"; 
        }else if($events_data[0]['status']==1){
            $style = "bg-gradient-warning"; 
        }else if($events_data[0]['status']==2){
            $style = "bg-gradient-danger"; 
        }

       
 
        //print_r("SELECT location,`name`,MAX(`state`) AS `status`,item FROM event_system  WHERE item_group='".$hardware_group."' and item='".$hardware_item."' and metric='".$metric."' GROUP BY location,`name`");die();
        //*****************************
        //Pass the data to the template
        //*****************************
        $this->f3->set('current_panel', $rack . "-" .  $server );
        $this->f3->set('title', $ship . "-" .  $rack . "-" .  $server );
        $this->f3->set('style', $style);
        $this->f3->set('id', $config->id);
        $this->f3->set('icon', $config->icon);
        $this->f3->set('widget_name', $c->name);
        $this->f3->set('metric_name', $metric_name);
        $this->f3->set('refresh', $this->f3->get("PARAMS.refresh"));
        $this->f3->set('ship', $ship);
        $this->f3->set('rack', $rack);
        $this->f3->set('deep_link', $events_data[0]['deep_link']);
        $this->f3->set('server', $server);
        $this->f3->set('hardware_group', $hardware_group);
        $this->f3->set('hardware_item', $hardware_item);
        $this->f3->set('metric', $metric);
        $this->f3->set('values', $tmp_data);

        //**********************************************************
        //Let get an id either from the widget or the dashboard item
        //**********************************************************
        if ($uid > -1) {
            $this->f3->set('uid', $config->name);
        } else {
            $this->f3->set('uid', $config->name);
        }
        $this->f3->set('uid', uniqid());
        //*******************************
        //render or just return the value
        //*******************************
        if ($widget_only == false) {
            $this->notemplate = true;
            $this->f3->set('jsscripts', Template::instance()->render('site/widget/traffic_light/traffic_light.js'));
            $this->notemplate = false;
            $this->f3->set('content', 'site/widget/traffic_light2/traffic_light.htm');
        } else {
            $this->notemplate = true;
            $this->jsscipts[] = Template::instance()->render('site/widget/traffic_light/traffic_light.js');
            return Template::instance()->render('site/widget/traffic_light/traffic_light.htm');
        }
    }
}
