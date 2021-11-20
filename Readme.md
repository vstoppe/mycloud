# Abtract

This is the git repo of my personal cloud server at home. All services are cleanly structured with docker-compose. This setup is ment for private use.

# Concept

This repo is my workspace for docker ($WS_DOCKER). The data of the services is kept in the $DATA dir. With some environment variables and a generic systemd docker@.service file it is easy to manage this environment

## Environment variables

- $DOMAIN: The pulic domain name under which the service's subdomain is served.
- $FRONTEND_IP: This is the ip address of the nginx-frontend which proxies the network traffic to most services. The ports 80 and 443 of this ip should be exposed to the internet.
- $HOSTNAME: This environment variable controls which extra settings are pulled for the services, depending on the host the service runs on.
- $PROXY_IP: Ip address for the proxy server in this repo (privoxy/tor-proxy)
- $RESTART_POLICY: Sets the Restart-policy of the docker-compose-files. Schould be "no" if you control your containers by a process manager like systemd. Otherwise on-failure/always/unless-stopped.
- $STACK_CONF / $WS_DOCKER (old): The directory of this repo: Here we have all data which should be under version control.
- $STACK_DATA / $DATA (old): The directory where the conotainer data is permanently stored. This should be saved by a backup process.

## Networks

- pub_net: The network of the docker host. 
- frontend: The network if the nginx-fronted

# Control letsencrypt-nginx-proxy-companion

The letsencrypt-nginx-proxy-companion is controlled by four variables in the docekr-compose files:

- LETSENCRYPT_EMAIL: Admin e-mail addrss
- LETSENCRYPT_HOST: fqdn for letsencrypt
- VIRTUAL_HOST: fqdn for nginx-proxy
- VIRTUAL_PORT: listening port in the container for nginx-proxy

# Control proxy-companion

- VIRTUAL_HOST: fqdn for nginx-proxy
- VIRTUAL_PORT: listening port in the container for nginx-proxy
- SELF_SIGNED_HOST: fqdn for the self signed certificate

