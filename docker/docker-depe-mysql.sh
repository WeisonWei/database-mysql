#!/usr/bin/env bash
export KAFKA_ADVERTISED_HOST_NAME=localhost
docker-compose -f docker-depe-mysql.yml up -d
#docker stack deploy -c docker-depe.yml docker-tool-depe