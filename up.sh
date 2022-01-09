docker network create jenkins_network & \
mkdir certs/ data/ certs/client/ & \
docker-compose \
	-f docker-compose.yml \
	--env-file .env \
	up -d
