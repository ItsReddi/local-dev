FROM webdevops/php-nginx:ubuntu-16.04

RUN apt-get update && \
    apt-get install -y curl php7.0-imap && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ntp

RUN composer global require "fxp/composer-asset-plugin:~1.1.1"
RUN echo "Europe/Berlin" > /etc/timezone
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

#ports
EXPOSE 80
#EXPOSE 3306
RUN echo date.timezone = "Europe/Berlin" >> /opt/docker/etc/php/php.ini

#env
ENV WEB_DOCUMENTROOT /app/frontend/web

#possible moutns
VOLUME ["/app"]

WORKDIR /app


#onstart
#CMD ["/bin/bash", "/init.sh"]