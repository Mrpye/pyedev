<?php

class ACI_APIController extends BaseAdminController
{

    public function beforeroute()
    {
       $this->session_readonly();
        if ($_SESSION['user'] === null) {
            if (!$this->Basic_Auth()) {
                //$this->f3->reroute('/login');
                $this->notemplate = true;
                http_response_code(400);
                exit;
            }
        }
    }

    public function Logout()
    {
        $this->f3->clear('SESSION');
    }

    public function tenants()
    {
        $this->notemplate = true;
        header('Content-Type: application/json');
        http_response_code(200);
        $config = new Config($this->db);
        if ($config->getConfig("simulate_tenants", "SIMULATE_TENANTS") > 0) {
            $tenants = $this->FakeTenants();
        } else {
            $apic = new APIC($this->db);
            $tenants = $apic->GetTennats();
        }
        $json_data = json_encode($tenants, JSON_PRETTY_PRINT);
        echo $json_data;

    }

    public function terminals()
    {
        $this->notemplate = true;
        header('Content-Type: application/json');
        http_response_code(200);
        $db_res = $this->db->exec("SELECT * FROM terminals;"); //Run the sql and get the data
        $json_data = json_encode($db_res, JSON_PRETTY_PRINT);
        echo $json_data;

    }

    public function changeTenant()
    {
        $this->notemplate = true;
        $post_data = file_get_contents("php://input");
        $dm = new DataManager($this->db, "terminals");
        $config = new Config($this->db);
        $obj = (object) json_decode($post_data, true);

        $simulate=$config->getConfig("simulate_awx", "SIMULATE_AWX");

        if($simulate>0){
            $data = array(
                "id" => $obj->id,
                "new_tenant" => $obj->tenant,
                "new_style" => $obj->style,
                "state" => 1,
            );
        }else{
            $awx = new AWX($this->db);
            $awx_obj = $awx->RunJob($config->getConfig("awx_host", "AWX_HOST"), $config->getConfig("awx_authorization", "AWX_AUTHORIZATION"), $config->getConfig("awx_job_id", "AWX_JOB_ID"));
            $data = array(
                "id" => $obj->id,
                "new_tenant" => $obj->tenant,
                "new_style" => $obj->style,
                "state" => $awx_obj->job,
            );
        }

        $dm->updateArray($data);
        //**************************************
        //Tell the browser the job is in process
        //**************************************
        $env = new Event();
        $env->SendEvent("aci_control", json_encode(array(
            "job_status_changed" => array(
                "action" => "job_started",
                "job_no" => $data['state'],
            ),
        )));

        $return_data = [
            'ok' => ['everything worked.'],
        ];

        if ($simulate>0) {
            sleep(5);

            $old_job = $data['state'];
            $data['state'] = 0;
            $data['tenant'] = $data['new_tenant'];
            $data['style'] = $data['new_style'];
            $data['new_style'] = "";
            $data['new_tenant'] = "";

            $dm->updateArray($data);

            $env->SendEvent("aci_control", json_encode(array(
                "job_status_changed" => array(
                    "action" => "job_completed",
                    "job_no" => $old_job,
                ),
            )));

            $json_data = json_encode($return_data);
            header('Content-Type: application/json');
            http_response_code(200);
            echo $json_data;
        } else {
            echo $return_data;
        }
    }

    public function AWXWebHook()
    {

        $this->notemplate = true;
        $post_data = file_get_contents("php://input");

        $config = new Config($this->db);
        if($config->getConfig("enable_dump","ENABLE_DUMP")=="1"){
            $data_dump=new DataManager($this->db,"data_dump");
            $tmp_data=array(
                "data"=>$post_data
            );
            $data_dump->insertArray($tmp_data);
        }

        $dm = new DataManager($this->db, "terminals");
        $env = new Event();
        //Fix and decode the data
        $obj = (object) json_decode($post_data, true);

        if ($obj->status == "successful" || $obj->status == "success"|| $obj->status == "fail") {

            $dm->getByState($obj->id);

            if (!$dm->dry()) {
                $old_job = $dm->state;
                $dm->state = 0;
                $job_state = "";
                if ($obj->status == "success") {
                    $dm->tenant = $dm->new_tenant;
                    $job_state = "job_completed";
                } else {
                    $dm->tenant = "";
                    $job_state = "job_failed";
                }

                $dm->new_tenant = "";
                $dm->save();

                $env->SendEvent("aci_control", json_encode(array(
                    "job_status_changed" => array(
                        "action" => $job_state,
                        "job_no" => $old_job,
                        "result" => $obj,
                    ),
                )), true);

                $return_data = [
                    'ok' => ['everything worked.'],
                ];
                $json_data = json_encode($return_data);
                header('Content-Type: application/json');
                http_response_code(200);
                echo $json_data;
            }
        }

    }

    private function FakeTenants()
    {
        $data = array(
            array(
                'annotation' => '',
                'childAction' => '',
                'descr' => '',
                'dn' => 'uni/tn-infra',
                'extMngdBy' => '',
                'lcOwn' => 'local',
                'modTs' => '2020-02-13T22:23:41.715+00:00',
                'monPolDn' => 'uni/tn-common/monepg-default',
                'name' => 'infra',
                'nameAlias' => '',
                'ownerKey' => '',
                'ownerTag' => '',
                'status' => '',
                'uid' => '0',
                'color' => 'key-style-1',
            ),
            array(
                'annotation' => '',
                'childAction' => '',
                'descr' => '',
                'dn' => 'uni/tn-mgmt',
                'extMngdBy' => '',
                'lcOwn' => 'local',
                'modTs' => '2020-02-13T22:23:41.993+00:00',
                'monPolDn' => 'uni/tn-common/monepg-default',
                'name' => 'mgmt',
                'nameAlias' => '',
                'ownerKey' => '',
                'ownerTag' => '',
                'status' => '',
                'uid' => '0',
                'color' => 'key-style-2',
            ),
            array(
                'annotation' => '',
                'childAction' => '',
                'descr' => '',
                'dn' => 'uni/tn-common',
                'extMngdBy' => '',
                'lcOwn' => 'local',
                'modTs' => '2020-02-13T22:23:32.984+00:00',
                'monPolDn' => 'uni/tn-common/monepg-default',
                'name' => 'common',
                'nameAlias' => '',
                'ownerKey' => '',
                'ownerTag' => '',
                'status' => '',
                'uid' => '0',
                'color' => 'key-style-3',
            ),
        );
        return $data;
    }
}
