# Abstract

TT-RSS is an amazing lightwight news reader. This configuration uses the image [skyr0/ttrss](https://hub.docker.com/r/skyr0/ttrss/dockerfile).

# Setup

* `cp myhostname.env $HOSTNAME.env`
* customize the config for your needs: `vim $MYHOSTNAME.env`
* Link the .env file: `ln -s $MYHOSTNAME .env`
* `docker-compose up`


# First login

* Username: admin
* Password: password

# Known errors

At first startup you might get the error message:

```
Undefined table: 7 ERROR:  relation "ttrss_version" does not exist
```

This vanishes at the second startup.
