## Jenkins Docker

This is a custom Docker image of Jenkins built for running host's Docker inside Jenkins (Docker in Docker).

<hr>

### Steps

0. Make sure you have [Docker](https://docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed. Please take a look at [assumptions](#Assumptions).
1. Create `.env` file using the values from `.env.example`.
2. Depending upon your variant of `.env` file name, update the `--env-file` argument in `down.sh` and `up.sh`.
3. - To start: `./up.sh`
   - To stop: `./down.sh`

<hr>

### Explanation

Docker inside docker ([docker:dind](https://hub.docker.com/_/docker)) is an image used for running a Docker instance inside a Docker host. This way, we do not depend on host's Docker for executing Docker commands inside another container.

For our case, we need to be able to run Docker commands inside Jenkins build steps. So in our `docker-compose.yml` file, we create a `jenkins_dind` service which is a privileged service. Note that this service is independent of any container.

Then, we create a Jenkins container using the `Dockerfile` provided officially by Jenkins. You can modify it according to your needs. It depends on `jenkins_dind` service for executing Docker commands.

Finally, in our shell scripts, we include the following logic:

- Create `./certs/client` and `./data` folders if not exists.

  - Note that these values are hardcoded in `.env.example` file. So this value should not change in `.env` file. If you need to change these file paths, then change in both `.env` and `up.sh` file

- Create `jenkins_network` upon start and remove it on stop.

- Running services inside `docker-compose.yml` in detached mode.

<hr>

### Assumptions

- Docker and Docker Compose is installed. Latest versions are preferred.
- Configured Docker commands to run without `sudo`.
  - If you have not configured it that way, then add `sudo` in all docker commands in `up.sh` and `down.sh`.

<hr>

### References

- [Docker in Jenkins](https://www.jenkins.io/doc/book/installing/docker/#setup-wizard)
- [Docker inside Docker for Jenkins](https://itnext.io/docker-inside-docker-for-jenkins-d906b7b5f527)
