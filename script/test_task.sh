#!/bin/bash

docker-compose exec airflow-webserver bash -c "airflow test $1 $2 $3"
