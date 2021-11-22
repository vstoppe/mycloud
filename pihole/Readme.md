# Sources

[Pi-hole on Docker Hub](https://hub.docker.com/r/pihole/pihole)

# Setup

The container expects a pihole.env file with all settings. It is also used for the ".env" file. Copy the pihole.env.example and adjust the settings. See the link abvole for all available environment variables:

./pihole> `cp pihole.env.example pihole.env`

./pihole> `ln -s pihole.env .env`

The Variables in your myhostname.env have to be adjusted to your needs. A description is included.
