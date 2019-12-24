FROM python:3.7-alpine

LABEL "maintainer"="Eugene Vasilenko <gmrnsk@gmail.com>"
LABEL "repository"="https://github.com/gofrolist/molecule-action"
LABEL "homepage"="https://github.com/gofrolist/molecule-action"

LABEL "com.github.actions.name"="molecule"
LABEL "com.github.actions.description"="Run Ansible Molecule"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="green"

ENV BUILD_DEPS="\
    gcc \
    libc-dev \
    make \
    musl-dev \
    libffi-dev \
    openssl-dev \
    "

ENV PACKAGES="\
    docker \
    git \
    openssh-client \
    "

ENV PIP_INSTALL_ARGS="\
    --no-cache-dir \
    "

ENV PIP_MODULES="\
    netaddr \
    "

ENV MOLECULE_EXTRAS="docker"

RUN apk add --update --no-cache ${BUILD_DEPS} ${PACKAGES} && \
    pip install ${PIP_INSTALL_ARGS} ${PIP_MODULES} "molecule[${MOLECULE_EXTRAS}]" && \
    apk del --no-cache ${BUILD_DEPS} && \
    rm -rf /root/.cache

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
