# Abstract

This is an nginx-proxy usually combined with the letsencrypt-nginx-proxy-companion.

# Compose-files

In the dockercompose-files directory contains at least two configurations:

- docker-compose_01-nginx-proxy_and_letsencrypt-companion.yml: nginx-proxy + letsencrypt-companion
- docker-compose_02-nginx-proxy_local.yml: just nginx-proxy for local use

Link the right file for your needs:

`ln -s dockercompose-files/docker-compose_01-nginx-proxy_and_letsencrypt-companion.yml ./docker-compose.yml`

# Environment

The environment variables are set in the file ${HOSTNAME}.env. The myhostname.env file is a template.
Link your environment file:

`ln -s ${HOSTNAME}.env .env`

