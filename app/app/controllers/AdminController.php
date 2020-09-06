<?php

class AdminController extends BaseAdminController
{
    public function __construct(){
        parent::__construct();
    }
    public function beforeroute(){
        $this->Common();
        if ($this->f3->get('SESSION.user') === null||$this->f3->get('SESSION.level')>=2) {
            $this->f3->reroute('/login/admin');
            exit;
        }
    }
    public function Logout(){
        $this->f3->clear('SESSION');
    }

    private function Common(){
        $db_res = $this->db->exec("SELECT * FROM dashboard_list;"); //Run the sql and get the data
        $this->f3->set('dashboards', $db_res);
        $db_tables = $this->db->exec("SELECT table_name FROM information_schema.tables WHERE table_name LIKE 'data_%';"); //Run the sql and get the data
        $this->f3->set('data_tables', $db_tables);
        $data_edit = $this->db->exec("SELECT name,icon FROM forms;"); //Run the sql and get the data
        $this->f3->set('data_edit', $data_edit);
        $this->f3->set('level',  $this->f3->get('SESSION.level'));
    }

    //*********
    //Main Site
    //*********
    public function index()
    {
        $this->f3->set('level',  $this->f3->get('SESSION.level'));
        $this->f3->set('page_head', 'Admin Page');
        $this->f3->set('content', 'admin/home/home.htm');
    }

    public function Import(){
        //******************************
        //Function to import spreadsheet
        //******************************
        if ($this->f3->exists('POST.submit')) {

            $overwrite = true; // set to true, to overwrite an existing file; Default: false
            $slug = true; // rename file to filesystem-friendly version
            $web = \Web::instance();
            $files = $web->receive(function ($file, $formFieldName) {
                //print_r($_POST['import_sheet']);die();
                // maybe you want to check the file size
                if ($file['size'] > (2 * 1024 * 1024)) // if bigger than 2 MB
                {
                    return false;
                }
                // this file is not valid, return false will skip moving it

                $inputFileName = $file['tmp_name'];
                $spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load($inputFileName);
                $sheet = $spreadsheet->getSheetByName($_POST['import_sheet']);
                $sheet = $spreadsheet->getActiveSheet();

                $dataArray = $spreadsheet->getActiveSheet()
                    ->rangeToArray(
                        $_POST['import_range'], // The worksheet range that we want to retrieve
                        null, // Value that should be returned for empty cells
                        true, // Should formulas be calculated (the equivalent of getCalculatedValue() for each cell)
                        true, // Should values be formatted (the equivalent of getFormattedValue() for each cell)
                        true// Should the array be indexed by cell row and cell column
                    );

                //********************
                //Build the data table
                //********************
                $config = new Config($this->db);
                $db = new Data($this->db, $config->getConfig("import_table_name","IMPORT_TABLE_NAME"));
                $db->empty_table();
                $data = array();
                $first_row = 1;
                foreach ($dataArray as $key_row => $value) {
                    if ($first_row == 1) {
                        $first_row = 0;
                    } else {
                        //Build the header
                        $template = array();
                        foreach ($dataArray[$key_row] as $key_field => $value) {
                            $template[$dataArray[1][$key_field]] = $dataArray[$key_row][$key_field];
                        }
                        $db->insertArray($template);
                    }
                }

                $this->f3->reroute('/admin/data_table/data_hardware');
                // everything went fine, hurray!
                return true; // allows the file to be moved from php tmp dir to your defined upload dir
            },
                $overwrite,
                $slug
            );
        } else {
            $config = new Config($this->db);
            
            $this->f3->set('import_sheet', $config->getConfig("import_sheet","IMPORT_SHEET"));
            $this->f3->set('import_range', $config->getConfig("import_range","IMPORT_RANGE"));
            $this->f3->set('title', 'Hardware Import');
            //$this->f3->set('content2', $this->LoadContent('add_edit_view/view.js'));
            $this->f3->set('content', 'admin/upload/import_file.htm');

        }

    }

    public function view_data()
    {
        $name = $this->f3->get('PARAMS.name');

        if (strpos($name, 'data_') === 0) {
            $this->Common();
            $data_table = $this->db->exec("SHOW COLUMNS FROM " . $name . ";"); //Run the sql and get the data
            $this->f3->set('data_table', $data_table);
            $data = $this->db->exec("SELECT * FROM " . $name . ";"); //Run the sql and get the data
            $this->f3->set('data', $data);
            $this->f3->set('title', $name);
            $this->f3->set('page_head', 'Data tables');
            $this->notemplate = true;
            $this->f3->set('content2', Template::instance()->render('admin/data_tables/data_tablejs.htm'));
            $this->notemplate = false;
            $this->f3->set('content', 'admin/data_tables/data_table.htm');
        } else {
            $this->f3->reroute('/admin');
        }
    }

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
    public function BuildScheme()
    {
        //*******************
        //Build Schema tables
        //*******************
        try{
            $obj = new Scheme($this->db);
            $obj->BuildScheme();
            $this->notemplate = true;
            echo "OK";
        }catch (Exception $e) {
            $error_log=DataManager($this->db,"log");
            $error_log->LogError($e->getMessage());
            $this->notemplate = true;
            echo "FAIL";
        }
    }

}
