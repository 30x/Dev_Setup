#!/bin/sh
export DOCKER_HOST="tcp://172.17.4.99:2375"

#Unset variables that have been set by dockcer machine
unset DOCKER_TLS_VERIFY
unset DOCKER_CERT_PATH
unset DOCKER_MACHINE_NAME
