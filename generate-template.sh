#!/bin/bash

APP_NAME=$1
PORT=${3:-3000}
EXPOSE_PORT=${6:-80}
REGISTRY=${4:-registry.jorgeadolfo.com}
REPLICAS=${5:-3}
VERSION=${2:-latest}

echo " - options -"
echo "APP_NAME=$APP_NAME"
echo "PORT=$PORT"
echo "EXPOSE_PORT=$EXPOSE_PORT"
echo "REGISTRY=$REGISTRY"
echo "REPLICAS=$REPLICAS"
echo "VERSION=$VERSION"

# ----------------------------------------------

SERVICE_TEMPLATE=`cat templates/service.yml |\
sed s.{APP_NAME}.$APP_NAME.g |\
sed s.{PORT}.$PORT.g |\
sed s.{EXPOSE_PORT}.$EXPOSE_PORT.g`

DEPLOY_TEMPLATE=`cat templates/deployment.yml |\
sed s.{APP_NAME}.$APP_NAME.g |\
sed s.{PORT}.$PORT.g |\
sed s.{REPLICAS}.$REPLICAS.g |\
sed s.{VERSION}.$VERSION.g |\
sed s.{EXPOSE_PORT}.$EXPOSE_PORT.g`

printf "$SERVICE_TEMPLATE" > apps/$APP_NAME.service.yml
printf "$DEPLOY_TEMPLATE" > apps/$APP_NAME.deployment.yml