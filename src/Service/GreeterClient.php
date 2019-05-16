<?php
// GENERATED CODE -- DO NOT EDIT!

namespace Service;

/**
 */
class GreeterClient extends \Grpc\BaseStub {

    /**
     * @param string $hostname hostname
     * @param array $opts channel options
     * @param \Grpc\Channel $channel (optional) re-use channel object
     */
    public function __construct($hostname, $opts, $channel = null) {
        parent::__construct($hostname, $opts, $channel);
    }

    /**
     * @param \Service\Message $argument input argument
     * @param array $metadata metadata
     * @param array $options call options
     */
    public function sayHello(\Service\Message $argument,
      $metadata = [], $options = []) {
        return $this->_simpleRequest('/service.Greeter/sayHello',
        $argument,
        ['\Service\Message', 'decode'],
        $metadata, $options);
    }

}
