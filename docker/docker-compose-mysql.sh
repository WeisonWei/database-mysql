#!/usr/bin/env bash
export KAFKA_ADVERTISED_HOST_NAME=localhost
docker-compose -f docker-compose-mysql.yml up -d
#docker stack deploy -c docker-compose-mysql.yml docker-compose-mysql