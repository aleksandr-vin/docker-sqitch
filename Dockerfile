FROM perl:latest
MAINTAINER Aleksandr Vinokurov <aleksandr.vin@gmail.com>
# Based on https://github.com/meticulo3366/docker-sqitch

# Postgres support

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client \
    postgresql-client-common \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN cpan \
    App::Sqitch \
    DBD::Pg \
 && rm -rf .cpan/{build,sources}

# MySQL support

RUN apt-get update && apt-get install -y --no-install-recommends \
    libdbd-mysql-perl \
    mysql-client \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN cpan \
    DBD::mysql \
 && rm -rf .cpan/{build,sources}

# Remove dev packages
RUN bash -c 'apt purge -y $(apt list 2>/dev/null | grep \\-dev | cut -d/ -f 1 )' \
 && apt purge -y \
    bzr \
    git \
    hicolor-icon-theme \
    libmagic* \
    m4 \
    make \
    mercurial* \
    subversion \
 && apt-get autoremove -y

ENTRYPOINT ["sqitch"]
CMD ["--help"]
