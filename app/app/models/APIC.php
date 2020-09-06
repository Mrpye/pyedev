<?php
class APIC extends DB\SQL\Mapper
{
    private $token;

    public function __construct(DB\SQL $db)
    {
        parent::__construct($db, 'terminals');
    }

    public function GetSessionToken()
    {
        //******************************************
        //Function to get the session token from ACI
        //******************************************
        $web = \Web::instance();
        $url = "https://APIC/api/aaaLogin.json";

        $body = array(
            "aaaUser" => array(
                "attributes" => array(
                    "name" => "admin",
                    "pwd" => "thor123!",
                ),
            ),
        );

        $options = array(
            'method' => "POST",
            "content" => json_encode($body),
        );

        $result = $web->request($url, $options);
        if (!empty($result)) {
            $searchword = "Set-Cookie: APIC-cookie";
            $matches = array_filter($result['headers'], function ($var) use ($searchword) {return preg_match("/\b$searchword\b/i", $var);});
            $first_item = array_values($matches)[0];
            $this->token = str_replace("Set-Cookie: ", "", $first_item);
            return $this->token;
        } else {
            return false;
        }
    }
 
    public function GetTennats()
    {
        $token = $this->GetSessionToken();
        $colors=array(
            "key-style-1",
            "key-style-2",
            "key-style-3",
            "key-style-4",
            "key-style-5",
            "key-style-6",
            "key-style-6",
            "key-style-6",
            "key-style-6",
            "key-style-6",
        );
        if ($token != false) {
            $web = \Web::instance();
            $url = "https://APIC/api/node/class/fvTenant.json";

            $options = array(
                'method' => "GET",
                'header' => array(
                    "Cookie:" . $token,
                    "Content-Type: application/json",
                ),
                "content" => json_encode($body),
            );
            $result = $web->request($url, $options);  
            $json_tenant_data=json_decode($result['body']);
            //******************
            //Lets map the items
            //******************
            $tenants=array();
            $count=0;
            foreach ($json_tenant_data->imdata as $tn){
                $count++;
                $tn->fvTenant->attributes->color="key-style-".$count;
                $tenants[]=$tn->fvTenant->attributes;
            }
           return $tenants;
        }
        
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
