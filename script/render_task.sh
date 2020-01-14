#!/bin/bash

docker-compose exec airflow-webserver bash -c "airflow render $1 $2 $3"
