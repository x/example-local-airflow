#!/bin/bash

docker-compose exec airflow-webserver bash -c "python -c \"from airflow.models import DagBag; d = DagBag();\""
