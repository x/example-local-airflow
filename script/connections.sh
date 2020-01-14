#!/bin/bash -e

# Connection for google cloud services, GCS, bigquery, cloudsql.
# By not setting a key_path or scope we default to the user's
# credentials mounted into /usr/local/airflow/.config
airflow connections --delete --conn_id google_cloud_default
airflow connections --add \
    --conn_id=google_cloud_default \
    --conn_type=google_cloud_platform \
    --conn_extra='{
        "extra__google_cloud_platform__key_path": "",
        "extra__google_cloud_platform__project": "${GCLOUD_PROJECT}",
        "extra__google_cloud_platform__scope": ""
    }'

# Connect to Google Container Registry using the user's credentials
# mounted in /usr/local/airflow/.config
airflow connections --delete --conn_id docker_default
airflow connections --add \
    --conn_id=docker_default \
    --conn_uri="docker://oauth2accesstoken:$(gcloud auth application-default print-access-token)@gcr.io/${GCLOUD_PROJECT}"


# Connect to staging clousql instance via a proxy with a regular postgres connection
airflow connections --delete --conn_id postgres_default
airflow connections --add \
    --conn_id=postgres_default \
    --conn_uri "postgresql://airflow:${CLOUDSQL_POSTGRES_PASSWORD}@cloudsql-proxy/postgres"


# Connect to staging clousql instance with a google cloudsql connection (used for google first-party operators)
airflow connections --delete --conn_id google_cloud_sql
airflow connections --add \
  --conn_id=google_cloud_sql \
  --conn_uri="gcpcloudsql://airflow:${CLOUDSQL_POSTGRES_PASSWORD}@1.1.1.1:3306/postgres?database_type=postgres&project_id=${GCLOUD_PROJECT}&location=${GCLOUD_REGION}&instance=${CLOUDSQL_POSTGRES_DB_NAME}&use_proxy=True&sql_proxy_use_tcp=False"
