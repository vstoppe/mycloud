FROM python:3-alpine
RUN apk add git;git clone https://github.com/nextcloud/news-updater;cd news-updater/;python3 setup.py install --install-scripts=/usr/bin;cd;rm -rf news-updater/;apk del git
CMD nextcloud-news-updater ${NEXTCLOUD_URL} --user ${NEXTCLOUD_ADMIN_USER} --password ${NEXTCLOUD_ADMIN_PASSWORD} --loglevel info
