FROM node:4-alpine as builder

ENV PYTHONUNBUFFERED 1
RUN mkdir /code

WORKDIR /code

RUN apk add --no-cache \
        python-dev \
        py-pip \
        postgresql-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev \
        ca-certificates \
        bash \
        git

RUN npm install -g \
        --registry http://registry.npmjs.org/ \
        coffee-script \
        less@1.3

RUN pip install --upgrade pip wheel twine
# Gevent install is super slow...cache it early
RUN pip install gevent==1.2.1

ARG CABOT_VERSION
RUN git clone --branch=${CABOT_VERSION} https://github.com/arachnys/cabot /code

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements-dev.txt
RUN pip install --no-cache-dir -r requirements-plugins.txt

RUN python manage.py collectstatic --noinput
RUN python manage.py compress
RUN python setup.py sdist bdist_wheel

FROM python:2-alpine

RUN apk add --no-cache \
        python-dev \
        postgresql-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev \
        ca-certificates

# Gevent install is super slow...cache it early
RUN pip install gevent==1.2.1
COPY --from=builder /code/dist/*.whl /tmp/
RUN pip install --no-cache-dir --disable-pip-version-check /tmp/*.whl
RUN rm -rf /tmp

RUN apk del \
        python-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openldap-dev

ENTRYPOINT []
CMD ["/bin/sh"]
