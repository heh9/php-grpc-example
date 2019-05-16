FROM ubuntu:19.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y curl unzip php7.2-dev zlib1g-dev git
RUN cd /tmp && \
    curl -sLO https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-x86_64.zip && \
    unzip protoc-3.7.1-linux-x86_64.zip && \
    mv /tmp/bin/protoc /bin/protoc
RUN curl -sLO https://github.com/spiral/php-grpc/releases/download/v1.0.6/protoc-gen-php-grpc-1.0.6-linux-amd64.tar.gz && \
    tar -xvf protoc-gen-php-grpc-1.0.6-linux-amd64.tar.gz && \
    mv protoc-gen-php-grpc-1.0.6-linux-amd64/protoc-gen-php-grpc /bin/protoc-gen-php-grpc && \
    chmod +x /bin/protoc-gen-php-grpc
RUN curl -sLO https://github.com/spiral/php-grpc/releases/download/v1.0.6/rr-grpc-1.0.6-linux-amd64.tar.gz && \
    tar -xvf rr-grpc-1.0.6-linux-amd64.tar.gz && \
    mv rr-grpc-1.0.6-linux-amd64/rr-grpc /bin/rr-grpc && \
    chmod +x /bin/rr-grpc
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /bin/composer
RUN pecl install grpc
RUN echo 'extension=grpc.so' > /etc/php/7.2/php.ini
RUN pecl install protobuf
RUN echo 'extension=protobuf.so' >> /etc/php/7.2/php.ini
RUN git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc
RUN cd grpc && git submodule update --init && make grpc_php_plugin
RUN mv /grpc/bins/opt/grpc_php_plugin /bin/grpc_php_plugin
RUN rm -rf /grpc

WORKDIR /app
ADD composer.json composer.lock ./
RUN composer install

ADD . /app
