FROM alpine:3.7

LABEL description "Multipurpose rss reader, live stream, mashup, aggregation web application" \
      maintainer="Hardware <contact@meshup.net>"

ARG VERSION=selfoss-2.18-5339432.zip
ARG SHA256_HASH="ee3f6a13b245e336c949d009e7bf2c195ea243639f956271c188663eebb3a24c"

ENV GID=991 UID=991 CRON_PERIOD=15m

RUN echo "@community http://nl.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories \
 && apk -U upgrade \
 && apk add -t build-dependencies \
    wget \
    git \
 && apk add \
    musl \
    nginx \
    s6 \
    su-exec \
    libwebp \
    ca-certificates \
    php7@community \
    php7-fpm@community \
    php7-gd@community \
    php7-json@community \
    php7-zlib@community \
    php7-xml@community \
    php7-dom@community \
    php7-curl@community \
    php7-iconv@community \
    php7-mcrypt@community \
    php7-pdo_mysql@community \
    php7-pdo_pgsql@community \
    php7-pdo_sqlite@community \
    php7-ctype@community \
    php7-session@community \
    php7-mbstring@community \
    tini@community \
 && wget -q https://github.com/SSilence/selfoss/releases/download/$VERSION/selfoss-$VERSION.zip -P /tmp \
 && CHECKSUM=$(sha256sum /tmp/selfoss-$VERSION.zip | awk '{print $1}') \
 && if [ "${CHECKSUM}" != "${SHA256_HASH}" ]; then echo "Warning! Checksum does not match!" && exit 1; fi \
 && mkdir /selfoss && unzip -q /tmp/selfoss-$VERSION.zip -d /selfoss \
 && sed -i -e 's/base_url=/base_url=\//g' /selfoss/defaults.ini \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/* /tmp/*

COPY rootfs /
RUN chmod +x /usr/local/bin/run.sh /services/*/run /services/.s6-svscan/*
VOLUME /selfoss/data
EXPOSE 8888
CMD ["run.sh"]
