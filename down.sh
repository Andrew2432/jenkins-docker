docker-compose \
	-f docker-compose.yml \
	--env-file .env \
	down && \
docker network remove jenkins_network
