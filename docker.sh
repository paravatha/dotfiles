export DOCKER_DEFAULT_PLATFORM=linux/amd64

docker build -t python3-test .

docker run --name pytest -d python3-test sleep infinity

