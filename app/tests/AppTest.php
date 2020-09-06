<?php

require __DIR__ . '/../vendor/autoload.php';
use PHPUnit\Framework\TestCase;

class AppTest extends TestCase {
    public function test() {
        // Could also be provided by a custom base TestCase.
        $f3 = Base::instance();
       

        $f3->config('config/config.ini');
        $f3->config('config/routes.ini');

        //$f3->set('QUIET', true);
        $f3->set('APP.TEST', true);
        $this->assertNull($f3->mock('GET /admin'));
        print_r($f3->get('RESPONSE'));die();
        $f3->set('QUIET', false);
        //$this->assertSame('TEXT', $f3->get('RESPONSE'));
    }
}