# Abstract

This is the proxy and advertisement filter setup. We have

- tor proxy (port 9050)
- privoxy (port 8118): content filter
- nginx webserver which services the proxy.pac file


# Compose-files

In the dockercompose-files directory contains at least two configurations:

- docker-compose_01-privoxy+nginx_wpad.yml: Use this in a network
- docker-compose_02-privoxy_local.yml: Use this on a local machine. 

Link the right file for your needs:

`ln -s dockercompose-files/docker-compose_02-privoxy+local.yml ./docker-compose.yml`


# Configuration

- The [tor-privoxy-alpine](https://hub.docker.com/r/rdsubhas/tor-privoxy-alpine) image was incomplete, so it had to be a little bit adjusted by a Dockerfile. Documentation is included
- This proxies have to listen on an ip which is directly accessible for the clients. Therefore the IP is configured by the $PROXY_IP environment variable.
