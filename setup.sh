#!/bin/bash


#
# stop docker containers
#
docker-compose down


#
# load images
#
gunzip uniapps-exam-sl-2020-10-02.tar.gz
gunzip uniapps-exam-couchdb-2020-12-01.tar.gz
docker load -i uniapps-exam-sl-2020-10-02.tar
docker load -i uniapps-exam-couchdb-2020-12-01.tar



#
# pull docker images
#
docker pull weshinetech/uniapps-exam-sl:2020.10.02
docker pull weshinetech/uniapps-exam-couchdb:2020.12.01


#
# start docker compose
#
docker-compose up -d
