#!/bin/bash


#
# stop docker containers
#
docker-compose down


#
# load images
#
docker load -i uniapps-exam-2020-12-01.tar
docker load -i uniapps-exam-couchdb-2020-12-01.tar



#
# pull docker images
#
docker pull weshinetech/uniapps-exam:2020.12.01
docker pull weshinetech/uniapps-exam-couchdb:2020.12.01


#
# start docker compose
#
docker-compose up -d
