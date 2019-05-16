<?php

use \Service\GreeterInterface;
use \Service\Message;
use \Spiral\GRPC\ContextInterface;

class GreeterService implements GreeterInterface {
    public function sayHello(ContextInterface $ctx, Message $msg): Message {
        $res = new Message();
        return $res->setName($msg->getName());
    }
}
