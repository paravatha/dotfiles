#!/bin/bash
set -e

export DOCKER_DEFAULT_PLATFORM=linux/amd64
export PYTHON_VERSION=3.13

# Use the official slim Python image
docker pull python:${PYTHON_VERSION}-slim
docker tag python:${PYTHON_VERSION}-slim python${PYTHON_VERSION}-test

docker run --name pytest -d python${PYTHON_VERSION}-test sleep infinity

