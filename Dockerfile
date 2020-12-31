FROM registry.fedoraproject.org/f33/s2i-core

ENV SUMMARY="Base PHP image which allows using of source-to-image, PHP commands and Smarty templates."	\
    DESCRIPTION="The s2i-php image provides any images layered on top of it \
with all the tools needed to use PHP and/or source-to-image functionality while keeping \
the image size as small as possible." \
    NAME=fedora-s2i-php \
    VERSION=33 \
    PHP_MEMORY_LIMIT="128M" \
    PHP_MAX_EXECUTION_TIME="30" \
    PHP_MAX_INPUT_TIME="60" \
    PHP_DISPLAY_ERRORS="Off" \
    PHP_DISPLAY_STARTUP_ERRORS="Off"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="fedora-s2i-php" \
      com.redhat.component="$NAME" \
      name="$FGC/$NAME" \
      version="$VERSION" \
      usage="This image is supposed to be used as a base image for other images that support PHP or source-to-image" \
      maintainer="Stephen Cuppett <steve@cuppett.com>"

# install the basic PHP CLI environment
RUN set -ex; \
    \
    dnf -y install \
        bzip2 \
        git \
        patch \
        unzip \
        wget \
        which \
        php-cli \
        php-process \
        php-Smarty \
    ; \
# reset dnf cache
    dnf -y clean all; \
    rm -rf /var/cache/dnf

COPY smarty /usr/local/src/smarty
COPY php-entrypoint.sh /usr/local/bin

RUN set -ex; \
# set permissions up on the runtime locations
    mkdir -p /usr/local/src/smarty/{templates_c,cache}; \
# Fixing user location and executables
    chmod 755 /usr/local/bin/php-entrypoint.sh ; \
    chgrp -R 0 /etc/php* ; \
    chmod g+w -R /etc/php* ; \
    chgrp -R 0 /usr/local/src/* ; \
    chmod g+w -R /usr/local/src/* ; \
# Configuring initial PHP runtime
    sed '/^variables_order/d' < /etc/php.ini > /etc/php.ini ; \ 
    /usr/bin/php /usr/local/src/smarty/compile_templates.php ; \
    /usr/bin/php /usr/local/src/smarty/process_templates.php

USER 1001

ENTRYPOINT ["/usr/local/bin/php-entrypoint.sh"]
