FROM python:3.7.10-buster

USER root

ENV PROJECT_FOLDER=/opt/elife-data-hub-utils

WORKDIR ${PROJECT_FOLDER}

COPY requirements.build.txt ./
RUN pip install --disable-pip-version-check -r requirements.build.txt

COPY requirements.dev.txt ./
RUN pip install --disable-pip-version-check -r requirements.dev.txt

COPY requirements.txt ./
RUN pip install --disable-pip-version-check -r requirements.txt

COPY elife_data_hub_utils ./elife_data_hub_utils

COPY setup.py ./
RUN pip install --disable-pip-version-check -e .

COPY tests ./tests
COPY pytest.ini .pylintrc .flake8 ./

