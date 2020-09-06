<?php

class BaseController
{

    protected $f3;
    protected $db;
    protected $no_db;
    protected $default_reroute = "/";
    protected $jsscipts = array();
    protected $notemplate = false;

    public function beforeroute()
    {
        $this->f3->set('message', '');
    }

    public function __construct()
    {

        $f3 = Base::instance();
        $this->f3 = $f3;

        try {
            $db = new DB\SQL(
                $f3->get('db_dns') . $f3->get('db_name'),
                $f3->get('db_user'),
                $f3->get('db_pass')
            );
            $this->db = $db;
            $this->setTimeZone();
        } catch (Exception $e) {
            if ($e->getMessage() == "SQLSTATE[HY000] [1049] Unknown database 'dashboard'") {

                $this->install();
                $this->db = $db;
                sleep(1);
                $this->f3->reroute($this->default_reroute);
            }
        }

        //$this->f3->reroute($this->default_reroute);
    }

    private function setTimeZone()
    {
        try {
            $config = new Config($this->db);
            date_default_timezone_set($config->getConfig("time_zone", "TIME_ZONE"));
        } catch (Exception $e) {
        }

    }
    private function RunSQL($data_path)
    {
        $db = new DB\SQL(
            $this->f3->get('db_dns'),
            $this->f3->get('db_user'),
            $this->f3->get('db_pass')
        );

        $file = fopen($data_path, "r");
        $bsql = "";

        while (!feof($file)) {
            $data = fgets($file);
            if ($this->endsWith($data, ";")) {
                $bsql = $bsql . $data;
                $r = $db->exec($bsql); //Run the sql and get the data
                $bsql = "";
            } else {
                $bsql = $bsql . $data;
            }

        }
        fclose($file);
    }
    private function install()
    {
        try {
            //********************
            //Install the database
            //********************
            $data_path = realpath(__DIR__ . "/../../data/dashboard_data.sql");

            if (file_exists($data_path)) {
                $this->RunSQL($data_path);
            }

            $data_path = realpath(__DIR__ . "/../../data/dashboard_data2.sql");
            if (file_exists($data_path)) {
                $this->RunSQL($data_path);
            }

            $db = new DB\SQL(
                $this->f3->get('db_dns') . $this->f3->get('db_name'),
                $this->f3->get('db_user'),
                $this->f3->get('db_pass')
            );

            $this->db = $db;

        } catch (Exception $e) {
            //Display a setup error
            $f3->error(500, 'Cannot connect to db!!');
        }
    }

    private function endsWith($string, $endString)
    {
        $len = strlen($endString);
        if ($len == 0) {
            return true;
        }
        return (substr(trim($string), -1) === $endString);
    }

    public function LOG_Error($msg, $type)
    {
        try {
            $error_log = DataManager($this->db, "log");
            $error_log->LogError($msg, $type);
        } catch (Exception $e) {

        }
    }

    public function Error_Page($error_no, $msg, $is_api = false)
    {
        if ($is_api == true) {
            http_response_code(401);
            echo $msg;
            exit;
        } else {
            $this->f3->error($error_no, $msg);
        }
    }

    public function session_readonly()
    {
        $session_name = preg_replace('/[^\da-z]/i', '', $_COOKIE[session_name()]);
        $session_path = session_save_path() . '/sess_' . $session_name;
        if (file_exists($session_path)) {

            $session_data = file_get_contents(session_save_path() . '/sess_' . $session_name);

            $return_data = array();
            $offset = 0;
            while ($offset < strlen($session_data)) {
                if (!strstr(substr($session_data, $offset), "|")) {
                    break;
                }

                $pos = strpos($session_data, "|", $offset);
                $num = $pos - $offset;
                $varname = substr($session_data, $offset, $num);
                $offset += $num + 1;
                $data = unserialize(substr($session_data, $offset));
                $return_data[$varname] = $data;
                $offset += strlen(serialize($data));
            }
            $_SESSION = $return_data;
        }
    }

    public function Basic_Auth()
    {
        $token = str_replace("Basic ", "", $this->f3->get("HEADERS")['Authorization']);
        if ($token == "") {
            $this->Error_Page(401, "This page requires authorization", true);
            exit;
        } else {
            $decoded_token = base64_decode($token);
            $creds = explode(":", $decoded_token);
            $user = new User($this->db);
            $username = $creds[0];
            $password = $creds[1];
            if ($username == "api") {
                $user->getByName($username);
                if ($user->dry()) {
                    $this->Error_Page(401, "Incorrect Username or Password", true);
                } else {
                    if (md5($password) == $user->password) {
                        return true;
                    } else {
                        $this->Error_Page(401, "Incorrect Username or Password", true);
                    }
                }
            }else{
                $this->Error_Page(401, "Invalid Username", true);
            }
        }

    }
}
