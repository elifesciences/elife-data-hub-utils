FROM python:3.8-buster

USER root

ENV PROJECT_FOLDER=/opt/elife-data-hub-utils

WORKDIR ${PROJECT_FOLDER}

COPY requirements.build.txt ./
RUN pip install --disable-pip-version-check -r requirements.build.txt

COPY requirements.dev.txt ./
RUN pip install --disable-pip-version-check -r requirements.dev.txt

# install spaCy separately to allow better caching of large language model download
COPY requirements.txt ./
RUN pip install --disable-pip-version-check -r requirements.txt

# download spaCy language models
RUN python -m spacy download en_core_web_lg
RUN python -m spacy download en_core_web_sm

COPY elife_data_hub_utils ./elife_data_hub_utils

COPY setup.py ./
RUN pip install --disable-pip-version-check -e .

COPY tests ./tests
COPY pytest.ini .pylintrc .flake8 ./

