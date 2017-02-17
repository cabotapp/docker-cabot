FROM python:2-alpine

RUN apk add --no-cache \
        python-dev \
        postgresql-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev \
        ca-certificates

ADD build/*.whl /tmp/

RUN pip install --no-cache-dir --disable-pip-version-check /tmp/*.whl \
 && rm /tmp/*.whl

RUN apk del \
        python-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev

ADD manage.py /manage.py

ENTRYPOINT []
CMD ["/bin/sh"]
