FROM perl:latest
RUN cpan App::Sqitch && \
    cpan DBD::Pg && \
    cpan DBD::mysql && \
    apt-get update && \
    apt-get install postgresql-client-common postgresql-client mysql libdbd-mysql-perl -y --no-install-recommends && \
    apt-get clean
VOLUME [/src]
WORKDIR /src
CMD ["sqitch"]