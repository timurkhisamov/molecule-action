FROM python:3.7-alpine

LABEL "maintainer"="Eugene Vasilenko <gmrnsk@gmail.com>"
LABEL "repository"="https://github.com/timurkhisamov/molecule-action"
LABEL "homepage"="https://github.com/timurkhisamov/molecule-action"

LABEL "com.github.actions.name"="molecule"
LABEL "com.github.actions.description"="Run Ansible Molecule"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="green"

ARG BUILD_DEPS="\
    gcc \
    libc-dev \
    make \
    musl-dev \
    libffi-dev \
    openssl-dev \
    "

ARG PACKAGES="\
    docker \
    git \
    openssh-client \
    ansible-lint \
    sudo \
    "

ARG PIP_INSTALL_ARGS="\
    --no-cache-dir \
    "

ARG PIP_MODULES="\
    netaddr \
    boto3 \
    botocore \
    molecule-ec2 \
    "

ARG MOLECULE_EXTRAS="docker"

ARG MOLECULE_VERSION="3.0.2"

RUN apk add --update --no-cache ${BUILD_DEPS} ${PACKAGES} && \
    pip install ${PIP_INSTALL_ARGS} ${PIP_MODULES} "molecule[${MOLECULE_EXTRAS}]==${MOLECULE_VERSION}" && \
    apk del --no-cache ${BUILD_DEPS} && \
    rm -rf /root/.cache

CMD cd ${GITHUB_REPOSITORY}; molecule ${INPUT_MOLECULE_OPTIONS} ${INPUT_MOLECULE_COMMAND} ${INPUT_MOLECULE_ARGS}