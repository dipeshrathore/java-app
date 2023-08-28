#!/bin/bash

set -e

APP_NAME="aws-flow"
AWS_ACCOUNT_ID="501932962727"
AWS_DEFAULT_REGION="us-east-1"
APP_VERSION="0.0.1"
CONTAINER_NAME="aws-flow"

# Login to Amazon ECR via AWS-CLI command
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"

# Stop the container with the specified name if it's running
if docker ps -q --filter "name=$CONTAINER_NAME" | grep -q .; then
  echo "Stopping container $CONTAINER_NAME..."
  docker stop "$CONTAINER_NAME"
fi

# Remove the container with the specified name if it exists (stopped or not)
if docker ps -aq --filter "name=$CONTAINER_NAME" | grep -q .; then
  echo "Removing container $CONTAINER_NAME..."
  docker rm "$CONTAINER_NAME"
fi

# Pull the latest image from AWS ECR
docker pull "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${APP_NAME}:${APP_VERSION}"

# Run the latest image in a new container
docker run -p 80:8080 -d --name "$CONTAINER_NAME" "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${APP_NAME}:${APP_VERSION}"

# List Docker images
docker images

# List running containers
docker ps

