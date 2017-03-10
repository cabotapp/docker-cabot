FROM python:2-alpine

RUN apk add --no-cache \
        python-dev \
        postgresql-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev \
        ca-certificates

ARG CABOT_VERSION
RUN pip install --no-cache-dir --disable-pip-version-check cabot==${CABOT_VERSION}

RUN apk del \
        python-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev

ENTRYPOINT []
CMD ["/bin/sh"]
