# Abstract

This is the proxy and advertisement filter setup. We have

- tor proxy (port 9050)
- privoxy (port 8118): content filter
- nginx webserver which services the proxy.pac file


# Configuration

- The [tor-privoxy-alpine](https://hub.docker.com/r/rdsubhas/tor-privoxy-alpine) image was incomplete, so it had to be a little bit adjusted by a Dockerfile. Documentation is included
- This proxies have to listen on an ip which is directly accessible for the clients. Therefore the IP is configured by the $PROXY_IP environment variable.
