#!/usr/bin/env bash
docker container rm test-ansible-setup
docker image rm ansible-ubuntu-setup:latest

docker build -t ansible-ubuntu-setup .
docker run -it --name test-ansible-setup ansible-ubuntu-setup
