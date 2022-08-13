FROM php:8-fpm

RUN apt-get update && apt-get install -y \
    git \
    vim \
    unzip \
    libicu-dev \
    curl \
    librabbitmq-dev \
    libssh-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install php-cs-fixer
RUN curl -L https://cs.symfony.com/download/php-cs-fixer-v3.phar -o /usr/local/bin/php-cs-fixer && chmod a+x /usr/local/bin/php-cs-fixer

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/UTC /etc/localtime

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql calendar bcmath intl

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
