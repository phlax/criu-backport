#!/bin/bash


apt-get update -qq
apt-get install \
        -qq --no-install-recommends \
        apt-transport-https \
        bzip2 \
        build-essential \
        ca-certificates \
        curl \
        gnupg2 \
        protobuf-c-compiler \
        protobuf-compiler \
        python-protobuf \
        software-properties-common \
        $BUILD_PKGS
