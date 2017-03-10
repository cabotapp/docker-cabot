FROM python:2-alpine

RUN apk add --no-cache \
        python-dev \
        postgresql-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev \
        ca-certificates

RUN pip install --no-cache-dir --disable-pip-version-check cabot==0.9.0

RUN apk del \
        python-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev

ADD manage.py /manage.py

ENTRYPOINT []
CMD ["/bin/sh"]
