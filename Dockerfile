FROM arm32v7/php:7.3-apache

RUN a2enmod rewrite
RUN a2enmod env

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

LABEL maintainer="Jeremy Bush <jeremy.bush@zombor.net>"

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/MythTV/mythweb/archive/v31.0.tar.gz && \
 tar -zxvf v31.0.tar.gz --strip-components=1 -C /var/www/html/ && rm -rf v31.0.tar.gz

ENV MYTHTV_BRANCH fixes/31
ENV MYTHTV_SCM_BASE https://raw.githubusercontent.com/MythTV/mythtv/${MYTHTV_BRANCH}
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythBackend.php           /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythBase.php              /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythFrontend.php          /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTV.php                /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVChannel.php         /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVProgram.php         /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVRecording.php       /var/www/html/classes/
ADD ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVStorageGroup.php    /var/www/html/classes/

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

COPY mythweb.conf /etc/apache2/sites-enabled/
