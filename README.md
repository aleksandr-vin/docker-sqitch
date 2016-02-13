# docker-sqitch

This repository contains Dockerfile of sqitch for Docker


## Docker Hub

Pull image from the automated build:

    $ docker pull aleksandrvin/sqitch


## Build image

    $ docker build -t sqitch .


## Usage


### See Help

As `sqitch --help`:

    $ docker run -it --rm aleksandrvin/sqitch


### Configure User

    $ docker run --rm -it -v ~/.sqitch:/root/.sqitch aleksandrvin/sqitch \
      config --user user.name 'Aleksandr Vinokurov'
    $ docker run --rm -it -v ~/.sqitch:/root/.sqitch aleksandrvin/sqitch \
      config --user user.email 'aleksandr.vin@gmail.com'
    $ docker run --rm -it -v ~/.sqitch:/root/.sqitch aleksandrvin/sqitch \
      config --user --list
    user.email=aleksandr.vin@gmail.com
    user.name=Aleksandr Vinokurov


### Hosted DBMS Deploy

For Postgres:

    $ docker run -it --rm -v ~/.sqitch:/root/.sqitch \
      -v $(pwd):/flipr --workdir=/flipr aleksandrvin/sqitch \
      deploy db:pg://user@host:port/dbname

For Mysql:

	$ docker run -it --rm -v ~/.sqitch:/root/.sqitch \
      -v $(pwd):/flipr --workdir=/flipr aleksandrvin/sqitch \
      deploy db:mysql://user@host:port/dbname


### Containerized DBMS Deploy

#### Postgres

Running postgres container:

    $ docker run --name db.localhost \
      -e POSTGRES_USER=someuser \
      -e POSTGRES_PASSWORD=somepasswd \
      --publish 5432:5432 -d postgres:9.5

Creating somedb:

    $ docker run -it --rm --link db.localhost:postgres postgres \
      sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" \
             -p "$POSTGRES_PORT_5432_TCP_PORT" -U someuser'
    Password for user someuser:
    psql (9.5.0)
    Type "help" for help.

    someuser=# create database somedb;
    CREATE DATABASE
    someuser=# ^D\q

Deploy on it:

    $ docker run -it --rm --link db.localhost:postgres --entrypoint=sh \
          -v ~/.sqitch:/root/.sqitch -v $(pwd):/flipr --workdir=/flipr \
          sqitch -c 'sqitch deploy "db:pg://someuser:somepoasswd@$POSTGRES_PORT_5432_TCP_ADDR:$POSTGRES_PORT_5432_TCP_PORT/somedb"'

    Adding registry tables to db:pg://someuser:@172.17.0.3:5432/somedb
    Deploying changes to db:pg://someuser:@172.17.0.3:5432/somedb
      + appschema .. ok
