<?php
class AWX extends DB\SQL\Mapper
{
    public function __construct(DB\SQL $db)
    {
        parent::__construct($db, 'terminals');
    }
    public function RunJob($host,$token,$job_id)
    {
        $web = \Web::instance();
        $url = "http://$host/api/v2/job_templates/$job_id/launch/";
        $options = array(
            'method' => "POST",
            'header' => array(
                "Authorization:" . $token,
                "Content-Type: application/json",
            )
        );
        $result = $web->request($url, $options);  
        $json_data=json_decode($result['body']);
        return $json_data;
    }


}
