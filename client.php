<?php

require dirname(__FILE__).'/vendor/autoload.php';

use \Service\GreeterClient;
use \Service\Message;

$client = new GreeterClient("server:9001", [
    "credentials" => Grpc\ChannelCredentials::createInsecure(),
]);

function testSync(\Service\GreeterClient $client) {
    $i = 10000;
    $start = microtime(true);
    for($i = 0; $i < 10000; ++$i) {
        $msg = new Message();
        $client->sayHello($msg->setName("Hello"))->wait();
        if ($i % 100 == 0) {
            echo("Sent $i requests\n");
        }
    }
    $end = microtime(true);
    $time = ($end - $start) * 1000;
    echo("Took $time ms for 10000 synchronous calls\n");
}

testSync($client);
