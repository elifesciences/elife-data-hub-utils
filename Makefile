#!/usr/bin/make -f

DOCKER_COMPOSE_DEV = docker-compose
DOCKER_COMPOSE_CI = docker-compose -f docker-compose.yml
DOCKER_COMPOSE = $(DOCKER_COMPOSE_DEV)

ci-build-and-test:
	$(DOCKER_COMPOSE_CI) build

ci-clean:
	$(DOCKER_COMPOSE_CI) down -v
