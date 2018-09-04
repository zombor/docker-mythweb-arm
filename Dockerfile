FROM armhf/alpine
MAINTAINER Jeremy Bush <contractfrombelow@gmail.com>

LABEL caddy_version="0.11.0" architecture="ARMv7"

RUN apk update && apk add --no-cache ca-certificates openssh-client tar wget

# install caddy
RUN wget https://github.com/mholt/caddy/releases/download/v0.11.0/caddy_v0.11.0_linux_arm7.tar.gz && \
 tar -xzvf caddy_v0.11.0_linux_arm7.tar.gz && \
 mv caddy /usr/bin && \
 chmod 0755 /usr/bin/caddy && \
 /usr/bin/caddy -version

EXPOSE 2015
VOLUME /root/.caddy
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile

RUN wget https://github.com/MythTV/mythweb/archive/v29.1.tar.gz && \
 tar -zxvf v29.1.tar.gz --strip-components=1 -C . && rm -rf v29.1.tar.gz

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
