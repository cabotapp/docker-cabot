# Supported tags and respective Dockerfile links

- `0.10.7`, `latest` [(0.10.7/Dockerfile)](https://github.com/cabotapp/docker-cabot/blob/master/0.10.7/Dockerfile)
- `0.9.2` [(0.9.2/Dockerfile)](https://github.com/cabotapp/docker-cabot/blob/master/0.9.2/Dockerfile)
- `0.8.6` [(0.8.6/Dockerfile)](https://github.com/cabotapp/docker-cabot/blob/master/0.8.6/Dockerfile)
- `0.6.0` [(0.6.0/Dockerfile)](https://github.com/cabotapp/docker-cabot/blob/master/0.6.0/Dockerfile)

## What is Cabot?

Cabot is a free, open-source, self-hosted infrastructure monitoring platform that provides some of the best features of [PagerDuty](http://www.pagerduty.com), [Server Density](http://www.serverdensity.com), [Pingdom](http://www.pingdom.com) and [Nagios](http://www.nagios.org) without their cost and complexity.

> [github.com/arachnys/cabot](https://github.com/arachnys/cabot)

# How to use this image

- Create a Cabot configuration file from the [example in the cabot repository](https://github.com/arachnys/cabot/blob/master/conf/production.env.example)

- Start a Redis container (or any [Celery Broker](http://docs.celeryproject.org/en/latest/getting-started/brokers/))

> `$ docker run -d --name cabot-redis redis`

- Start a Postgres container

> `$ docker run -d --name cabot-postgres postgres`

- Run the initial database migrations

> `$ docker run --rm --env-file production.env --link cabot-postgres:postgres cabotapp/cabot cabot migrate`

- Start the cabot webserver

> `$ docker run -d --name cabot-web --env-file production.env  --link cabot-postgres:postgres --link cabot-redis:redis -p 5000:5000 cabotapp/cabot gunicorn cabot.wsgi:application -b 0.0.0.0:5000`

- You also need a celery worker and scheduler to run the status checks

> `$ docker run -d --name cabot-worker --env-file production.env  --link cabot-postgres:postgres --link cabot-redis:redis cabotapp/cabot celery worker -A cabot`

> `$ docker run -d --name cabot-beat --env-file production.env  --link cabot-postgres:postgres --link cabot-redis:redis cabotapp/cabot celery beat -A cabot`

# Using docker-compose

You can set up a complete cabot stack easily using docker-compose.

- Clone the docker-cabot repository

> `git clone https://github.com/cabotapp/docker-cabot`

- Copy your cabot config to conf/production.env

- Run `docker-compose up -d`

By default the compose file only binds on localhost. We recommend putting it behind a reverse proxy such as [nginx](https://www.nginx.com) or [Caddy](https://caddyserver.com/), but if you want you can change it to bind publicly on port 80.

There is a [Caddyfile](https://github.com/cabotapp/docker-cabot/blob/master/Caddyfile) included which will automatically set up HTTPS using [Let's Encrypt](https://letsencrypt.org/).

# Issues

If you have any problems using these images please make a github issue on [cabotapp/docker-cabot](https://github.com/cabotapp/docker-cabot/issues).

For any problems relating to Cabot itself, please make issues on [arachnys/cabot](https://github.com/arachnys/cabot/issues)
