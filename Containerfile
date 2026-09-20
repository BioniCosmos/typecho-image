FROM docker.io/dunglas/frankenphp:1-alpine
ENV SERVER_NAME=:80
COPY patch /app/patch
RUN adduser -SH typecho && \
    setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/frankenphp && \
    chown -R typecho /config/caddy /data/caddy && \
    apk add --no-cache su-exec && \
    mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    cd /app/public && \
    rm * && \
    curl -OL https://github.com/typecho/typecho/releases/download/v1.3.0/typecho.zip && \
    unzip typecho.zip && \
    mv usr _usr && \
    rm typecho.zip && \
    mv /app/patch/index.php . && \
    mv /app/patch/install.php . && \
    mv /app/patch/admin-common.php admin/common.php && \
    mv /app/patch/docker-php-entrypoint /usr/local/bin && \
    chmod +x /usr/local/bin/docker-php-entrypoint && \
    rm -r /app/patch
