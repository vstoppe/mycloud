# Abstract

This is an nginx-proxy usually combined with certificate generation capablities

# Compose-files

The jwilder/nginx-proxy in the compose file is enhanced by:

- jrcs/letsencrypt-nginx-proxy-companion
- sebastianheyd/self-signed-proxy-companion

The self-signed-proxy-companion generates an own CA for self signed certificates


# Environment

Environment variables which need to be set:

- FRONTEND_IP: Tell nginx on which ip in local network to listen
- SERVICE: Service name of the compose stack. Defaults to "nginx-proxy" by .env

