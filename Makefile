#!/usr/bin/make -f

DOCKER_COMPOSE_DEV = docker-compose
DOCKER_COMPOSE_CI = docker-compose -f docker-compose.yml
DOCKER_COMPOSE = $(DOCKER_COMPOSE_DEV)

DEV_RUN = $(DOCKER_COMPOSE) run --rm elife-data-hub-utils
DEV_RUN_PYTHON = $(DEV_RUN) python

VENV = venv
PIP = $(VENV)/bin/pip
PYTHON = $(VENV)/bin/python

ARGS =

.PHONY: build


venv-clean:
	@if [ -d "$(VENV)" ]; then \
		rm -rf "$(VENV)"; \
	fi

venv-create:
	python3 -m venv $(VENV)

dev-install:
	$(PIP) install --disable-pip-version-check -r requirements.build.txt
	$(PIP) install --disable-pip-version-check -r requirements.dev.txt
	$(PIP) install --disable-pip-version-check -e .

dev-venv: venv-create dev-install


dev-flake8:
	$(PYTHON) -m flake8 elife_data_hub_utils tests

dev-pylint:
	$(PYTHON) -m pylint elife_data_hub_utils tests

dev-lint: dev-flake8 dev-pylint

dev-pytest:
	$(PYTHON) -m pytest -p no:cacheprovider $(ARGS)

dev-watch:
	$(PYTHON) -m pytest_watch -- -p no:cacheprovider -p no:warnings $(ARGS)

dev-test: dev-lint dev-pytest


flake8:
	$(DOCKER_COMPOSE) -m flake8 elife_data_hub_utils tests

pylint:
	$(DOCKER_COMPOSE) -m pylint elife_data_hub_utils tests

lint: flake8 pylint

pytest:
	$(DOCKER_COMPOSE) -m pytest -p no:cacheprovider $(ARGS)

watch:
	$(DOCKER_COMPOSE) -m pytest_watch -- -p no:cacheprovider -p no:warnings $(ARGS)

test: lint pytest


ci-build-and-test:
	$(DOCKER_COMPOSE_CI) build
	$(MAKE) PYTHON="$(DEV_RUN_PYTHON)" dev-test

ci-clean:
	$(DOCKER_COMPOSE_CI) down -v
