FROM pixelchrome/caddy-arm
MAINTAINER Jeremy Bush <contractfrombelow@gmail.com>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
 apt-get update && \
 apt-get install --no-install-recommends -qy ca-certificates php7.0 php7.0-fpm && \
 apt-get clean

RUN wget https://github.com/MythTV/mythweb/archive/fixes/29.tar.gz && \
  mkdir mythweb && \
  tar -C mythweb --strip-components=1 -zxvf 29.tar.gz && \
  rm -rf 29.tar.gz
