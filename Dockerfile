FROM puckel/docker-airflow:1.10.3

USER root

# Gcloud Dependencies
ARG CLOUD_SDK_VERSION=274.0.1
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ARG INSTALL_COMPONENTS
RUN apt-get update -qqy && apt-get install -qqy \
  curl \
  gcc \
  python-dev \
  python-setuptools \
  apt-transport-https \
  lsb-release \
  openssh-client \
  git \
  gnupg \
  && easy_install -U pip && \
  pip install -U crcmod && \
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update && apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 $INSTALL_COMPONENTS && \
  gcloud config set core/disable_usage_reporting true && \
  gcloud config set component_manager/disable_update_check true && \
  gcloud config set metrics/environment github_docker_image && \
  gcloud --version

USER airflow

COPY config/airflow.cfg /usr/local/airflow/airflow.cfg
COPY script/connections.sh /usr/local/airflow/connections.sh
COPY script/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
