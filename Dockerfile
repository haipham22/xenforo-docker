FROM php:7.3-fpm-alpine

RUN mkdir -p /app

# Set working directory
WORKDIR /app

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions \
    && sync \
    && install-php-extensions @composer gd pdo_mysql mysqli zip exif \
    memcached curl exif ftp iconv mbstring  \
    mcrypt mysqli opcache pcntl simplexml xml zip imagick gd pdo_mysql \
    && rm -rf /var/cache/apk/*

#RUN chmod 0777 /app/internal_data && \
#    chmod 0777 /app/data

ENTRYPOINT ["php-fpm"]
