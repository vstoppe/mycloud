# This is my bitwarden installation by the (manuel method)[https://help.bitwarden.com/article/install-on-premise/#manual-docker-installations].

Most steps are performed by the setup.sh script. It takes all environment variables for configuration from one file.


# Setup

- Set your environment variables in your myhostname.env
-- `cp myhostname.env $HOSTNAME.env`
-- `vim $HOSTNAME.env`
- Execute `setup.sh`

Becaus bitwarden-nginx uses a letsencrpyt certificate interanally, we need to create it first. Therefore we fire up and nginx-container to request the certs. When the certs are generated we stop the container again:
- `source $HOSTNAME.env`
- `docker run --rm -e LETSENCRYPT_HOST=$SERVICE.$DOMAIN -e LETSENCRYPT_EMAI=$ADMIN_MAIL  nginx:alpine`
- `Control+C`

Now check the Setup:

`docker-compose up`
