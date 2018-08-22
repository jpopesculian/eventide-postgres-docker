FROM postgres:latest

RUN apt-get update

ENV BUILD_DEPS=' \
    autoconf \
    automake \
    bison \
    bzip2 \
    dpkg-dev \
    dpkg-dev \
    file \
    g++ \
    gcc \
    imagemagick \
    libbz2-dev \
    libc6-dev \
    libcurl4-openssl-dev \
    libdb-dev \
    libevent-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm-dev \
    libgeoip-dev \
    libglib2.0-dev \
    libjpeg-dev \
    libkrb5-dev \
    liblzma-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libpng-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    make \
    patch \
    ruby \
    wget \
    xz-utils \
    zlib1g-dev \
'
RUN apt-get install -y --no-install-recommends $BUILD_DEPS

RUN wget https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.1.tar.gz
RUN tar -xzf ruby-2.5.1.tar.gz
RUN cd ruby-2.5.1 && ./configure && make && make install

RUN gem install eventide-postgres

RUN rm ruby-2.5.1.tar.gz
RUN rm -rf ruby.2.5.1
RUN apt-get remove --purge -y $BUILD_DEPS
RUN apt-get autoremove -y

COPY ./start /start

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["/start"]
