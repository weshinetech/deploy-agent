#!/bin/bash


#
# stop docker containers
#
docker-compose down


#
# load images
#
gunzip uniapps-exam-sl-cbt.tar.gz
gunzip uniapps-exam-couchdb-2020-12-01.tar.gz
docker load -i uniapps-exam-sl-cbt.tar
docker load -i uniapps-exam-couchdb-2020-12-01.tar



#
# pull docker images
#
docker pull public.ecr.aws/m6p9r3p6/uniapps-exam-sl:cbt
docker pull public.ecr.aws/m6p9r3p6/uniapps-exam-couchdb:2020.12.01


#
# start docker compose
#
docker-compose up -d
