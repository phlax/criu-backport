#!/bin/bash


apt-get update -qq

apt-get install \
        -qq --no-install-recommends \
        $RUN_PKGS
