This is my wallabag configuration a self hosted read it later service
Power up wallabag

# Setup

    cp example.env .env

Customize the .env file to your needs.

Start the wallabag stack:

    docker-compose up

(or as systemd service)


Perform the initialization of the database if it is not done automatically:

    docker exec -t wallabag /var/www/wallabag/bin/console wallabag:install --env=prod --no-interaction