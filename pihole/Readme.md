# Sources

[Pihole und Docker Hub](https://hub.docker.com/r/pihole/pihole)

# Setup

The myhostname.env file containes variables for the docker-compose.yml file AND the container. Before the first use you have to link your myhostname.env file to the .env

./pihole> `ln -s myhostname.env .env`

The Variables in your myhostname.env have to be adjusted to your needs. A description is included.
