FROM wonderfall/nginx-php:7.1

LABEL description "Multipurpose rss reader, live stream, mashup, aggregation web application" \
      maintainer="Hardware <contact@meshup.net>"

ARG VERSION="2.18-77d57d1"
# Note: bintray doesn't publish checksums, but publishes GPG signatures.
# When updating the version, download the zip and .asc signature, check the
# signature, and if it's good, get the sha256sum of the zip file.
ARG SHA256_HASH="b3698db0f3757f77c84bd779407ee7664749b5307b0e5057e17251534fa3ed7a"

ENV GID=991 UID=991 CRON_PERIOD=15m UPLOAD_MAX_SIZE=25M MEMORY_LIMIT=128M

RUN apk -U upgrade \
 && apk add -t build-dependencies \
    wget \
    git \
 && apk add \
    musl \
    libwebp \
    ca-certificates \
 && wget -q "https://bintray.com/fossar/selfoss/download_file?file_path=selfoss-$VERSION.zip" -O "/tmp/selfoss-$VERSION.zip" \
 && CHECKSUM=$(sha256sum /tmp/selfoss-$VERSION.zip | awk '{print $1}') \
 && if [ "${CHECKSUM}" != "${SHA256_HASH}" ]; then echo "Warning! Checksum does not match!" && exit 1; fi \
 && mkdir /selfoss && unzip -q /tmp/selfoss-$VERSION.zip -d /selfoss \
 && sed -i -e 's/base_url=/base_url=\//g' /selfoss/defaults.ini \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/* /tmp/*

COPY rootfs /
RUN chmod +x /usr/local/bin/* /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*
VOLUME /selfoss/data
EXPOSE 8888
CMD ["run.sh"]
