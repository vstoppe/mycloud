# Abtract

This is the git repo of my personal cloud server at home. All services are cleanly structured with docker-compose. This setup is ment for private use.

# Concept

This repo is my workspace for docker ($WS_DOCKER). The data of the services is kept in the $DATA dir. With some environment variables and a generic systemd docker@.service file it is easy to manage this environment

## Environment variables

- $DATA: The directory where the conotainer data is permanently stored. This is just saved by a backup process.
- $DOMAIN: The pulic domain name unter which the service's subdomain is served.
- $FRONTEND_IP: This ip address of the nginx-frontend which proxies the network traffic to most services. The ports 80 and 443 of this ip should be exposed to the internet.
- $HOSTNAME: This environment variable controls which extra settings are pulled for the services, depending on the host the service runs.
- $WS_DOCKER: The directory of this repo: Here we have all data which should be under version control.

## Networks

- pub_net: The network of the docker host. 
- frontend: The network if the nginx-fronted


