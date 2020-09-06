<?php
class Event 
{
 
    public function SendEvent($channel,$Message)
    {
        //******************************************
        //Function to get the session token from ACI
        //******************************************
        $web = \Web::instance();
        $url = "http://localhost:8080/v1/api";
//{"event":"new data arived","channel":"test"}
        $body = array(
            "event" => $Message,
            "channel"=>$channel
        );

        $options = array(
            'method' => "POST",
            "content" => json_encode($body),
        );

        $result = $web->request($url, $options);
        
    }
 
}
