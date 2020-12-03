#!/bin/bash

#
# pull docker images
#
docker pull weshinetech/uniapps-exam:2020.12.01
docker pull weshinetech/uniapps-exam-couchdb:2020.12.01


#
# start docker compose
#
docker-compose up -d
