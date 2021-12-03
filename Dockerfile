FROM ubuntu:focal

ENV timezone=America/Sao_Paulo

RUN apt update && \
    ln -snf /usr/share/zoneinfo/${timezone} /etc/localtime && echo ${timezone} > /etc/timezone && \
    apt install zip -y && \
    apt install apache2 -y && \
    apt install php -y && \
    apt install phpunit -y && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    apt install php7.4-pdo -y && \
    apt install php7.4-zip -y && \
    apt install php7.4-mysql -y && \
    apt install php-xdebug -y && \
    apt install git -y && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && rm composer-setup.php && mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer

EXPOSE 80

WORKDIR /var/www/html

ENTRYPOINT /etc/init.d/apache2 start && /bin/bash

CMD [ "true" ]
