FROM php:7.4-fpm-buster


RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libicu-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libonig-dev \
	libzip-dev \
	libpng-dev \
	libxslt1-dev \
	sendmail-bin \
	sendmail \
	sudo

RUN docker-php-ext-configure \
  gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
	dom \
	gd \
	intl \
	mbstring \
	pdo_mysql \
	xsl \
	zip \
	soap \
	bcmath \
	pcntl \
	sockets

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY index.html /usr/share/nginx/html
COPY image2.png /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY nginx.crt /etc/ssl/
COPY nginx.key /etc/ssl/

