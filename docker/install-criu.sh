#!/bin/bash

cd /tmp
mkdir criu
cd criu
curl -o criu-$CRIU_VERSION.tar.bz2 https://download.openvz.org/criu/criu-$CRIU_VERSION.tar.bz2
tar xjf criu-$CRIU_VERSION.tar.bz2
cd criu-$CRIU_VERSION
make
