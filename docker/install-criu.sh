#!/bin/bash

cd /tmp
mkdir criu
cd criu
echo "Downloading https://github.com/checkpoint-restore/criu/archive/v$CRIU_VERSION.tar.gz..."
curl -L -o criu-$CRIU_VERSION.tar.gz https://github.com/checkpoint-restore/criu/archive/v$CRIU_VERSION.tar.gz
tar xzf criu-$CRIU_VERSION.tar.gz
cd criu-$CRIU_VERSION
make
